#!/bin/bash
dnf update -y

# nginx
dnf install nginx -y
systemctl enable nginx
systemctl start nginx

# java (nếu app java)
dnf install java-17-amazon-corretto -y

# cloudwatch agent
dnf install amazon-cloudwatch-agent -y

# sample page
echo "<h1>HIS App Server $(hostname)</h1>" > /usr/share/nginx/html/index.html