# Ubuntu with php, MySql and apache

## App-Version

* Ubuntu 16.04
* MySQL 5.7


### MySQL Connection

###### Docker-User

Host: 127.0.0.1 (Docker-Host)  
Port: 3306  
User: docker   
Pass: docker  

###### Nexus-User

Host: 127.0.0.1 (Docker-Host)  
Port: 3306  
User: nexus   
Pass: nexus123 

### SSH-Connection

###### Docker-User 

Host: 127.0.0.1 (Docker-Host)   
Port: 2222   
User: docker   
Pass: docker  

###### Nexus-User 

Host: 127.0.0.1 (Docker-Host)   
Port: 2222    
User: nexus    
Pass: nexus123  

###### Root-User 
Host: 127.0.0.1 (Docker-Host)   
Port: 2222   
User: root   
Pass: docker

Private Key without pass: <https://github.com/wesolowski/docker-ubuntu-apache/blob/ubuntu16/.docker/ssh/id_rsa>


#### PHP-Libary: 
* IonCube
* Composer
* phpunit
