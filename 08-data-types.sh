#!/bin/bash

NUM1=100
NUM2=200
NUM3=300
NAME=Vinod

SUM=$((NUM1+NUM2+NUM3))
echo "Sum is $SUM, $NAME"

#Array
FRUITS=("Apple" "Banana" "Pomo")

echo "Fruits are: ${FRUITS[@]}"
