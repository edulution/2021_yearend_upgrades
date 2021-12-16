#!/bin/bash

# IP address of the ftp server
server_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
lists_dir="lists"

learner_grades_list="ezl_learners_grades.csv"

# Go to kolibri helper scripts directory
cd ~/.kolibri_helper_scripts || exit

# remove all existing csv files
rm "*.csv"

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$lists_dir/*.csv"

# Delete learners
python enroll_learners_into_class.py -f $learner_grades_list