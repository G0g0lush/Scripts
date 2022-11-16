#!/bin/bash

#This script installs httpd, wget and unzip, on CentOS and Ubuntu distributions, which it will then use to create a webpage using a template from https://www.tooplate.com. 
#This can be executed on remote servers using web_deply.sh script. (you can find it in the repo) 

#Variable Declaration
URL='https://www.tooplate.com/zip-templates/2102_constructive.zip'
ART_NAME='2102_constructive'
TEMPDIR="/tmp/webfiles"

yum --help &> /dev/null

if [ $? -eq 0 ] ; then
        #Set Variables for CentOS
        PACKAGE="httpd wget unzip"
        SVC="httpd"

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

else

        #Set Variables for Ubuntu
        PACKAGE="apache2 wget unzip"
        SVC="apache2"

        # Installing Dependencies: wget, unzip and httpd
        echo "Installing Packages"
        sudo apt update
        sudo apt install $PACKAGE -y > /dev/null

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
fi
