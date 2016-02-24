define users::managed_user(
  $user   = $title,
  $group  = $title,

){
  user{ $user:
    ensure      => present,
    managehome  => false,
    home        => "/tmp/${user}",
  }

  file { "/tmp/$user":
    ensure => directory,
    require => User[$user],
  }
    
}
