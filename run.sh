#!/bin/bash

docker stop php56
docker rm php56
docker run --name php56 -d -p 80:80 -p 2222:22 -p 3306:3306 nxswesolowski/ubuntu-php:5.6