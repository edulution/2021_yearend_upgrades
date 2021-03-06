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

r_pkgs_file="install_r_packages.R"

# Go to kolibri helper scripts directory
cd ~|| exit

# Download all csv files
ncftpget -u $ftp_uname -p $ftp_pass $server_ip . "$scripts_dir/$r_pkgs_file"

sudo add-apt-repository -y ppa:cran/ffmpeg-3
sudo add-apt-repository -y ppa:cran/imagemagick
sudo apt -y install libudunits2-dev libharfbuzz-dev libavfilter-dev libmagick++-dev cargo

# install dbhelpers package
sudo su - -c "R -e \"devtools::install_github('Aypak/dbhelpers')\""
sudo su - -c "R -e \"install.packages('fmsb')\""
sudo su - -c "R -e \"remotes::install_github('hrbrmstr/ggalt', ref = 'noproj')\""

sudo Rscript $r_pkgs_file

rm $r_pkgs_file