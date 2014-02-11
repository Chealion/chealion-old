#! /bin/bash

if [ -f /.provisioned ]; then
    echo 'Skipping bootstrap.sh'
    exit 0
fi

cd /home/vagrant

sudo locale-gen en_CA.UTF-8

#MongoDB for Ceilommeter
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

sudo apt-get update

sudo apt-get install -y git wget vim htop iotop iftop mongodb-10gen

git clone git://github.com/openstack-dev/devstack.git
cd devstack
git checkout stable/havana

cp /vagrant/local.conf .

sudo chown -R vagrant:vagrant ../devstack

sudo -u vagrant ./stack.sh

echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE