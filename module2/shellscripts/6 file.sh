#!/bin/bash

#===================File Operations========================
# -e inspects file/folder exists
# -d validates path is a directory
# -f validates file is ordinary file or special file
# -r validates file is readble
# -s validates file size is greater than zero
#===========================================================



CWD=`pwd`

echo "Current working directory is $CWD"
cd $CWD

DEMO_DIR=demo
DEMO1_FOLDER_PATH=$DEMO_DIR/demo1
DEMO1_FOLDER_FILE=$DEMO1_FOLDER_PATH/demo1_file1
DEMO1_FOLDER_FILE2=$DEMO1_FOLDER_PATH/demo1_file2
DEMO1_FOLDER_FILE_SHELLSCRIPT=$DEMO1_FOLDER_PATH/demo1_file1.sh

bootstrap () {

echo "Creating directory to demo file operations"
mkdir -p $DEMO_DIR

mkdir -p $DEMO1_FOLDER_PATH
touch $DEMO1_FOLDER_FILE
echo "Welcome to demo" > $DEMO1_FOLDER_FILE

echo "echo 'demo shell script'" > $DEMO1_FOLDER_FILE_SHELLSCRIPT

}

cleanup () {
    rm -rf $DEMO_DIR
}


# Validate folder for demo exists

validate_folder () {
    if [ ! -e $DEMO1_FOLDER_PATH ]
    then 
        echo "$DEMO1_FOLDER_PATH folder does not exists"
        exit 1
    fi
    
}

# Validate files used for demo exists

validate_file () {
    if [ ! -e $DEMO1_FOLDER_FILE ]
    then 
        echo "$DEMO1_FOLDER_FILE does not exists"
        exit 1
    fi

    if [ ! -e $DEMO1_FOLDER_FILE_SHELLSCRIPT ]
    then
        echo "$DEMO1_FOLDER_FILE_SHELLSCRIPT shell script does not exists"
    fi

}

bootstrap
validate_folder
validate_file

# -x verifies provided file is executable

check_shell_script_is_executable () {
    if [ ! -x $DEMO1_FOLDER_FILE_SHELLSCRIPT ]
    then
        echo "$DEMO1_FOLDER_FILE_SHELLSCRIPT is not executable"
        echo "changing permissions of $DEMO1_FOLDER_FILE_SHELLSCRIPT"
        chmod 777 $DEMO1_FOLDER_FILE_SHELLSCRIPT
    fi
}

check_shell_script_is_executable

check_if_file_is_readable () {
    if [ -r $DEMO1_FOLDER_FILE ]
    then
        echo "$DEMO1_FOLDER_FILE  is readable"
    fi
}
check_if_file_is_readable

check_nonempty_file () {
    if [ -s $DEMO1_FOLDER_FILE ]
    then
        echo "$DEMO1_FOLDER_FILE is not empty"
    fi
}
check_nonempty_file

cleanup

