#!/bin/bash

# Java version
java_version="17"

# Check if the desired Java version is installed
if java -version 2>&1 | grep -q "version \"$java_version"; then
    echo "Java $java_version is already installed"
else
    echo "Java $java_version is not installed, installing now..."
    sudo apt update
    sudo apt install openjdk-$java_version-jdk
fi



# install logger script

useradd -aG adm logger

mkdir -p /opt/logger/config

cd /opt/logger

wget -c https://raw.githubusercontent.com/ELMAALMI/log-collector-set-up/main/logger.service
wget -c https://raw.githubusercontent.com/ELMAALMI/log-collector-set-up/main/application.properties
wget -c https://github.com/ELMAALMI/log-collector-set-up/blob/main/log-collector.jar
wget -c https://raw.githubusercontent.com/ELMAALMI/log-collector-set-up/main/log_config.txt


chmod 777 /opt/logger

# create linux service to run the script on the backround
cp logger.service /etc/systemd/system/
cp application.properties /opt/logger/config
cp log_config.txt /opt/logger/config


systemctl daemon-reload
systemctl enable logger.service
systemctl start logger.service
systemctl status logger.service
