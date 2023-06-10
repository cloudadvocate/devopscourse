#!/bin/bash

VERSION=1.0.0-SNAPSHOT
ARTIFACT_NAME=$(aws codeartifact list-package-version-assets --domain cloudadvocate --domain-owner 363267848264 --repository book-manager-repository --format maven --namespace com.cloudadvocate.java --package bookmanager --package-version 1.0.0-SNAPSHOT --query 'assets[0].name' | sed 's/\"//g')
SERVICE_PORT=8081

if [ ! -f  "dd-java-agent.jar" ] 
then
    wget -O dd-java-agent.jar 'https://dtdg.co/latest-java-tracer'
fi

if [ ! -f  "bookmanager.jar" ]
then
    aws codeartifact get-package-version-asset --domain cloudadvocate --domain-owner 363267848264 --repository book-manager-repository --format maven --namespace com.cloudadvocate.java --package bookmanager --package-version ${VERSION} --asset ${ARTIFACT_NAME} bookmanager.jar
fi
echo "starting java application with bookmanager"

java -javaagent:dd-java-agent.jar -Dserver.port=${SERVICE_PORT} -Ddd.logs.injection=true -jar bookmanager.jar 
