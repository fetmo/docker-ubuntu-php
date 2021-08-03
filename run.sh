#!/bin/bash

docker stop php74
docker rm php74
docker run --name php74 -d -p 81:80 -p 2222:22 -p 3307:3306 nxsjung/ubuntu-php:7.4