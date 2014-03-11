

#This is the syntax to create a mysql server in puppetlabs-mysql version < 2.0.0
#  class { 'mysql::server':
#    config_hash => { 'root_password' => 'badpassword' }
#  }
  
#This is the syntax to create a mysql server in puppetlabs-mysql version > 2.0.0
#Use caution as it could overwrite an existing database
class { 'mysql::server':
  root_password   => 'PGnCp2qnWYV3qxTUw', 
}

class { 'gitlab' : 
  #	  git_user               => 'git',
  #	  git_home               => '/home/git',
  git_email              => 'micheal@mcjones.ca',
  #	  git_comment            => 'GitLab',
  git_ssh_port           => '22',
  #	  gitlab_sources         => 'git://github.com/gitlabhq/gitlabhq.git',
    gitlab_branch          => '6-6-stable',
  #	  gitlabshell_sources    => 'git://github.com/gitlabhq/gitlab-shell.git',
  gitlabshell_branch     => 'v1.8.0',
    
  gitlab_dbtype          => 'mysql',
  gitlab_dbname          => 'gitlab_db',
  gitlab_dbuser          => 'gitlab_user',
  gitlab_dbpwd           => 'PGnCp2qnWYV3qxTUwvv',
  gitlab_dbhost          => 'localhost',
  gitlab_dbport          => '3306',

  gitlab_ssl             => true,
  gitlab_ssl_cert        => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
  gitlab_ssl_key         => '/etc/ssl/private/ssl-cert-snakeoil.key',
  gitlab_ssl_self_signed => true, #Do not use self signed certs in production!
  gitlab_projects        => '15',
  default_servername     => 'gitlab.mcjones.ca', #If you want to change gitlab.foo.com to foobar.foo.com
  #gitlab_username_change => true,

  ldap_enabled           => false,

  use_custom_login_logo  => true, #Crashes if set to false at the moment.
  use_custom_thumbnail   => false,
  use_company_link       => true,
  company_link           => 'http://mcjones.ca',
  visibility_level       => 'internal',

  gitlab_gravatar        => true,
  user_create_group      => false,
  user_changename        => true,

  #Default Project features
  project_issues         => true,
  project_merge_request  => true,
  project_wiki           => false,
  project_wall           => false,
  project_snippets       => true,

}
	  
	  
  
  
