#!/bin/bash

set -e #ERR


R="\e[31m"
G="\e[32m"
Y="\e[33m"
P="\e[35m"
N="\e[0m"

# Gets the Userid root -> 0
USERID=$(id -u)
LOGS_FOLDER="/var/log/shell-script"
LOGS_FILE="$LOGS_FOLDER/$0.log"

trap 'echo "There is an error in $LINENO, Command: $BASH_COMMAND"' ERR &>> $LOGS_FILE

if [ $USERID != 0 ]; then
    echo -e "$R Please run this script with root user access: sudo su - $N" | tee -a $LOGS_FILE
    exit 1
fi

mkdir -p $LOGS_FOLDER

# sudo sh 15-loops.sh nginx mysql nodejs
for package in $@
do
    dnf list installed $package &>> $LOGS_FILE
    if [ $? != 0 ]; then
        echo -e "$P $package not installed, installation started... $N"
        dnf install $package -y &>> $LOGS_FILE
    else
        echo -e "$package already installed, $Y SKIPPING $N"
    fi
done