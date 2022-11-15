#!/bin/bash

#This script will copy the webpage_centos_ubuntu.sh file to remote hosts that are written in remotehosts file. 
#Before using this script make sure the USR variable contains a valid user from the remote servers.
#Before using this script make sure you exchanged SSH keys with the remote servers.

USR='devops'

#Reads the contents of remotehosts file. Connects to each host in the file and copies the script file, executes it and the deletes it.
for host in `cat remotehosts`
do
        echo "Connecting to $host"
        sleep 1
        echo "Pushing script to $host"
        scp webpage_centos_ubuntu.sh $USR@$host:/tmp/
        echo "Executing the script on $host"
        ssh $USR@$host sudo /tmp/webpage_centos_ubuntu
        ssh $USR@$host sudo rm -rf /tmp/webpage_centos_ubuntu
        echo
done
