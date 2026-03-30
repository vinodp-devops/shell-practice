#!/bin/bash

#### Special Variables ####
echo "All args passed to script: $@"
echo "All args passed to script: $*"
echo "Number of vars passed to script: $#"
echo "Script name: $0"
echo "Present directory: $PWD"
echo "Who is running: $USER"
echo "Home directory of current user: $HOME"
echo "PID of this script: $$"
sleep 100 &
echo "PID of recently executed background process: $!"
echo "Exit status of previous command: $?"
#$?
#============
#0-127
#0 -> Success
# Anything else -> failure

# sh 07-variables Rama Vinod