#!/bin/bash

cd /opt/docker/scripts/files/
echo "ioncube"
tar xvjf ioncube_loaders_lin_x86-64.tar.bz2
rm ioncube_loaders_lin_x86-64.tar.bz2
mkdir -p /usr/local/ioncube
cp /opt/docker/scripts/files/ioncube/ioncube_loader_lin_5.6.so /usr/local/ioncube
rm -rf /opt/docker/scripts/files/ioncube
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php/5.6/apache2/conf.d/00-ioncube.ini
cp /opt/docker/scripts/files/00-ioncube.ini /etc/php/5.6/cli/conf.d/00-ioncube.ini

echo ""
echo "phpunit"


sudo mv phpunit-5.7.phar phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

echo ""
