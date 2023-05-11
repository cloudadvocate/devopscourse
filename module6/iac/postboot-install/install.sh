#!/bin/bash

# install jdk

sudo apt install -y default-jdk

# install jenkins

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y

sudo apt-get install -y jenkins

# Follow instruction from https://www.jenkins.io/doc/book/installing/linux/

# install python pip

apt install -y python3-pip