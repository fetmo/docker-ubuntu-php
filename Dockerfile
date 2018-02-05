FROM nxswesolowski/ubuntu-apache-mysql
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN rm -rf /var/lib/apt/lists/*
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update && apt-get -y --force-yes install php5.6-cli php5.6-common libapache2-mod-php5.6 php5.6 php5.6-mysql php5.6-fpm php5.6-curl php5.6-gd php5.6-bz2 php5.6-mbstring php5.6-zip php5.6-memcached php5.6-xml php5.6-intl php5.6-xsl php5.6-soap libzip4  php5.6-mcrypt \
&& a2enmod php5.6 \
&& apt-get -y clean

RUN /opt/docker/scripts/prepare-server.sh \
&& /opt/docker/scripts/setup-workspace.sh

ADD .docker/php/conf.d /etc/php/5.6/apache2/conf.d

EXPOSE 9000
CMD ["supervisord", "-n"]