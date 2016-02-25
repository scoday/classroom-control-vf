class nginx(
$package_name     = $::nginx::params::package_name, 
$owner            = $::nginx::params::owner,
$group            = $::nginx::params::group,
$doc_root         = $::nginx::params::default_doc_root,
$conf_dir         = $::nginx::params::conf_dir,
$block_dir        = $::nginx::params::block_dir,
$logdir           = $::nginx::params::logdir,
$service_name     = $::nginx::params::service_name,
$service_user     = $::nginx::params::service_user,
) inherits nginx::params {


File{
  owner => $owner,
  group => $group,
  mode  =>  '0644',
}

  package{ $package_name :
    ensure  => present,
  }
  
#file { '/etc/nginx/nginx.conf':
file { "${conf_dir}/${package_name}.conf":
  ensure  => 'file',
  content  => template('nginx/nginx.conf.erb'),
  #source  => 'puppet:///modules/nginx/nginx.conf',
  require => Package[$package_name],
}

#file { '/etc/nginx/conf.d/default.conf':
file { "${block_dir}/default.conf":
  ensure  => 'file',
  content  => template('nginx/default.conf.erb'),
  #source  => 'puppet:///modules/nginx/default.conf',
  require => Package[$package_name],
}

#file { '/var/www':
file { $doc_root:
  ensure => directory,
}

#file { '/var/www/index.html':
file { "${doc_root}/index.html":
  ensure  => file,
  source  => 'puppet:///modules/nginx/index.html',

}
service{ $service_name :
  ensure    => 'running',
  enable    => 'false',
  subscribe => [
              File["${block_dir}/default.conf"],
              File["${conf_dir}/${package_name}.conf"]
              ]
  }
#service{ $package :
#  ensure    => 'running',
#  enable    => 'false',
#  subscribe => [
#              File['/etc/nginx/conf.d/default.conf'],
#              File['/etc/nginx/nginx.conf']
#              ]
#  }

}
