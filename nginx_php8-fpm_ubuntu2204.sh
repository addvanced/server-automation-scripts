#!/bin/bash

add-apt-repository ppa:ondrej/nginx -y
add-apt-repository ppa:ondrej/php -y
apt update

# Install NGINX
apt install nginx -y
mkdir -p /etc/nginx/sites-available && mkdir -p /etc/nginx/sites-enabled
mkdir -p /var/www/vhosts/example.com/httpdocs
touch /var/www/vhosts/example.com/httpdocs/index.php

wget https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx/nginx.conf -O /tmp/nginx.conf
wget https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx/fastcgi_params.txt -O /tmp/fastcgi_params
wget https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx/example-com.conf -O /tmp/example-com.conf

mv /tmp/nginx.conf /etc/nginx/nginx.conf
mv /tmp/fastcgi_params /etc/nginx/fastcgi_param
mv /tmp/example-com.conf /etc/nginx/sites-available/example-com.conf

ln -s /etc/nginx/sites-available/example-com.conf /etc/nginx/sites-enabled/

service nginx restart
systemctl enable nginx

# Install PHP8.0-FPM
apt install php8.0-fpm php8.0-common php8.0-mysql \
php8.0-xml php8.0-xmlrpc php8.0-curl php8.0-gd \
php8.0-imagick php8.0-cli php8.0-dev php8.0-imap \
php8.0-mbstring php8.0-opcache php8.0-redis \
php8.0-soap php8.0-zip -y

wget https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx/php8.0/php.ini -O /tmp/php.ini
wget https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx/php8.0/www.conf -O /tmp/www.conf

mv /tmp/www.conf /etc/php/8.0/fpm/pool.d/www.conf
mv /tmp/php.ini /etc/php/8.0/fpm/php.ini

service php8.0-fpm restart
systemctl enable php8.0-fpm