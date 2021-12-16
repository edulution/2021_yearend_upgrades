#!/bin/bash

# IP address of the ftp server
server_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
scripts_dir="scripts"


titlecase_fullnames_script="titlecase_fullnames.py"

# Go to kolibri helper scripts directory
cd ~ || exit

# remove all existing py files
rm "*.py"

# remove all existing py files in home directory
rm ~/Downloads/*.py

cd ~/.kolibri_helper_scripts || exit

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$scripts_dir/$titlecase_fullnames_script"

# Delete learners
python $titlecase_fullnames_script

# Remove the file
rm $titlecase_fullnames_script