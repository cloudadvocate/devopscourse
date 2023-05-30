#!/bin/bash

VERSION=1.0.0-20230511.021934-25.jar

if [ ! -f  "dd-java-agent.jar" ] 
then
    wget -O dd-java-agent.jar 'https://dtdg.co/latest-java-tracer'
fi


aws codeartifact get-package-version-asset --domain cloudadvocate --domain-owner 363267848264 --repository book-manager-repository --format maven --namespace com.cloudadvocate.java --package bookmanager --package-version ${VERSION} --asset bookmanager-${VERSION}.jar bookmanager.jar

java -javaagent:dd-java-agent.jar -Ddd.logs.injection=true -jar bookmanager.jar
