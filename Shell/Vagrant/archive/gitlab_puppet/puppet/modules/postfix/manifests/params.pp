# Class: postfix::params
#
# This class defines default parameters used by the main module class postfix
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to postfix class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class postfix::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'postfix',
  }

  $service = $::operatingsystem ? {
    default => 'postfix',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'master',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'postfix',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/postfix',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/postfix/main.cf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/postfix',
    default                   => '/etc/sysconfig/postfix',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/spool/postfix/pid/master.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/var/spool/postfix',
  }

  $log_dir = $::operatingsystem ? {
    default => '',
  }

  $log_file = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/var/log/mail.log',
    default                   => '/var/log/postfix/postfix.log',
  }

  $aliases_file = $::operatingsystem ? {
    default => '/etc/aliases',
  }

  $mastercf_file = $::operatingsystem ? {
    default => '/etc/postfix/master.cf',
  }

  $port = '25'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $restart_command = ''
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = 'localhost'
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false

}
