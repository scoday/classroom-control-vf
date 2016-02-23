class nginx {

   package { 'nginx':
     ensure => present,
     before => File['/etc/sysconfig/memcached.conf'],
   }

   file { '/etc/nginx/nginx.conf':
     ensure  => 'file',
     content => '{md5}060207123b3c5c5189cbe5259e1d5c2f',
     #ctime   => '2016-02-23 13:28:13 +0000',
     group   => 'root',
     mode    => '0644',
     #mtime   => '2016-01-26 18:15:47 +0000',
     owner   => 'root',
     type    => 'file',
   }

   file { '/etc/nginx/conf.d/default.conf':
     ensure => 'file',
     source=> 'puppet:///modules/nginx/nginx.conf',
     require => Package['nginx'],
   }

   file { '/var/www':
     ensure = 'directory',
   }

   file { '/var/www/index.html':
     ensure => file,
     source => 'puppet:///modules/nginx/index.html',
   }

   service { 'nginx':
     ensure => 'running',
     enable => 'false',
     require => [
     			  File['/etc/nginx/conf.d/default.conf'],
     			  File['/etc/nginx/nginx.conf']
     			  ]
   }

 }

 ## Add the package first and then use puppet resource file /etc/nginx/nginx.conf ##
