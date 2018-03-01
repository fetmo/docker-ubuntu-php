#!/bin/bash

docker stop php56-es
docker rm php56-es
docker run --name php56-es -d -p 80:80 -p 2222:22 -p 3306:3306 -p 9200:9200 nxswesolowski/ubuntu-php:5.6-elasticsearch
