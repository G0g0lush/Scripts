#!/bin/bash

#This script checks if a given process is running or not. If the process is stopped, the script will try to start and enable the process.

#Give a message if no argument is given
if [ "$#" -eq 0 ] ; then
        echo "You have to insert an argument, which is the name of the process you want to check!"
        exit 0
fi

echo "###############"
date

#Check if the pid file is created. If the file is not there, the process will be started. At the end, it will check if the process has started successfully or not.
if [ -f /var/run/*/$1.pid ]; then
        echo "The $1 process is running!"
else
        echo "The $1 process is not running!"
        echo "Starting the process..."
        systemctl enable --now $1
        if [ $? -eq 0 ]; then
                echo "Process started successfully!"
        else
                echo "Process starting failed, contact the admin!!!"
        fi
fi

echo "###############"

systemctl status $1
