#!/bin/bash
set -x
apt update -y
apt upgrade -y
apt install apache2 -y
apt install php -y
apt install php-mysql -y
cd /var/www/html
wget https://wordpress.org/latest.zip
apt install unzip
unzip latest.zip
chown -R $USER:$USER /var/www
rm index.html
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm latest.zip
service apache2 restart
cp /var/www/html/wp-config-sample.php  /var/www/html/wp-config.php
sed -i -e 's/database_name_here/mydatabase/g' /var/www/html/wp-config.php
sed -i -e 's/username_here/admin/g' /var/www/html/wp-config.php
sed -i -e 's/password_here/wordpress/g' /var/www/html/wp-config.php
sed -i -e "s/localhost/${private_ip}/g" /var/www/html/wp-config.php
service apache2 restart