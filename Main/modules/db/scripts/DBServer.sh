#!/bin/bash
set -x
apt update -y
apt upgrade -y
apt install mysql-server -y
service mysql stop
cd /etc
chmod -R 777 mysql
cd mysql
cd mysql.conf.d
sed -i 's/127.0.0.1/0.0.0.0/g' mysqld.cnf
cd
service mysql start
mysql <<EOF
CREATE USER 'admin'@'%' IDENTIFIED BY 'wordpress';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
flush privileges;
exit
EOF
mysql -u admin -pwordpress -e 'create database mydatabase;'