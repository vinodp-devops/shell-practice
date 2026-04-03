#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
P="\e[35m"
N="\e[0m"

# Gets the Userid root -> 0
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/$0.log"

if [ $USERID != 0 ]; then
    echo -e "$R Please run this script with root user access: sudo su - $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

VALIDATE() {
    if [ $1 != 0 ]; then
        echo -e "$R $2 ... FAILURE $N" | tee -a $LOGS_FILE
        exit 1
    else
        echo -e "$G $2 ... SUCCESS $N" | tee -a $LOGS_FILE
    fi
}

# sudo sh 15-loops.sh nginx mysql nodejs
for package in $@
do
    dnf list installed $package &>> $LOGS_FILE
    if [ $? != 0 ]; then
        echo -e "$P $package not installed, installation started... $N"
        dnf install $package -y &>> $LOGS_FILE
        VALIDATE $? "Installing $package..!"
    else
        echo -e "$package already installed, $Y SKIPPING $N"
    fi
done