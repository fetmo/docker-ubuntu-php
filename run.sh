#!/bin/bash

docker stop php71
docker rm php71
docker run --name php71 -d -p 80:80 -p 2222:22 -p 3306:3306 nxswesolowski/ubuntu-php:7.1