#! /bin/bash

#wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
#sudo dpkg -i puppetlabs-release-precise.deb

# Use my local vagrant apt proxy
echo 'Acquire::http { Proxy "http://192.168.123.3:3142"; };' | sudo tee /etc/apt/apt.conf.d/02proxy

sudo apt-get update;
#sudo apt-get -y upgrade; #Frickin Grub...
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

