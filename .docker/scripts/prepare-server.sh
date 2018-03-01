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


wget -O phpunit https://phar.phpunit.de/phpunit-5.phar
chmod +x phpunit
sudo mv phpunit /usr/local/bin/phpunit
phpunit --version

echo ""
