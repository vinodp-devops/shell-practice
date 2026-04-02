#!/bin/bash

# Gets the Userid root -> 0
USERID=$(id -u)

if [ $USERID != 0 ]; then
    echo "Please run this script with root user access: sudo su -"
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

VALIDATE2() {
    echo "$1 ... UNINSTALLATION SUCCESS "
}


dnf install nginx -y
VALIDATE $? "Installing Nginx"

dnf install mysql -y
VALIDATE $? "Installing MySQL"

dnf install nodejs -y
VALIDATE $? "Installing NodeJS"

dnf uninstall nginx -y
dnf uninstall mysql -y
dnf uninstall nodejs -y
VALIDATE2 "Done"