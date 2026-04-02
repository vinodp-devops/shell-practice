#!/bin/bash

# Gets the Userid root -> 0
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILENAME="$LOGS_FOLDER/$0.log"

if [ $USERID != 0 ]; then
    echo "Please run this script with root user access: sudo su -"
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE() {
    if [ $1 != 0 ]; then
        echo "$2 ... FAILURE"
        exit 1
    else
        echo "$2 ... SUCCESS"
    fi
}

VALIDATE2() {
    echo "$1 UNINSTALLATION ...SUCCESS "
}


dnf install nginx -y &>> $LOGS_FILENAME
VALIDATE $? "Installing Nginx"

dnf install mysql -y &>> $LOGS_FILENAME
VALIDATE $? "Installing MySQL"

dnf install nodejs -y &>> $LOGS_FILENAME
VALIDATE $? "Installing NodeJS"

dnf remove nginx -y &>> $LOGS_FILENAME
dnf remove mysql -y &>> $LOGS_FILENAME
dnf remove nodejs -y &>> $LOGS_FILENAME
VALIDATE2 "Done"