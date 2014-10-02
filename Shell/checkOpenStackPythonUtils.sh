#! /bin/bash

clients=( 'ceilometer' 'cinder' 'glance' 'heat' 'keystone' 'neutron' 'openstack' 'nova' 'swift' 'trove' )

for client in ${clients[@]}; do
	echo $client
	pip search python-${client}client | grep 'INSTALLED'
done

echo 'sudo pip install --upgrade python-{client}client'
