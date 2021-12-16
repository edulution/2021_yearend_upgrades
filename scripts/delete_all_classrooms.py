import kolibri  # noqa F401
import django

django.setup()

from kolibri.core.auth.models import (
    Facility,
    FacilityUser,
    Classroom,
    LearnerGroup,
    Role,
)


print("Deleting all Classrooms...")

# Delete all classrooms
Classroom.objects.all().delete()

print("All Classrooms deleted")
