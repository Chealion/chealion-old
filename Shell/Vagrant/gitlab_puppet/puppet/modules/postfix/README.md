# Puppet module: postfix

This is a Puppet module for postfix based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-postfix

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.

## USAGE - Basic management

* Install postfix with default settings

        class { 'postfix': }

* Install a specific version of postfix package

        class { 'postfix':
          version => '1.0.1',
        }

* Disable postfix service.

        class { 'postfix':
          disable => true
        }

* Remove postfix package

        class { 'postfix':
          absent => true
        }

* Enable auditing without without making changes on existing postfix configuration files

        class { 'postfix':
          audit_only => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'postfix':
          source => [ "puppet:///modules/lab42/postfix/postfix.conf-${hostname}" , "puppet:///modules/lab42/postfix/postfix.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'postfix':
          source_dir       => 'puppet:///modules/lab42/postfix/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'postfix':
          template => 'example42/postfix/postfix.conf.erb',
        }

* Automatically include a custom subclass

        class { 'postfix':
          my_class => 'postfix::example42',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'postfix':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'postfix':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'postfix':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'postfix':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


[![Build Status](https://travis-ci.org/example42/puppet-postfix.png?branch=master)](https://travis-ci.org/example42/puppet-postfix)
