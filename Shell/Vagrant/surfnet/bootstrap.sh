#! /bin/bash

#if [ -f /.provisioned ]; then
#    echo 'Skipping bootstrap.sh'
#    exit 0
#fi

if [ -f /.kernelinstalled ]; then
	echo 'Kernel already updated.'
else

	cd /root/

	sudo locale-gen en_CA.UTF-8

	#####################
	# REMOVE DEV CODE optimization
	#####################
	# Use our internal proxy for faster downloads
	export APT_PROXY="192.168.123.3"
	export APT_PROXY_PORT=3142
	if [[ ! -z "$APT_PROXY" ]]
	then
		echo 'Acquire::http { Proxy "http://'${APT_PROXY}:${APT_PROXY_PORT}'"; };' | sudo tee /etc/apt/apt.conf.d/01apt-cacher-ng-proxy
	fi

	sudo apt-get update

	sudo apt-get install -y git wget vim htop iotop iftop

	#Upgrade to 3.11 for Neutron:
	sudo apt-get install -y --install-recommends linux-generic-lts-saucy

	#Avoid Grub corrupting a terminal window
	sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

	echo 1 > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

	sudo apt-get install -y python-software-properties
	sudo add-apt-repository -y cloud-archive:havana
	sudo apt-get update

	echo ' '
	echo ' **************************************'
	echo '     Wait for VM to reboot and then'
	echo '     Please run vagrant provision!'
	echo ' **************************************'
	echo ' '
	touch /.kernelinstalled

	sudo shutdown -r now
	exit 0

fi

#Grab iproute2 manually (not great for production)
#wget http://mirrors.kernel.org/ubuntu/pool/main/i/iproute2/iproute_3.10.0-1ubuntu1_all.deb
#wget http://mirrors.kernel.org/ubuntu/pool/main/i/iproute2/iproute2_3.10.0-1ubuntu1_amd64.deb
#sudo dpkg -i iproute2_3.10.0-1ubuntu1_amd64.deb

sudo apt-get update
sudo apt-get -y upgrade

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password mysqlpassword'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password mysqlpassword'

sudo apt-get install -y mysql-server python-mysqldb rabbitmq-server wget curl

cat <<EOF | sudo tee '/root/.my.cnf'

[client]
user=root
host=localhost
password=mysqlpassword

EOF

# Create databases and users.

mysql -u root -e "CREATE DATABASE keystone;"
mysql -u root -e "CREATE DATABASE glance;"
mysql -u root -e "CREATE DATABASE nova;"
mysql -u root -e "CREATE DATABASE cinder;"
mysql -u root -e "CREATE DATABASE neutron;"
mysql -u root -e "CREATE DATABASE ceilometer;"
mysql -u root -e "CREATE DATABASE heat;"

mysql -u root -e "GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' IDENTIFIED BY 'keystonepassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON glance.*   TO 'glance'@'localhost'   IDENTIFIED BY 'glancepassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON nova.*     TO 'nova'@'localhost'     IDENTIFIED BY 'novapassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON cinder.*   TO 'cinder'@'localhost'   IDENTIFIED BY 'cinderpassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON neutron.*  TO 'neutron'@'localhost'  IDENTIFIED BY 'neutronpassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ceilometer.* TO 'ceilometer'@'localhost' IDENTIFIED BY 'ceilometerassword';"
mysql -u root -e "GRANT ALL PRIVILEGES ON heat.*   TO 'heat'@'localhost'   IDENTIFIED BY 'heatpassword';"


###
# 01keysone.md
###

sudo apt-get install -y keystone

#Keystone conf changes
#Underscores cause problems in the token. Don't use it.
sudo sed -i 's/# admin_token = ADMIN/admin_token = secretpassword/g' /etc/keystone/keystone.conf
sudo sed -i 's/# provider =/provider = keystone.token.providers.uuid.Provider/' /etc/keystone/keystone.conf
sudo sed -i 's/connection = sqlite:\/\/\/\/var\/lib\/keystone\/keystone.db/connection = mysql:\/\/keystone:keystonepassword@localhost\/keystone/' /etc/keystone/keystone.conf

#Sync the Database!

keystone-manage db_sync
sudo restart keystone

export OS_SERVICE_TOKEN=secretpassword
export OS_SERVICE_ENDPOINT=http://localhost:35357/v2.0

echo $OS_SERVICE_TOKEN
echo $OS_SERVICE_ENDPOINT

sleep 5
#Create Tenants and Users
keystone token-get
keystone tenant-create --name=admin --description="Admin Tenant"
keystone tenant-create --name=services --description="Services Tenant"
keystone tenant-create --name=demo --description="Demo User"

keystone user-create --name admin --tenant admin --pass password --email root@localhost
keystone user-create --name demo --tenant demo --pass password --email root@localhost

# Create Roles
keystone role-create --name admin
keystone role-create --name member
keystone user-role-add --user admin --tenant admin --role admin

#Change over to our openrc

cat <<EOF | sudo tee ~/openrc

export OS_AUTH_URL=http://localhost:35357/v2.0/
export OS_REGION_NAME=RegionOne
export OS_USERNAME=admin
export OS_TENANT_NAME=admin
export OS_PASSWORD=password
export OS_NO_CACHE=1

EOF

source ~/openrc
unset OS_SERVICE_TOKEN
unset OS_SERVICE_ENDPOINT

#Change to TemplatedCatalog (easier for our all in one)
sudo sed -i 's/driver = keystone.catalog.backends.sql.Catalog/#driver = keystone.catalog.backends.sql.Catalog/' /etc/keystone/keystone.conf
sudo sed -i 's/# driver = keystone.catalog.backends.templated.TemplatedCatalog/driver = keystone.catalog.backends.templated.TemplatedCatalog/' /etc/keystone/keystone.conf

sudo restart keystone

keystone user-list
keystone tenant-list

### GLANCE!

sudo apt-get install -y glance

keystone user-create --name glance --tenant services --pass password --email root@localhost
keystone user-role-add --user glance --tenant services --role admin

sudo sed -i 's/connection = sqlite:\/\/\/\/var\/lib\/glance\/glance.sqlite/connection = mysql:\/\/glance:glancepassword@localhost\/glance/' /etc/glance/glance-api.conf
sudo sed -i 's/connection = sqlite:\/\/\/\/var\/lib\/glance\/glance.sqlite/connection = mysql:\/\/glance:glancepassword@localhost\/glance/' /etc/glance/glance-registry.conf

sudo sed -i 's/%SERVICE_TENANT_NAME%/admin/' /etc/glance/glance-registry.conf
sudo sed -i 's/%SERVICE_TENANT_NAME%/admin/' /etc/glance/glance-api.conf
sudo sed -i 's/%SERVICE_USER%/admin/' /etc/glance/glance-registry.conf
sudo sed -i 's/%SERVICE_USER%/admin/' /etc/glance/glance-api.conf
sudo sed -i 's/%SERVICE_PASSWORD%/password/' /etc/glance/glance-registry.conf
sudo sed -i 's/%SERVICE_PASSWORD%/password/' /etc/glance/glance-api.conf

echo 'flavor = keystone' >> /etc/glance/glance-api.conf
echo 'flavor = keystone' >> /etc/glance/glance-registry.conf

sudo restart glance-registry
sudo restart glance-api

glance-manage db_sync

keystone user-list
glance image-list

#####################
# REMOVE DEV CODE optimization
#####################

#Add images
#wget http://download.cirros-cloud.net/0.3.2~pre2/cirros-0.3.2~pre2-x86_64-disk.img
#wget http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-amd64-disk1.img
cd /vagrant/

glance image-create --name CirrOS --disk-format qcow2 --container-format bare --is-public true < cirros-0.3.2*
glance image-create --name Ubuntu-12.04 --disk-format qcow2 --container-format bare --is-public true < precise-server*

cd /root/

### NOVA!

sudo apt-get install -y nova-novncproxy novnc nova-api nova-ajax-console-proxy nova-cert nova-conductor nova-consoleauth nova-doc nova-scheduler python-novaclient

keystone user-create --name nova --tenant services --pass password --email root@localhost
keystone user-role-add --user nova --tenant services --role admin

cat<<EOF | sudo tee -a /etc/nova/nova.conf

sql_connection = mysql://nova:novapassword@localhost/nova
rpc_backend = nova.rpc.impl_kombu
rabbit_host = localhost
rabbit_port = 5672
rabbit_user = guest
rabbit_password = guest

image_service=nova.image.glance.GlanceImageService
glance_api_servers=localhost:9292

network_api_class = nova.network.neutronv2.api.API
neutron_url = http://192.168.123.51:9696
neutron_auth_strategy = keystone
neutron_admin_tenant_name = services
neutron_admin_username = neutron
neutron_admin_password = password
neutron_admin_auth_url = http://192.168.123.51:35357/v2.0
firewall_driver = nova.virt.firewall.NoopFirewallDriver
security_group_api = neutron
service_neutron_metadata_proxy = True
neutron_metadata_proxy_shared_secret = password
libvirt_vif_type = ethernet
libvirt_vif_driver = nova.virt.libvirt.vif.NeutronLinuxBridgeVIFDriver
linuxnet_interface_driver = nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
auth_strategy = keystone

EOF

sudo sed -i 's/%SERVICE_TENANT_NAME%/admin/' /etc/nova/api-paste.ini
sudo sed -i 's/%SERVICE_USER%/admin/' /etc/nova/api-paste.ini
sudo sed -i 's/%SERVICE_PASSWORD%/password/' /etc/nova/api-paste.ini

sudo nova-manage db sync

for i in /etc/init.d/nova-* ; do
sudo $i restart
done

nova list

### NEUTRON!!!

# To use Linux bridge we need to use at least 3.8 of the kernel, and iproute2 3.8


sudo apt-get install -y neutron-server neutron-dhcp-agent neutron-plugin-linuxbridge neutron-metadata-agent neutron-l3-agent neutron-plugin-linuxbridge-agent


keystone user-create --name neutron --tenant services --pass password --email root@localhost
keystone user-role-add --user neutron --tenant services --role admin

cat<<EOF | sudo tee -a /etc/keystone/default_catalog.templates

catalog.RegionOne.network.publicURL = http://192.168.123.51:9696
catalog.RegionOne.network.adminURL = http://192.168.123.51:9696
catalog.RegionOne.network.internalURL = http://192.168.123.51:9696
catalog.RegionOne.network.name = Networking Service
EOF

#service_plugins = neutron.services.l3_router.l3_router_plugin.L3RouterPlugin 

sudo sed -i 's/openvswitch\/ovs_neutron_plugin.ini/linuxbridge\/linuxbridge_conf.ini/g' /etc/default/neutron-server
sudo sed -i 's/neutron.plugins.openvswitch.ovs_neutron_plugin.OVSNeutronPluginV2/neutron.plugins.ml2.plugin.Ml2Plugin/' /etc/neutron/neutron.conf
sudo sed -i 's/# rabbit_hosts = /rabbit_hosts = /' /etc/neutron/neutron.conf
sudo sed -i 's/# rabbit_port/rabbit_port/' /etc/neutron/neutron.conf
sudo sed -i 's/# rabbit_userid/rabbit_userid/' /etc/neutron/neutron.conf
sudo sed -i 's/# rabbit_password/rabbit_password/' /etc/neutron/neutron.conf
sudo sed -i 's/sqlite:\/\/\/\/var\/lib\/neutron\/neutron.sqlite/mysql:\/\/neutron:neutronpassword@localhost\/neutron/' /etc/neutron/neutron.conf
sudo sed -i 's/# allow_overlapping_ips = False/allow_overlapping_ips = True/' /etc/neutron/neutron.conf

sudo sed -i 's/%SERVICE_TENANT_NAME%/admin/' /etc/neutron/neutron.conf
sudo sed -i 's/%SERVICE_USER%/admin/' /etc/neutron/neutron.conf
sudo sed -i 's/%SERVICE_PASSWORD%/password/' /etc/neutron/neutron.conf

sudo sed -i 's/# interface_driver =/interface_driver = neutron.agent.linux.interface.BridgeInterfaceDriver/' /etc/neutron/dhcp_agent.ini
sudo sed -i 's/# dhcp_driver =/dhcp_driver = /' /etc/neutron/dhcp_agent.ini
sudo sed -i 's/# use_namespaces =/use_namespaces = /' /etc/neutron/dhcp_agent.ini
sudo sed -i 's/# enable_isolated_metadata = False/enable_isolated_metadata = True/' /etc/neutron/dhcp_agent.ini
sudo sed -i 's/# enable_metadata_network = False/enable_metadata_network = True/' /etc/neutron/dhcp_agent.ini

sudo sed -i 's/%SERVICE_TENANT_NAME%/admin/' /etc/neutron/metadata_agent.ini
sudo sed -i 's/%SERVICE_USER%/admin/' /etc/neutron/metadata_agent.ini
sudo sed -i 's/%SERVICE_PASSWORD%/password/' /etc/neutron/metadata_agent.ini
sudo sed -i 's/# metadata_proxy_shared_secret = /metadata_proxy_shared_secret = password/' /etc/neutron/metadata_agent.ini

cat<<EOF | sudo tee -a /etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini

[ml2]
type_drivers = local, vxlan
mechanism_drivers = linuxbridge
tenant_network_types = local, vxlan

[ml2_type_vxlan]
vni_ranges = 1:1000

EOF

sudo sed -i 's/# enable_vxlan = False/enable_vxlan = True/' /etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini
sudo sed -i 's/# local_ip =/local_ip = 192.168.123.51/' /etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini
sudo sed -i 's/# Example: firewall_driver/firewall_driver/' /etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini

#RESTART EVERYTHING!

sudo restart keystone

for i in /etc/init.d/nova-* ; do
sudo $i restart
done

for i in /etc/init.d/neutron-* ; do
sudo $i restart
done

#Create bridges?
# Create the integration and external bridges
#sudo brctl addbr br-int
#sudo brctl addbr br-ex

neutron net-create --shared default
neutron subnet-create default 192.168.1.0/24 --name default --no-gateway --allocation-pool start=192.168.1.100,end=192.168.1.200

## ip netns doesn't work until an instance is launched.

