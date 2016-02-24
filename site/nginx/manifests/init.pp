class nginx {
$package = 'nginx'
File{
  owner => '0',
  owner => '0',
  mode  => '0644',
  
}


   package { $package:
     ensure => present,
   }

   file { '/etc/nginx/nginx.conf':
     ensure  => 'file',
     source  => 'puppet:///modules/nginx/nginx.conf',
     #content => '{md5}060207123b3c5c5189cbe5259e1d5c2f',
     #ctime   => '2016-02-23 13:28:13 +0000',
     group   => 'root',
     mode    => '0777',
     #mtime   => '2016-01-26 18:15:47 +0000',
     owner   => 'root',
     require  => Package['nginx'],
   }

   file { '/etc/nginx/conf.d/default.conf':
     ensure => 'file',
     source=> 'puppet:///modules/nginx/default.conf',
     require => Package['nginx'],
   }

   file { '/var/www':
     ensure => 'directory',
   }

   file { '/var/www/index.html':
     ensure => file,
     source => 'puppet:///modules/nginx/index.html',
   }

   service { $package :
     ensure => 'running',
     enable => 'false',
     subscribe => [
     			  File['/etc/nginx/conf.d/default.conf'],
     			  File['/etc/nginx/nginx.conf']
     			  ]
   }

 }

 ## Add the package first and then use puppet resource file /etc/nginx/nginx.conf ##
