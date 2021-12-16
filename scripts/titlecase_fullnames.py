import kolibri  # noqa F401
import django

django.setup()

from helpers import *

# Titlecase all fullnames using the helper function defined in helpers
titlecase_fullnames()
