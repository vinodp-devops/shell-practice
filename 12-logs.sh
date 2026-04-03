#!/bin/bash

# Gets the Userid root -> 0
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID != 0 ]; then
    echo "Please run this script with root user access: sudo su -" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

if [ $? != 0 ]; then
    echo "Unable to create Directory $LOGS_FOLDER" | tee -a $LOGS_FILE
    exit 1
else
    echo "Directory $LOGS_FOLDER CREATED/Detected" | tee -a $LOGS_FILE
fi

VALIDATE() {
    if [ $1 != 0 ]; then
        echo "$2 ... FAILURE" | tee -a $LOGS_FILE
        exit 1
    else
        echo "$2 ... SUCCESS" | tee -a $LOGS_FILE
    fi
}

VALIDATE2() {
    echo "$1 UNINSTALLATION ...SUCCESS" | tee -a $LOGS_FILE 
}


dnf install nginx -y &>> $LOGS_FILE
VALIDATE $? "Installing Nginx"

dnf install mysql -y &>> $LOGS_FILE
VALIDATE $? "Installing MySQL"

dnf install nodejs -y &>> $LOGS_FILE
VALIDATE $? "Installing NodeJS"

# dnf remove nginx -y &>> $LOGS_FILE
# dnf remove mysql -y &>> $LOGS_FILE
# dnf remove nodejs -y &>> $LOGS_FILE
# VALIDATE2 "Done"