#!/bin/bash

# IP address of the ftp server
server_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
scripts_dir="scripts"


delete_classrooms_script="delete_all_classrooms.py"

# Go to kolibri helper scripts directory
cd ~|| exit

# remove all existing py files
rm "*.py"

# remove all existing py files in home directory
rm ~/Downloads/*.py

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$scripts_dir/$delete_classrooms_script"

# Delete learners
python $delete_classrooms_script

# Remove the file
rm $delete_classrooms_script