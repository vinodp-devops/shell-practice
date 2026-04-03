#!/bin/bash

set -e
trap 'echo "There is an error in line $LINENO, Command: $BASH_COMMAND"' ERR

R="\e[31m"
G="\e[32m"
Y="\e[33m"
P="\e[35m"
N="\e[0m"

USERID=$(id -u)

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0")
LOGS_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p "$LOGS_FOLDER"

if [ "$USERID" -ne 0 ]; then
    echo -e "${R}Please run this script with root access${N}" | tee -a "$LOGS_FILE"
    exit 1
fi

for package in "$@"
do
    if ! dnf list installed "$package" &>> "$LOGS_FILE"; then
        echo -e "${P}$package not installed, installation started...${N}"
        dnf install "$package" -y &>> "$LOGS_FILE"
    else
        echo -e "$package already installed, ${Y}SKIPPING${N}"
    fi
done