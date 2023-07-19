#!/bin/bash

#Remember to open port 80 to see the website.
#This script installs httpd, wget and unzip which it will then use to create a webpage using a template from https://www.tooplate.com. 

# Variable Declaration
PACKAGE="httpd wget unzip"
SVC="httpd"
URL='https://www.tooplate.com/zip-templates/2102_constructive.zip'
ART_NAME='2102_constructive'
TEMPDIR="/tmp/webfiles"

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
wget $URL > /dev/null
unzip $ART_NAME.zip > /dev/null
cp -r $ART_NAME/* /var/www/html/

echo "Restart httpd service"
sudo systemctl restart $SVC

echo "Cleaninig up the temporary files"
rm -rf $TEMPDIR

# Display the status of the httpd service and the content of /var/www/html
sudo systemctl status $SVC
ls -la /var/www/html
