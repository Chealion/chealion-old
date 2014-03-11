#! /bin/bash

# Need to work on moving more of this into puppet instead of falling back to scripting.

if [ -f /.provisioned ]; then
	echo 'Skipping bootstrap.sh'
	exit 0
fi

export DEBIAN_FRONTEND=noninteractive

cd

sudo locale-gen en_CA.UTF-8

# Use our internal proxy for faster downloads
export APT_PROXY="10.0.0.88"
export APT_PROXY_PORT=3142
if [[ ! -z "$APT_PROXY" ]]
then
	echo 'Acquire::http { Proxy "http://'${APT_PROXY}:${APT_PROXY_PORT}'"; };' | sudo tee /etc/apt/apt.conf.d/01apt-cacher-ng-proxy
fi

#Grab latest version of Puppet
wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo apt-get install -y python-software-properties

#Latest version of git
sudo add-apt-repository -y ppa:git-core/ppa

#Latest version of nginx
sudo add-apt-repository -y ppa:nginx/stable

#Gitlab wants at least Ruby 2.0
#Install 2.1 using Brightcove's PPA
sudo add-apt-repository -y ppa:brightbox/ruby-ng

sudo apt-get update
sudo apt-get install -y git wget puppet vim iotop iftop htop python-software-properties ruby2.1 ruby2.1-dev

#sudo update-alternatives --set ruby /usr/bin/ruby2.1
#sudo update-alternatives --set gem /usr/bin/gem2.1

touch /.provisioned
