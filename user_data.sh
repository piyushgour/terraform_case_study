#!/bin/bash
sudo su
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl stop firewalld
sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf
chmod 777 /var/www/html
echo "<html><body><h1>Hello from Terraform!</h1></body></html>" > /var/www/html/index.html
systemctl restart httpd