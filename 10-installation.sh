#!/bin/bash

USERID=$(id -u)

if [ $USERID != 0 ]; then
    echo "Please run this script with root user access"
    exit 1
fi

echo "Installing Nginx"
dnf install nginx -y

if [ $? != 0 ]; then
    echo "Installing Nginx ... FAILURE"
    exit 1
else
    echo "Installing Nginx ... SUCCESS"
fi
