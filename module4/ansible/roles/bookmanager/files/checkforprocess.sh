#!/bin/bash

processId=$(ps -ef | grep 'java -jar bookmanager.jar' | grep -v 'grep' | awk '{ printf $2 }')

if [[ -z "$processId" ]]
then
    echo "not running"
else
    echo "running"
fi