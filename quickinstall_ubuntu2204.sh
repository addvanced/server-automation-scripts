#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root / sudo"
  exit
fi

# INITIAL SETUP - Ubuntu 22.04 - REQUIRED
#curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/initial-setup_ubuntu2204.sh -o /tmp/initial-setup_ubuntu2204.sh && sh /tmp/initial-setup_ubuntu2204.sh

# Docker Compose
#curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/docker-dockercompose_ubuntu2204.sh -o /tmp/docker-dockercompose_ubuntu2204.sh && sh /tmp/docker-dockercompose_ubuntu2204.sh

# Nginx + PHP 8.0 FPM
#curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx_php8-fpm_ubuntu2204.sh -o /tmp/nginx_php8-fpm_ubuntu2204.sh && sh /tmp/nginx_php8-fpm_ubuntu2204.sh

# MariaDB
#curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/mariabdb_ubuntu2204.sh -o /tmp/mariadb_ubuntu2204.sh && sh /tmp/mariadb_ubuntu2204.sh

# Reboot server - REQUIRED
#reboot