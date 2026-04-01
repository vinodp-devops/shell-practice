#!/bin/bash

USERID=$(id -u)

if [ $USERID != 0 ]; then
    echo "Please run this script with root user access"
    exit 1
fi

VALIDATE() {
    if [ $1 != 0 ]; then
        echo "$2 ... FAILURE"
        exit 1
    else
        echo "$2 ... SUCCESS"
    fi
}

dnf install nginx -y
VALIDATE $? "Installing Nginx"

dnf install mysql -y
VALIDATE $? "Installing MySQL"

dnf install nodejs -y
VALIDATE $? "Installing NodeJS"