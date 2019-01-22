FROM nxswesolowski/ubuntu-apache-mysql:5.7
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update && apt-get -y --force-yes install php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0 php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mbstring php7.0-zip php7.0-memcached php7.0-xml php7.0-intl php7.0-xsl php7.0-soap php7.0-bcmath php-redis \
&& a2enmod php7.0 \
&& a2enconf php7.0-fpm \
&& apt-get -y clean

RUN /opt/docker/scripts/prepare-server.sh \
&& /opt/docker/scripts/setup-workspace.sh

ADD .docker/php/conf.d /etc/php/7.0/apache2/conf.d

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer
 
EXPOSE 9000
CMD ["supervisord", "-n"]
