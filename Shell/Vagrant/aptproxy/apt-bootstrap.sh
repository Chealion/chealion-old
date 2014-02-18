#! /bin/bash

if [ -f /.provisioned ]; then
	echo 'Skipping bootstrap.sh'
	exit 0
fi

export DEBIAN_FRONTEND=noninteractive

cd

sudo locale-gen en_CA.UTF-8

wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo add-apt-repository ppa:zfs-native/stable

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get install -y git wget puppet vim iotop iftop htop

touch /.provisioned