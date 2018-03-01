#!/bin/bash

docker stop php70
docker rm php70
docker run --name php70 -d -p 80:80 -p 2222:22 -p 3306:3306 nxswesolowski/ubuntu-php:7.0