#!/bin/bash

cd ~
wget http://www.us.apache.org/dist/activemq/5.12.1/apache-activemq-5.12.1-bin.tar.gz
md5sum apache-activemq*.tar.gz
tar -zxvf apache-activemq*.tar.gz
mv apache-activemq-5.12.1 /opt
ln -s /opt/apache-activemq-5.12.1 /opt/activemq
adduser --system activemq
chown -R activemq: /opt/activemq
