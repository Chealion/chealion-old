#! /bin/bash

# Use my local vagrant apt proxy
echo 'Acquire::http { Proxy "http://192.168.123.3:3142"; };' | sudo tee /etc/apt/apt.conf.d/02proxy

sudo apt-get update;
#sudo apt-get -y upgrade; #Frickin Grub...
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

sudo apt-get install apache2
sudo apt-get install -y vim git zsh htop iotop iftop wget python-software-properties

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password P@55w0rdz'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password P@55w0rdz'
sudo apt-get install -y php5 mysql-server php5-mysql curl unzip
sudo mysql_install_db

# Run sudo apt-get install -y phpmyadmin manually as it requires questions to be answered....
