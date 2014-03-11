# = Class: postfix::aliases
#
# Adds a postfix alias database
#
# == Parameters
#
# [*source*]
#   Sets the value of source parameter for the postfix alias database
#
# [*template*]
#   Sets the value of content parameter for the postfix alias database
#   Defaults to 'postfix/aliases.erb' if $maps is set.
#   Note: This option is alternative to the source one
#
# [*maps*]
#   Sets the value of content parameter for the postfix alias database
#   Note: This option is alternative to the source one
#
# == Usage:
# class { 'postfix::aliases':
#   source => 'puppet:///modules/example42/postfix/aliases'
# }
#
# class { 'postfix::aliases':
#   template => 'example42/postfix/aliases.erb'
# }
#
# class { 'postfix::aliases':
#   maps => {
#     'postmaster' => 'root',
#     'nobody'     => 'root',
#     'root'       => ['admin@example.org', 'admin@example.com'],
#   }
# }
#
class postfix::aliases (
  $source   = params_lookup( 'source' ),
  $template = params_lookup( 'template' ),
  $maps     = params_lookup( 'maps' ),
) {
  include postfix

  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }

  $manage_file_content = $template ? {
    ''        => $maps ? {
      ''      => undef,
      default => template('postfix/aliases.erb'),
      },
    default   => template($template),
  }

  file { 'postfix::aliases':
    ensure  => present,
    path    => $postfix::aliases_file,
    mode    => $postfix::config_file_mode,
    owner   => $postfix::config_file_owner,
    group   => $postfix::config_file_group,
    require => Package['postfix'],
    source  => $manage_file_source,
    content => $manage_file_content,
    replace => $postfix::manage_file_replace,
    audit   => $postfix::manage_audit,
  }

  exec { 'postalias':
    command     => "/usr/sbin/postalias '${postfix::aliases_file}'",
    require     => Package['postfix'],
    subscribe   => File['postfix::aliases'],
    refreshonly => true,
  }

}
