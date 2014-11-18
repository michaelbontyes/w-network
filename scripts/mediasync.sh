#!/bin/bash
sshpass -p GK7EuubKGumRkgJ rsync -e ssh -az --progress --ignore-existing livesync@milacron-master.edlfb.net:/var/www/vhosts/milacron-dev.edlfb.net/wp-content/uploads/ /vagrant/wordpress/wp-content/uploads/
