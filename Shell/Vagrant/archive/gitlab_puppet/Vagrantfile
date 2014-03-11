#vagrant plugin install vagrant-openstack-plugin
#vagrant box add dummy https://github.com/cloudbau/vagrant-openstack-plugin/raw/master/dummy.box
# MUST RUN vagrant up --provider openstack
# Thanks Joe!

# Using precise image (4042220e-4f5e-4398-9054-39fbd75a5dd7)
require 'vagrant-openstack-plugin'

Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  ssh_key = "cyberaMenlo"
  keypair = "mcjones-RAC"
  image = '4042220e-4f5e-4398-9054-39fbd75a5dd7'

  config.ssh.private_key_path = "~/.ssh/#{ssh_key}"

  # Basic OpenStack options
  # Note that an openrc file needs sourced before using
  config.vm.provider :openstack do |os|
    os.username        = ENV['OS_USERNAME']
    os.api_key         = ENV['OS_PASSWORD']
    os.tenant          = ENV['OS_TENANT_NAME']
    os.flavor          = /n1.large/
    os.image           = image
    os.endpoint        = "#{ENV['OS_AUTH_URL']}/tokens"
    os.keypair_name    = keypair
    os.ssh_username    = "ubuntu"
    os.security_groups = ['default','openstack']
  end

  config.vm.provision 'shell', path: 'gitlab-bootstrap.sh'
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'puppet/modules'
  end
end
