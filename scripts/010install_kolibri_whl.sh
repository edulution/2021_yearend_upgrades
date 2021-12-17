#!/bin/bash

# IP address of the ftp server
server_ip="192.168.8.100"

ftp_uname="sigmoid"
ftp_pass="vadertime"

# directory containing the files required
pkgs="pkgs"

new_kolibri_whl_file="kolibri-0.13.0.dev0+git.20211217121959-py2.py3-none-any.whl"

# Go to kolibri helper scripts directory
cd ~|| exit

# remove static files
rm -rf ~/.kolibri/static

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$pkgs/$new_kolibri_whl_file"

sudo mv $new_kolibri_whl_file /opt

# Uninstall existing kolibri
sudo pip uninstall -y kolibri

# Install psycopg2 binary
sudo pip install psycopg2-binary

# Delete learners
sudo pip install /opt/$new_kolibri_whl_file


# generate kolibri static files
kolibri manage collectstatic