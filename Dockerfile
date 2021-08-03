FROM nxsjung/ubuntu-apache-mysql:5.7_18.04
MAINTAINER Moritz Jung <m.jung@nexus-united.com>

ADD .docker/scripts /opt/docker/scripts

RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata


RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
	&& apt-get update \
	&& apt-get -y --force-yes install php7.4-cli php7.4-common libapache2-mod-php7.4 php7.4 php7.4-mysql php7.4-fpm php7.4-curl php7.4-gd php7.4-bz2 php7.4-mbstring php7.4-zip php7.4-memcached php7.4-xml php7.4-intl php7.4-xsl php7.4-soap php7.4-bcmath php-redis \
	&& a2enmod php7.4 \
	&& a2enconf php7.4-fpm \
	&& apt-get -y clean

RUN chmod +x /opt/docker/scripts/*.sh \
	&& /opt/docker/scripts/prepare-server.sh \
	&& /opt/docker/scripts/setup-workspace.sh

ADD .docker/php/conf.d /etc/php/7.4/apache2/conf.d

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer \
 && composer self-update --1 \
 && composer global require hirak/prestissimo

EXPOSE 9000
CMD ["supervisord", "-n"]
