#!/bin/bash

# Function Syntax
# function_name () { 
#   list of commands
#}


# A simple function which prints the greeting message

# Function Defintion
Greetings () {
   echo "Hello Welcome to DevOps World"
}

# Function Invocation
Greetings


# A function which accepts name as parameters and print the name

#Function Definition
PrintName () {
    echo "Hello $1. Welcome to DevOps World"
}

# Function Invocation
PrintName "Akhil"


# A function which return value

#Function Definition

SUM () {
    result=`expr $1 + $2`
    return $result
}


# Function Invocation

SUM 12 14
SUM_RETURNED=$?

echo "Result of the function $SUM_RETURNED"






