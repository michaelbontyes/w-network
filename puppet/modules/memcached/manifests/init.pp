#Install MySQL

class memcached::install {


  package { [
      'memcached',
      'php5-memcache',
    ]:
    ensure => installed,
  }


}
