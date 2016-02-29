## site.pp ##


## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Disable filebucket by default for all File resources:
File { backup => false }

# Randomize enforcement order to help understand relationships
ini_setting { 'random ordering':
  ensure  => present,
  path    => "${settings::confdir}/puppet.conf",
  section => 'agent',
  setting => 'ordering',
  value   => 'title-hash',
}

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  
  $cvirtual=capitalize($::virtual)
  notify { "Hello, my name is ${::hostname} and I am a Virtual ${cvirtual}  and release 13.2": }
  $the_message = hiera('message')
  notify { $the_message :
  } 
  
#file { '/etc/motd':
#  ensure  => file,
#  owner   => 'root',
#  group   => 'root',
#  mode    => '0644',
#  content => "Hey, Puppet is this much FUN!\n",
#}

  #exec {"cowsay 'Welcome to ${::fqdn}!' > /etc/motd" :
  #   creates  => '/etc/motd',
  #    path    => '/usr/local/bin',
  # }
# host { 'testing.puppetlabs.vm':
#  ensure => 'present',
#  ip     => '127.0.0.1',
#  target => '/etc/hosts',
#}
#}
#  include skeleton
#  include memcached
#  include users
#  include nginx
#  include aliases 
include wrappers::mystaging
#class{ 'aliases' :
#    admin => 'fundamentals'
#  }
#
#  user::managed_user{ ['fundamentals', 'foo','bar','baz']: 
#  }
#}
#
#  users::managed_user{ ['fundamentals', 'test','anothertest']: 
#  }
#  include users::admins
#}

