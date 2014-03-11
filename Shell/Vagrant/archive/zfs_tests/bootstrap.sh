#! /bin/bash
export DEBIAN_FRONTEND=noninteractive
if [ -f /.provisioned ]; then
    echo 'Skipping bootstrap.sh'
    exit 0
fi

cd /home/ubuntu

echo 'Acquire::http { Proxy "http://10.0.0.88:3142"; };' | sudo tee /etc/apt/apt.conf.d/02proxy

sudo locale-gen en_CA.UTF-8

sudo add-apt-repository -y ppa:zfs-native/stable
sudo add-apt-repository -y ppa:semiosis/ubuntu-glusterfs-3.4
sudo apt-get update

sudo apt-get install -y git wget vim htop iotop iftop ubuntu-zfs glusterfs-client glusterfs-server

exit 0

#Just in case (for when reusing drives)
echo 'Yes' | parted -s /dev/vdb mklabel gpt
echo 'Yes' | parted -s /dev/vdc mklabel gpt

zpool create -m /openstack_zfs -o ashift=12 openstack_zfs /dev/vdb /dev/vdc /dev/vde
zfs set compression=on openstack_zfs

#Create datasets for different portions. We'll turn on dedup for instances
zfs create openstack_zfs/instances
zfs create openstack_zfs/volumes



zpool status

#Fill the drive with some data.
cd /openstack_zfs
wget http://10.0.0.134/trusty.img 
wget http://10.0.0.134/1310desk.iso

#Gluster fun!
mkdir /openstack_zfs/instances_brick/instances
gluster volume create instances replica 2 zfs1:/openstack_zfs/instances_brick/instances zfs2:/openstack_zfs/instances_brick/instances
gluster volume start instances

gluster volume info

#Make sure ports are open..


mount -t glusterfs zfs1:/instance_brick /mnt/brick
for i in `seq -w 1 100`; do echo $i > /mnt/brick/copy-test-$i; done
ls -lA /mnt/brick | wc -l
ls -lA /openstack_zfs/instance_brick


#Snapshot sending
zfs snapshot openstack_zfs@test
zfs send openstack_zfs@test | ssh zfstest2 zfs receive openstack_zfs

df -h
zpool status -x

