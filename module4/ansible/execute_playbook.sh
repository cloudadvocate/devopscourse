#!/bin/bash

if [[ -z $1 ]]
then
    echo "usage $0 <private-key-path>"
    exit 1
fi

ansible-playbook playbook.yaml -i hosts --key-file "$1"
