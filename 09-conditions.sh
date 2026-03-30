#!/bin/bash

NUMBER=$1

#-gt -> greater than
#-lt -> less than
#-eq -> equals
#-ne -> not equal
if [$NUMBER -gt 20]; then
    echo "Given number: $NUMBER is greater than 20"
elif [ $NUMBER -eq 20 ]; then
    echo "Given number: $NUMBER is equals to 20"
else
    echo "Given number: $NUMBER is less than 20"
fi