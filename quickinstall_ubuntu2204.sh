#!/bin/bash

if [ $(id -u) != "0" ]; then
    echo "Please run as with sudo permissions"
else
    args="$*"
    modules=''
    IFS=','

    if [[ -z "$args" ]]; then
        echo "Select the modules you want to install (Select multiple with comma-separation, eg. 0,1,3)"
        echo "0. Initial Setup for Ubuntu 22.04"
        echo "1. Docker & Docker-Compose"
        echo "2. Nginx + PHP 8.0 FPM"
        echo "3. MariaDB"
        echo " "
        echo "999. Reboot after install"

        read -p "Modules to install: " modules
    else
         modules="$*"
    fi

    read -a mArr <<< "$modules"

    declare -A installModules
    for val in "${mArr[@]}"
    do
        escaped_val=$( echo "$val" | xargs | tr -d ' ')
        installModules[$escaped_val]=1
    done

    installed=false
    app_name=''

    if [[ ${installModules["0"]} ]]; then
        app_name='Initial Setup for Ubuntu 22.04'
        echo "Installing: $app_name ..."

        echo '1/3: Downloading setup script ...'
        curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/initial-setup_ubuntu2204.sh -o /tmp/initial-setup_ubuntu2204.sh
        
        echo '2/3: Installing & Configuring ...'
        sh /tmp/initial-setup_ubuntu2204.sh
        
        echo '3/3: Removing setup script ...'
        rm /tmp/initial-setup_ubuntu2204.sh

        echo "Finished installing: $app_name ..."
        installed=true
    fi

    if [[ ${installModules["1"]} ]]; then
        app_name='Docker & Docker Compose'
        echo "Installing: $app_name ..."

        echo '1/3: Downloading setup script ...'
        curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/docker-dockercompose_ubuntu2204.sh -o /tmp/docker-dockercompose_ubuntu2204.sh
        
        echo '2/3: Installing & Configuring ...'
        sh /tmp/docker-dockercompose_ubuntu2204.sh

        echo '3/3: Removing setup script ...'
        rm /tmp/docker-dockercompose_ubuntu2204.sh

        echo "Finished installing: $app_name ..."
        installed=true
    fi

    if [[ ${installModules["2"]} ]]; then
        app_name='Nginx & PHP8.0-FPM'
        echo "Installing: $app_name ..."

        echo '1/3: Downloading setup script ...'
        curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx_php8-fpm_ubuntu2204.sh -o /tmp/nginx_php8-fpm_ubuntu2204.sh
        
        echo '2/3: Installing & Configuring ...'
        sh /tmp/nginx_php8-fpm_ubuntu2204.sh
        
        echo '3/3: Removing setup script ...'
        rm /tmp/nginx_php8-fpm_ubuntu2204.sh
        
        echo "Finished installing: $app_name ..."
        installed=true
    fi

    #if [[ ${installModules["3"]} ]]; then
    #    app_name='MariaDB'
    #    echo "Installing: $app_name ..."

    #    echo '1/3: Downloading setup script ...'
    #    curl -fsSL https://raw.githubusercontent.com/systemedz/server-automation-scripts/develop/nginx_php8-fpm_ubuntu2204.sh -o /tmp/nginx_php8-fpm_ubuntu2204.sh
        
    #    echo '2/3: Installing & Configuring ...'
    #    sh /tmp/nginx_php8-fpm_ubuntu2204.sh
        
    #   echo '3/3: Removing setup script ...'
    #    rm /tmp/nginx_php8-fpm_ubuntu2204.sh
        
    #    echo "Finished installing: $app_name ..."
    #    installed=true
    #fi

    if [[ "$installed" == "false" ]]; then
      echo "Nothing was installed."
    else
        if [[ ${installModules["999"]} ]]; then
            echo "Rebooting ..."
            sleep 5
            echo "NOW!"
        fi
    fi
fi