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

VALIDATE() {
    if [ $1 != 0 ]; then
        echo "$2 ... FAILURE" | tee -a $LOGS_FILE
        exit 1
    else
        echo "$2 ... SUCCESS" | tee -a $LOGS_FILE
    fi
}

# sudo sh 15-loops.sh nginx mysql nodejs
for package in $@
do
    dnf list installed $package &>> $LOGS_FILE
    if [ $? != 0 ]; then
        echo "$package not installed, installation started..."
        dnf install $package -y &>> $LOGS_FILE
        VALIDATE $? "Installing $package..!"
    else
        echo "$package already installed, skipping"
    fi
done

