class skeleton{
  file { '/etc/skel':
    ensure=> 'directory',
  }
  file { '/etc/skel/.bashrc':
    ensure  => 'file',
    source  =>  'puppet:///modules/skeleton/bashrc',
    #content => '{md5}2f8222b4f275c4f18e69c34f66d2631b',
    #ctime   => '2016-02-22 15:10:24 +0000',
    group   => '0',
    mode    => '0644',
    #mtime   => '2015-03-05 22:06:48 +0000',
    owner   => '0',
    #type    => 'file',
  }
}
