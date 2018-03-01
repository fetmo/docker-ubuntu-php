#!/bin/bash

echo "ioncube"

cd /tmp/
wget http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip
unzip ioncube_loaders_lin_x86-64.zip
rm /tmp/ioncube_loaders_lin_x86-64.zip
mkdir -p /usr/local/ioncube
cp /tmp/ioncube/ioncube_loader_lin_7.0.so /usr/local/ioncube
rm -rf /tmp/ioncube
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php/7.0/apache2/conf.d/00-ioncube.ini
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php/7.0/cli/conf.d/00-ioncube.ini

echo ""
echo "phpunit"

wget -O phpunit https://phar.phpunit.de/phpunit-6.phar
chmod +x phpunit
sudo mv phpunit /usr/local/bin/phpunit
phpunit --version

echo ""