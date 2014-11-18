#!/bin/bash
sshpass -p GK7EuubKGumRkgJ ssh -oStrictHostKeyChecking=no livesync@milacron-master.edlfb.net /home/livesync/dev.sh
sshpass -p GK7EuubKGumRkgJ scp livesync@milacron-master.edlfb.net:/home/livesync/dev.sql /vagrant/sql/dev.sql
cd /vagrant/wordpress/
/vagrant/wordpress/wp db export /vagrant/sql/local.sql 
/vagrant/wordpress/wp db import /vagrant/sql/dev.sql
/vagrant/wordpress/wp search-replace --network --url=milacron-dev.edlfb.net milacron-dev.edlfb.net milacron-local.edlfb.net