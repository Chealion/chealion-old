#! /bin/bash

if [ -f /.provisioned ]; then
    echo 'Skipping bootstrap.sh'
    exit 0
fi

cd /home/ubuntu

echo 'Acquire::http { Proxy "http://10.0.0.88:3142"; };' | sudo tee /etc/apt/apt.conf.d/02proxy

sudo locale-gen en_CA.UTF-8

sudo apt-get update

sudo apt-get install -y git wget vim htop iotop iftop

git clone git://github.com/openstack-dev/devstack.git
cd devstack
git checkout stable/havana

cp /vagrant/local.conf .

sudo chown -R ubuntu:ubuntu ../devstack

sudo -u ubuntu ./stack.sh
