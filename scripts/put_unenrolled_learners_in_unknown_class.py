import kolibri  # noqa F401
import django
import sys
import uuid
import csv
import argparse
from django.contrib.auth.hashers import make_password
from django.core.exceptions import ObjectDoesNotExist

django.setup()

from kolibri.core.auth.models import (
    Facility,
    FacilityDataset,
    FacilityUser,
    Classroom,
    LearnerGroup,
    Membership,
)  # noqa E402


from helpers import *

# Get all users that are not coaches or admins
all_users_query = """select * from kolibriauth_facilityuser
where id not in
(select user_id from kolibriauth_role where kind in ('admin','coach'))"""

all_users = FacilityUser.objects.raw(all_users_query)

# Get all memberships
memberships = Membership.objects.all()

# Get all user_ids as a list
user_ids = [u.id for u in all_users]

# Get all users that have memberships as a list
users_with_memberships = [mem.user_id for mem in memberships]

# Get all users without memberships by filtering the two lists above against each other
users_without_memberships = [
    user_id for user_id in user_ids if user_id not in users_with_memberships
]

# Initialize counter
num_enrolled = 0

# Print number of unenrolled learners found
print("{} unenrolled learners found".format(len(users_without_memberships)))

# Loop through the users without memberships
# Add each user to a class called Unknown
for user_id in users_without_memberships:
    # Get a reference to the user object using the user_id
    user_obj = FacilityUser.objects.get(id=user_id)

    # Get a reference to the unknown class if it does not exist
    unknown_class = get_or_create_classroom("Unknown")

    # Create a membership object in the unknown class
    Membership.objects.create(user=user_obj, collection=unknown_class)

    # Increment counter
    num_enrolled += 1

    # Print out the full name of the user and the class they have been enrolled into
    print(
        "Created Membership for user: {} in Classroom {}".format(
            str(user_obj.full_name), str(unknown_class.name)
        )
    )

# Print the total number of learner that have been enrolled into the unknown class
print("{} user(s) were enrolled into the Unkown class".format(num_enrolled))
