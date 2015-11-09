#!/bin/bash

cd ~
sudo yum install java-1.7.0-openjdk
wget http://www.us.apache.org/dist/activemq/5.12.1/apache-activemq-5.12.1-bin.tar.gz
md5sum apache-activemq*.tar.gz
tar -zxvf apache-activemq*.tar.gz
sudo mv apache-activemq-5.12.1 /opt
sudo ln -s /opt/apache-activemq-5.12.1 /opt/activemq
sudo adduser --system activemq
sudo chown -R activemq: /opt/activemq
