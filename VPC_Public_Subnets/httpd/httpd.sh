#!/bin/bas
sudo yum update -y 
sudo yum install httpd -y 
sudo systemctl httpd start 
sudo systemctl httpd enable 
sudo mkdir -p /var/www/html
sudo echo "<h1> This this is the server-2 </h1>" > /var/www/html/index.html
