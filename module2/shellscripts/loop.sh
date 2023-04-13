#!/bin/bash

# print number starting from 0 and end when number is equal to 5, check if the starting number is less than 10

a=0
while [ $a -lt 10 ]
do
   echo $a
   if [ $a -eq 5 ]
   then
        break
   fi
   a=`expr $a + 1`
done


# Loops through number and find out odd and even numbers

NUMS="1 2 3 4 5 6 7"
for NUM in $NUMS
do
   Q=`expr $NUM % 2`
   if [ $Q -eq 0 ]
   then
      echo "Number is an even number!!"
   else
      echo "Found odd number"
   fi
done