#!/bin/bash

#This script installs httpd, wget and unzip which it will then use to create a webpage using a template from a site (eg:https://www.tooplate.com). 
#The script requieres two arguments:
#1st argument is the download URL of the template (eg: https://www.tooplate.com/zip-templates/2102_constructive.zip)
#2nd argument is the name of the template (eg: 2102_constructive)

# Variable Declaration
PACKAGE="httpd wget unzip"
SVC="httpd"
TEMPDIR="/tmp/webfiles"

if [ "$#" -eq 0 ] ; then
        echo "Insert as first argument the URL and as the second argument the name of the template"
        exit 0
fi


# Installing Dependencies: wget, unzip and httpd
echo "Installing Packages"
sudo yum install $PACKAGE -y > /dev/null

# Start and Enable httpd service
echo "Starting and enabling httpd service"
sudo systemctl enable --now $SVC

# Creating a temporary directory for the files, unzip them and copy to the files to /var/www/html
echo "Starting the Deployment"
mkdir -p $TEMPDIR
cd $TEMPDIR
wget $1 > /dev/null
unzip $2 > /dev/null
sudo cp -r $2/* /var/www/html/

echo "Restart httpd service"
sudo systemctl restart $SVC

echo "Cleaninig up the temporary files"
sudo rm -rf $TEMPDIR

# Display the status of the httpd service and the content of /var/www/html
sudo systemctl status