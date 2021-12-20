#!/bin/bash

server_ip=""
eduhub_ip="192.168.8.100"
mtn_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"


ping -c5 -i3 $eduhub_ip
if [ $? -eq 0 ]
then server_ip=$eduhub_ip
else server_ip=$mtn_ip
fi

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