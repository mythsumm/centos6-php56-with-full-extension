#!/bin/bash

# Create WORKDIR
mkdir /data/www

# Setting php
cp -p /etc/php.ini /etc/php.ini.backup
sed -i -e 's/;date.timezone =/date.timezone = "Asia\/Shanghai"/' /etc/php.ini | grep date.timezone

# Setting php-fpm
cp -p /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.backup
sed -i -e 's/user = nginx/user = www/' /etc/php-fpm.d/www.conf
sed -i -e 's/group = nginx/group = www/' /etc/php-fpm.d/www.conf

# Setting nginx
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
mkdir /etc/nginx/sites-include
mkdir /usr/share/nginx/virtualhost
mkdir -p /data1/env/nginx/conf/dev
touch /data1/env/nginx/conf/dev/default.conf
mkdir -p /data1/env/nginx/conf/service
touch /data1/env/nginx/conf/service/default.conf

cp -p /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
