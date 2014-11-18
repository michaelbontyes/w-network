class rsync::install {
  
  package { 'rsync':
    ensure => present
  }

}