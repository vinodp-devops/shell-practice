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
echo "First Fruit is: ${FRUITS[0]}"
echo "Second Fruit is: ${FRUITS[1]}"
echo "Third Fruit is: ${FRUITS[2]}"