#!/bin/bash

# assign two variables a and b to demonstrate variables
VARA=60
VARB=30

# Addition Operation

RESULT=`expr $VARA + $VARB`
echo "Addition value : $RESULT"


# Subtraction Operation

RESULT=`expr $VARA - $VARB`
echo "Subtraction value : $RESULT"

# Multiplication Operation

RESULT=`expr $VARA * $VARB`
echo "Multiplication value : $RESULT"

# Division Operation

RESULT=`expr $VARA / $VARB`
echo "Division value : $RESULT"

# Modulus Operation

RESULT=`expr $VARA % $VARB`
echo "Modulus value : $RESULT"

# Assignment Operation

VARC=$VARA 
echo "Access VARC: $VARC"
