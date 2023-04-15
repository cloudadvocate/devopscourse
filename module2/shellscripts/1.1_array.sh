#!/bin/bash

#===============syntax====================
# array_name[index]=value
#=========================================

# assigning list of names to array NAME
NAME[0]="Anil"
NAME[1]="Karthik"
NAME[2]="Nyra"
NAME[3]="Hrithya"

#accessing name by index, Index starts from 0
echo "First Name by Index: ${NAME[0]}"
echo "Second Name by Index: ${NAME[1]}"

#accessing all elements in array
echo "Method1: ${NAME[*]}"
echo "Method2: ${NAME[@]}"
