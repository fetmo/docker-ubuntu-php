FROM ubuntu:14.04
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts

RUN apt-get update && apt-get -y upgrade \
&& apt-get -y install supervisor openssh-server curl rsync vim git ant unzip \
&& mkdir -p /var/run/sshd /var/log/supervisor \
&& echo 'root:docker123' | chpasswd \
&& sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd


ADD .docker/supervisor /etc/supervisor/conf.d

RUN apt-get -y --force-yes install apache2 \
&& mkdir -p /var/lock/apache2 /var/run/apache2 \
&& rm -rf /etc/apache2/sites-enabled/* \
&& chmod +x /opt/docker/scripts/*.sh

ADD .docker/apache/vhost /etc/apache2/sites-enabled

RUN apt-get -y --force-yes install nodejs npm \
&& npm install -g grunt-cli \
&& adduser --disabled-password --gecos "" docker \
&& echo 'docker:docker' | chpasswd \
&& adduser www-data docker \
&& adduser docker sudo \
&& echo "%sudo ALL = NOPASSWD: ALL" >> /etc/sudoers \
&& apt-get -y install software-properties-common \
&& apt-get update && apt-get -y install python-software-properties \
&& LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
&& apt-get update && apt-get -y --force-yes install php5.6-cli php5.6-common libapache2-mod-php5.6 php5.6 php5.6-mysql php5.6-fpm php5.6-curl php5.6-gd php5.6-bz2 php5.6-mbstring php5.6-zip php5.6-memcached php5.6-xml php5.6-intl php5.6-xsl php5.6-soap libzip4 \
&& a2enmod rewrite \
&& a2enmod ssl \
&& a2enmod php5.6 \
&& a2enmod vhost_alias \
&& apt-get -y clean \
&& chown -Rf docker:docker /var/ \
&& rm -rf /var/www/html \
&& echo "export APACHE_RUN_USER=docker" >> /etc/apache2/envvars \
&& echo "export APACHE_RUN_GROUP=docker" >> /etc/apache2/envvars \
&& apt-get -y --force-yes install mysql-server-5.6 \
&& rm -rf /etc/mysql/mysql.conf.d/*

ADD .docker/mysql/conf.d /etc/mysql/conf.d

RUN rm -rf /var/lib/mysql/ib_logfile* \
&& /opt/docker/scripts/config-mysql.sh \
&& /opt/docker/scripts/prepare-server.sh \
&& /opt/docker/scripts/setup-workspace.sh \
&& mkdir /var/www/log

ADD .docker/php/conf.d /etc/php5/apache2/conf.d

EXPOSE 22 80 3000 3306 9000
CMD ["supervisord", "-n"]