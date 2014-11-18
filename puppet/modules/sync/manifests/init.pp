# Install livesync

class sync::install {

  exec { 'copy the syncdb script':
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    command => "sudo cp -fr /vagrant/scripts/files/syncdb.sh /home/vagrant/syncdb.sh"
  }

  exec { 'copy the syncmedia script':
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    command => "sudo cp -fr /vagrant/scripts/files/syncmedia.sh /home/vagrant/syncmedia.sh"
  }

  exec { 'copy the syncall script':
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    command => "sudo cp -fr /vagrant/scripts/files/syncall.sh /home/vagrant/syncall.sh"
  }
 	
}
