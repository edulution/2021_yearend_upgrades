#!/bin/bash

# Go to kolibri helper scripts directory
cd ~/.kolibri_helper_scripts || exit

# remove all existing csv files
rm "*.csv"

# Delete learners
python setup.py