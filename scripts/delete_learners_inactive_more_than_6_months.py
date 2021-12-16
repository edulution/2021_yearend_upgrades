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

from django.utils import timezone
import datetime

from helpers import *

# Get all users. Exclude those that have never logged in
all_users = FacilityUser.objects.all().exclude(last_login__isnull=True)

# Get users whose last login was more than 6 months ago
inactive_more_than_six_months = [
    user.id
    for user in all_users
    if user.last_login < (timezone.now() - timezone.timedelta(days=180))
]

# Get the default facility name
def_facility = str(Facility.get_default_facility().name)

# Initialize counter
num_deleted = 0

# Loop through users that have been inactive more than 6 months
# Delete each user
for user_id in inactive_more_than_six_months:
    # Get a reference to the user object using the user_id
    user_obj = FacilityUser.objects.get(id=user_id)

    # Get the full name of the user to delete
    user_to_delete = str(user_obj.full_name)

    user_obj.delete()

    # Delete the user
    print("User {} deleted".format(user_to_delete))

    # Update counter
    num_deleted += 1

print("Done! {} users were deleted".format(num_deleted))
