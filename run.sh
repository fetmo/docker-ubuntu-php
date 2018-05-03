#!/bin/bash

docker stop php72
docker rm php72
docker run --name php72 -d -p 80:80 -p 2222:22 -p 3306:3306 nxswesolowski/ubuntu-php:7.2