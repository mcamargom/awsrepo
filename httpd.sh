#!/bin/bash
sudo su
sudo yum -y update
sudo yum -y install httpd
systemctl start httpd
systemctl enable httpd.service
sudo yum -y install firewalld
systemctl start firewalld
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
sudo systemctl start httpd
