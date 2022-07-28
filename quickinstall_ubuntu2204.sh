#!/bin/bash

if [ $(id -u) != "0" ]; then
    echo "Please run as with sudo permissions"
else

# INITIAL SETUP - Ubuntu 22.04 - REQUIRED
echo "Running initial setup ..." && curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/initial-setup_ubuntu2204.sh -o /tmp/initial-setup_ubuntu2204.sh >

# Docker Compose
#echo "Installing Docker & Docker Compose ..." && curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/docker-dockercompose_ubuntu2204.sh -o /tmp/docker->

# Nginx + PHP 8.0 FPM
#echo "Installing Nginx + PHP8.0-FPM ..." && curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx_php8-fpm_ubuntu2204.sh -o /tmp/nginx_php8-fpm_ubu>

# MariaDB
#echo "Installing MariaDB ..." && curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/mariabdb_ubuntu2204.sh -o /tmp/mariadb_ubuntu2204.sh && sh /tmp/ma>

# Reboot server - REQUIRED
#echo "Rebooting..." && reboot

fi