#!/bin/bas
sudo yum update -y # This command is used to update the internal repository with yum repository
sudo yum install httpd -y 
sudo systemctl httpd start 
sudo systemctl httpd enable 
sudo mkdir -p /var/www/html
sudo echo "<h1> This this is the server-1 </h1>" > /var/www/html/index.html
