# = Class: postfix::mastercf
#
# Manage postfix master.cf config file
#
# == Parameters
#
# [*source*]
#   Sets the value of source parameter for the postfix master.cf config file
#
# [*template*]
#   Sets the value of content parameter for the postfix master.cf config file
#   Note: This option is alternative to the source one
#
# == Usage:
# class { 'postfix::mastercf':
#   source => 'puppet:///modules/example42/postfix/master.cf'
# }
#
# class { 'postfix::mastercf':
#   template => 'example42/postfix/mastercf.erb'
# }
#
class postfix::mastercf (
  $source   = params_lookup( 'source' ),
  $template = params_lookup( 'template' ),
) {
  include postfix

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $template ? {
    ''        => undef,
    default   => template($template),
  }

  file { 'postfix::mastercf':
    ensure  => present,
    path    => $postfix::mastercf_file,
    mode    => $postfix::config_file_mode,
    owner   => $postfix::config_file_owner,
    group   => $postfix::config_file_group,
    require => Package['postfix'],
    notify  => $postfix::manage_service_autorestart,
    source  => $manage_file_source,
    content => $manage_file_content,
    replace => $postfix::manage_file_replace,
    audit   => $postfix::manage_audit,
  }

}
