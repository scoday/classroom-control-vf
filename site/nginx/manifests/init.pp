class nginx{
$package_name = 'nginx'
$owner        = 'root'
$group        = $owner
$doc_root     = '/var/www'
$conf_dir     = '/etc/nginx'
$block_dir    = "${conf_dir}/conf.d"
$logdir       = "/var/log/${package_name}"
$service_name = $package_name

$service_user = $::osfamily ? {
  'RedHat'  => $package_name,
  'Debian'  => 'www-data',
  default   => $package_name,
}

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
}
