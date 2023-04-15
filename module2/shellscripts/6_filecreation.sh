#!/bin/bash

# to used in cron */1 * * * * <script> <folder-path-cron-files>

# validates whether folder path is provided
if [ -z $1 ]
then 
    echo "usage $0 <folder-to-create-cronfile>"
    exit 1
fi

FOLDERPATH=$1

# check whether folder path exists
if [ ! -e $FOLDERPATH ]
then
    echo "Folder Path $FOLDERPATH does not exists"
    exit 1
fi

# check path provided is directory
if [ ! -d $FOLDERPATH ]
then
    echo "Folder Path $FOLDERPATH is not a directory"
    exit 1
fi

FILENAME="cronfile-`date +"%y%m%d%H%M"`"

if [ ! -e $FOLDERPATH/$FILENAME ]
then
    echo "creating file $FILENAME"
    touch $FOLDERPATH/$FILENAME
else
    echo "File $FILENAME alrady exist"
fi