# Install latest Wordpress

class wordpress::install {

  # Create the Wordpress database
  exec { 'create-database':
    unless  => '/usr/bin/mysql -u root -pvagrant wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute=\'create database wordpress\'',
  }

  exec { 'create-user':
    unless  => '/usr/bin/mysql -u wordpress -pwordpress wordpress',
    command => '/usr/bin/mysql -u root -pvagrant --execute="GRANT ALL PRIVILEGES ON wordpress.* TO \'wordpress\'@\'localhost\' IDENTIFIED BY \'wordpress\'"',
  }

  # Get a new copy of the latest wordpress release
  # FILE TO DOWNLOAD: http://wordpress.org/latest.tar.gz
  # Clone the Git WP-CLI repo
  $install_path = '/usr/local/src/wp-cli'

  exec{ 'wp-cli download':
    command => '/usr/bin/wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar',
    cwd     => '/vagrant/',
  }

  # Ensure we can run wp-cli
  file { "/vagrant/wp-cli.phar":
      ensure => "present",
      mode => "a+x",
      require => Exec[ 'wp-cli download' ]
    }

  # Symlink it across
  exec { 'rename wp-cli':
    path    => [ '/bin', '/usr/bin', '/usr/local/bin' ],
    command => "sudo mv /vagrant/wp-cli.phar /vagrant/wordpress/wp",
    require => File[ "/vagrant/wp-cli.phar" ]
  }

  exec {  'wp core download':
     path    => [ '/bin', '/usr/bin', '/usr/local/bin','/vagrant/wordpress/'],
     command => 'wp core download',  
     user => 'vagrant',
     cwd => '/vagrant/wordpress/',
     require => Exec[ 'rename wp-cli' ,'load-db']
  }

# Copy a working wp-config.php file for the vagrant setup.
  file { '/vagrant/wordpress/wp-config.php':
    source => 'puppet:///modules/wordpress/wp-config.php',
    require=> Exec[ 'wp core download' ]
  }

  exec {  'wp core update-db':
     path    => [ '/bin', '/usr/bin', '/usr/local/bin','/vagrant/wordpress/'],
     command => 'wp core update-db',  
     user => 'vagrant',
     cwd => '/vagrant/wordpress/',
     require => File[ '/vagrant/wordpress/wp-config.php' ]
  }


  # Import a MySQL database for a basic wordpress site.
  file { '/tmp/wordpress-db.sql':
    source => 'puppet:///modules/wordpress/wordpress-db.sql'
  }

  exec { 'load-db':
    command => '/usr/bin/mysql -u wordpress -pwordpress wordpress < /tmp/wordpress-db.sql && touch /home/vagrant/db-created',
    creates => '/home/vagrant/db-created',
  }

  


  


}