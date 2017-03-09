#!/bin/bash

echo "ioncube"

cd /tmp/
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.bz2
tar xvjf ioncube_loaders_lin_x86-64.tar.bz2
rm /tmp/ioncube_loaders_lin_x86-64.tar.bz2
mkdir -p /usr/local/ioncube
cp /tmp/ioncube/ioncube_loader_lin_5.6.so /usr/local/ioncube
rm -rf /tmp/ioncube
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php5/apache2/conf.d/00-ioncube.ini
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php5/cli/conf.d/00-ioncube.ini

echo ""
echo "phpunit"


wget https://phar.phpunit.de/phpunit-5.7.phar
sudo mv phpunit-5.7.phar phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

echo ""
