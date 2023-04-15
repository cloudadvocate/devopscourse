#!/bin/bash

# This shell script covers Shell Scripting Decision Making and Demo of decision making with other Operators


#===============syntax====================
# if [ condition ]
# then
#     ------
# else
#     ------
# fi
#=========================================

# assign two variables a and b to demonstrate variables
VARA=60
VARB=30
VARC=$VARA

# if condition with -eq operation

if [ $VARA -eq $VARC ]
then
    echo "VARA equals VARC"
fi

# if condition with -ne operation

if [ $VARA -ne $VARB ]
then
    echo "VARA not equals VARB"
else
    echo "VARA equals VARB"
fi

# if condition with -gt operation

if [ $VARA -gt $VARB ]
then
    echo "VARA greater than VARB"
fi

# if condition with -lt operation

if [ $VARA -lt $VARB ]
then
    echo "VARA less than VARB"
else
    echo "VARA greater than VARB"
fi

# if condition with -ge operation

if [ $VARA -ge $VARC ]
then
    echo "VARA greater than or equal to VARB"
fi

# and boolean operation

if [ $VARA -lt $VARB -a $VARA -ge $VARC ]
then
    echo "Condition VARA < VARB and VARA >= VARC is true"
else 
    echo "Condition VARA < VARB and VARA >= VARC is false"
fi

# or boolean operation

if [ $VARA -lt $VARB -o $VARA -ge $VARC ]
then
    echo "Condition VARA < VARB or VARA >= VARC is true"
else 
    echo "Condition VARA < VARB or VARA >= VARC is false"
fi


# String Operations using if else

NAME1="ZIVA"
NAME2="RIYA"
NAME3=$NAME1
NAMEEMPTY=""

# Check if both the string are equal and not equal

if [ $NAME1 =  $NAME2 ]
then
    echo "$NAME1 is equal to $NAME2"
else
    echo "$NAME1 is not equal to $NAME2"
fi

if [ $NAME1 !=  $NAME2 ]
then
    echo "$NAME1 is not equal to $NAME2"
else
    echo "$NAME1 is equal to $NAME2"
fi

# check if string is empty

if [ -z $NAMEEMPTY ]
then
    echo "NAMEEMPTY is empty"
fi














