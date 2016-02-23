# HERE IS MEMCACHED
class memcached {
  file { '/etc/sysconfig/memcached.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/memcached/sysconfig/memcached.conf',
    notify => Service['memcached'],
  }

  service { 'memcached':
    ensure => running,
    enable => true,
  }

  package { 'memcached':
    ensure => present,
    before => File['/etc/sysconfig/memcached.conf'],
  }
}


### CLEANER ? 
#class memcached {
#  package{ 'memcached':
#    ensure  => present,
#    before  => File['/etc/sysconfig/memcached'],
#  }
  #
  #file{ '/etc/sysconfig/memcached':
 #   ensure  =>  'file',
 #   source  => 'puppet:///modules/memcached/sysconfig/memcached',
 #   require => Package['memcached'],
 #   notify  => Service['memcached'],
#  }
#
#  service{ 'memcached':
#    ensure    => 'running',
#    subscribe =>  File['/etc/sysconfig/memcached'],
#  }
#}
