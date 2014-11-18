# Install Apache

class apache2::install {

  package { 'apache2':
    ensure => present,
  }
	 exec { 'enable-ssl':
        command => '/usr/sbin/a2enmod ssl',
        creates => '/etc/apache2/mods-enabled/ssl.load',
        notify  => Service['apache2'],
        require => Package['apache2'],
      }	
  service { 'apache2':
    ensure  => running,
    require => Package['apache2'],
  }
 

  # the httpd.conf change the user/group that apache uses to run its process
  file { '/etc/apache2/conf-available/user.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/apache2/httpd.conf',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }
  file { '/etc/apache2/conf-enabled/user.conf':
    ensure => link,
    target => '/etc/apache2/conf-available/user.conf',
  }

  file { '/etc/apache2/sites-available/default.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/apache2/sites-available/default.conf',
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  file { '/etc/apache2/mods-available/rewrite.load':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/etc/apache2/mods-available/rewrite.load',
    require => Package['apache2'],
    notify  => Service['apache2']
  }

  file { '/etc/apache2/sites-enabled/000-default.conf':
    ensure  => link,
    target  => '/etc/apache2/sites-available/default.conf',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/rewrite.load':
    ensure  => link,
    target  => '/etc/apache2/mods-available/rewrite.load',
    require => Package['apache2'],
    notify  => Service['apache2'],
  }
 file { '/root/edlfb14.crt':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/root/edlfb14.crt',
    require => Package['apache2'],
    notify  => Service['apache2']
  }
  
   file { '/root/edlfb14.key':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/root/edlfb14.key',
    require => Package['apache2'],
    notify  => Service['apache2']
  }
  file { '/root/edlfb-ca.crt':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => '/vagrant/files/root/edlfb-ca.crt',
    require => Package['apache2'],
    notify  => Service['apache2']
  }
  
  
}
