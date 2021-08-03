#!/bin/bash

echo "install php-xdebug, joe, mc"

apt-get -y install php-xdebug joe mc

echo "add user docker to sudo-group"
usermod -a -G sudo docker

echo "copy config files"
cp /opt/docker/scripts/files/xdebug.ini /etc/php/7.4/mods-available/xdebug.ini
sudo cp /opt/docker/scripts/files/.bash_aliases /home/docker/.bash_aliases
sudo chown -Rf www-data:www-data /home/docker/.bash_aliases
sudo cp /opt/docker/scripts/files/.bash_aliases /home/nexus/.bash_aliases
sudo chown -Rf www-data:www-data /home/nexus/.bash_aliases
sudo mkdir /home/www-data/
sudo cp /opt/docker/scripts/files/.bash_aliases /home/www-data/.bash_aliases
sudo chown -Rf www-data:www-data /home/www-data/
cp /opt/docker/scripts/files/servername.conf /etc/apache2/conf-available/servername.conf

ln -s ../conf-available/servername.conf /etc/apache2/conf-enabled/servername.conf
