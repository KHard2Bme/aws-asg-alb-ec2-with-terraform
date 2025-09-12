#!/bin/bash
# Update packages
yum update -y

# Install Apache
yum install -y httpd

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Create a simple index.html page
echo "<h1>Welcome to Skybound Travel! Served from $(hostname)</h1>" > /var/www/html/index.html

