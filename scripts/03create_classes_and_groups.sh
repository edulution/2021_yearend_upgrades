#!/bin/bash

# IP address of the ftp server
server_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
lists_dir="lists"

centre_grades_list="ezl_centre_grades.csv"

# Go to kolibri helper scripts directory
cd ~/.kolibri_helper_scripts || exit

# remove all existing csv files
rm "*.csv"

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$lists_dir/*.csv"

# Delete learners
python create_classes_and_groups.py -f $centre_grades_list