#!/bin/bash

# Clean up downloads directory
cd ~/Downloads || exit

rm -f -- *.csv
rm -f -- *.R
rm -f -- *.py
rm -f -- *.whl
rm -f -- *.sh
rm -f -- *.zip
rm -f -- *.gz
rm -f -- *.backup
rm -f -- *.png


# Clean up home directory
cd ~ || exit

rm -f -- *.csv
rm -f -- *.R
rm -f -- *.py
rm -f -- *.whl
rm -f -- *.sh
rm -f -- *.zip
rm -f -- *.gz
rm -f -- *.backup
rm -f -- *.png

rm -rf new*
rm -rf content*


# Clean up desktop
cd ~/Desktop || exit
rm -f -- *.csv
rm -f -- *.R
rm -f -- *.py
rm -f -- *.whl
rm -f -- *.sh
rm -f -- *.zip
rm -f -- *.gz
rm -f -- *.backup
rm -f -- *.png

rm -rf new*
rm -rf content*



# Clean up backups directory
cd ~/backups || exit

# Remove any file that begins with an underscore. It is likely a currupt backup
rm -f -- _*
rm -f -- *.csv
rm -f -- *.R
rm -f -- *.py
rm -f -- *.whl
rm -f -- *.sh
rm -f -- *.gz
rm -f -- *.backup