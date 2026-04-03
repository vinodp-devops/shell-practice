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
    else
        echo "$2 ... SUCCESS" | tee -a $LOGS_FILE
    fi
}

REMOVE_PACKAGE() {
    if [ $1 != 0 ]; then
        echo "$2 ... FAILURE" | tee -a $LOGS_FILE
    else
        echo "$2 ... SUCCESS" | tee -a $LOGS_FILE
    fi
}

# sudo sh 14-loops.sh nginx mysql nodejs
for package in $@
do
    dnf install $package -y &>> $LOGS_FILE
    VALIDATE $? "Installing $package"
done

# sudo sh 14-loops.sh nginx mysql nodejs
for package in $@
do
    dnf remove $package -y &>> $LOGS_FILE
    REMOVE_PACKAGE $? "Removed $package"
done


# MODULES=("nginx" "mysql" "nodejs")

# for module in ${MODULES[@]}
# do
#     dnf install $module -y &>> $LOGS_FILE 
#     VALIDATE $? "Installing $module"
# done