#!/bin/bash
sudo yum update -y
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y tomcat
sudo chkconfig tomcat on
sudo service tomcat start
