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


# Write the list of six months inactive users to a txt file
# The name of the file is prefixed with the default facility name
file = open(def_facility + "_6months_inactive.txt", "w")
for user_ids in inactive_more_than_six_months:
    file.writelines(user_ids + "\n")
file.close()
