#!/bin/bash

# install Jenkins
sudo yum update –y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo dnf install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins

# install docker
sudo yum install docker -y
sudo service docker start
sudo usermod -a -G docker jenkins

sudo systemctl start jenkins

# install git
sudo yum install git -y