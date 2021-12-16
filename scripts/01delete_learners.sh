#!/bin/bash

# IP address of the ftp server
server_ip="192.168.100.42"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
lists_dir="lists"
scripts_dir="scripts"

delete_list_file="ezl_learners_to_delete.csv"

# Install ncftp if it does not exist
sudo apt install -y ncftp


# Stop Kolibri and baseline. Take a database backup
python -m kolibri stop
sudo service nginx stop
forever stopall
~/.scripts/backupdb/backup.sh

# Go to kolibri helper scripts directory
cd ~/.kolibri_helper_scripts || exit

# remove all existing csv files
rm "*.csv"

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$lists_dir/*.csv"

# Delete learners
python delete_learners.py -f $delete_list_file