#!/bin/bash

# Go into reports folder
cd ~/backups || exit

# Get 5 most recent backups
MOST_RECENT_BACKUPS=$( ls ~/backups -t | head -n5 )

server_ip=""
eduhub_ip="192.168.8.100"
mtn_ip="192.168.100.42"

upload_uname="sigmoid"
upload_passwd="vadertime"

upload_dir="backups"


ping -c5 -i3 $eduhub_ip
if [ $? -eq 0 ]
then server_ip=$eduhub_ip
else server_ip=$mtn_ip
fi

for file in "${MOST_RECENT_BACKUPS[@]}"
do
	ncftpput -u $upload_uname -p $upload_passwd $server_ip /$upload_dir $file
done
