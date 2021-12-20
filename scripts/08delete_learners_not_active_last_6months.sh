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
scripts_dir="scripts"
inactive_learners_upload_dir="inactive_six_months"
latest_txt_file_path=$( ls ~/.kolibri_helper_scripts/*.txt -t | head -n1 )
latest_txt_file=$( basename -- "$latest_txt_file_path")

fetch_6_months_inactive="get_six_months_inactive_list.py"
six_month_inactive_script="delete_learners_inactive_more_than_6_months.py"

# Go to kolibri helper scripts directory
cd ~ || exit

# remove all existing py files
rm "*.py"

# remove all existing py files in home directory
rm ~/Downloads/*.py

cd ~/.kolibri_helper_scripts || exit

# Download files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$scripts_dir/$six_month_inactive_script"
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$scripts_dir/$fetch_6_months_inactive"


# Delete learners
python $fetch_6_months_inactive

ncftpput -u $ftp_uname -p $ftp_pass $server_ip /$inactive_learners_upload_dir $latest_txt_file


# Delete learners
python $six_month_inactive_script

# Remove the file
rm $fetch_6_months_inactive
rm $six_month_inactive_script
