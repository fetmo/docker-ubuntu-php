FROM nxswesolowski/ubuntu-apache-mysql:5.7
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update && apt-get -y --force-yes install php7.2-cli php7.2-common libapache2-mod-php7.2 php7.2 php7.2-mysql php7.2-fpm php7.2-curl php7.2-gd php7.2-bz2 php7.2-mbstring php7.2-zip php7.2-memcached php7.2-xml php7.2-intl php7.2-xsl php7.2-soap php7.2-bcmath  \
&& a2enmod php7.2 \
&& a2enconf php7.2-fpm \
&& apt-get -y clean

RUN /opt/docker/scripts/prepare-server.sh \
&& /opt/docker/scripts/setup-workspace.sh

ADD .docker/php/conf.d /etc/php/7.2/apache2/conf.d

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer

EXPOSE 9000
CMD ["supervisord", "-n"]