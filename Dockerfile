FROM nxswesolowski/ubuntu-apache-mysql:5.7
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update && apt-get -y --force-yes install php7.1-cli php7.1-common libapache2-mod-php7.1 php7.1 php7.1-mysql php7.1-fpm php7.1-curl php7.1-gd php7.1-bz2 php7.1-mbstring php7.1-zip php7.1-memcached php7.1-xml php7.1-intl php7.1-xsl php7.1-soap php7.1-bcmath php-redis \
&& a2enmod php7.1 \
&& a2enconf php7.1-fpm \
&& apt-get -y clean

RUN /opt/docker/scripts/prepare-server.sh \
&& /opt/docker/scripts/setup-workspace.sh

ADD .docker/php/conf.d /etc/php/7.1/apache2/conf.d

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer

EXPOSE 9000
CMD ["supervisord", "-n"]
