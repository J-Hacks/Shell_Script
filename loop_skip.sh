#!/bin/bash
# Initialize the variable
a=1
# Loop until a is greater than 100
while [ $a -le 100 ]
do
    echo $a
    a=$((a + 2))  # Increment a by 2
done

