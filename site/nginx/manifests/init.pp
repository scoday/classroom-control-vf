class nginx {

   package { 'nginx':
   ensure => present,
   #before => File['/etc/sysconfig/memcached.conf'],
   }

 }

 ## Add the package first and then use puppet resource file /etc/nginx/nginx.conf ##
