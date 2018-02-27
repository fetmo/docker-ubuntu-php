FROM nxswesolowski/ubuntu-php:5.6
MAINTAINER Rafal Wesolowski <wesolowski@nexus-netsoft.com>

ADD .docker/scripts /opt/docker/scripts
ADD .docker/supervisor /etc/supervisor/conf.d

RUN rm -rf /var/lib/apt/lists/* \
&& apt-get update \
&& apt-get install -y --force-yes openjdk-8-jdk

ENV ELASTICSEARCH_VERSION 2.4.6
RUN wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.deb \
&& dpkg -i elasticsearch-${ELASTICSEARCH_VERSION}.deb

ADD .docker/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD .docker/elasticsearch/logging.yml /var/log/elasticsearch/logging.yml

EXPOSE 9200 9300
CMD ["supervisord", "-n"]