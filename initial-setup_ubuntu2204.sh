#!/bin/bash

# Stop SSH to avoid logging in while this is going on...
service sshd stop

# Update & Upgrade
apt update && 
DEBIAN_FRONTEND=noninteractive apt -y upgrade
DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade
apt -y autoremove && apt -y autoclean

apt install -y unzip

# Set timezone to Europe/Copenhagen
ln -fs /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# Set unattended upgrades automatically
UNUP_FILE=/etc/apt/apt.conf.d/20auto-upgrades

if [[ ! -f $UNUP_FILE.bak ]]; then
    sudo cp $UNUP_FILE $UNUP_FILE.bak
    sudo rm $UNUP_FILE
    echo "APT::Periodic::Update-Package-Lists \"1\";
APT::Periodic::Download-Upgradeable-Packages \"1\";
APT::Periodic::AutocleanInterval \"30\";
APT::Periodic::Unattended-Upgrade \"1\";" | sudo tee --append $UNUP_FILE
fi
/etc/init.d/unattended-upgrades restart

# Setup new SSH user
SSH_USER=systemedz
SSH_PASS=Password123

useradd -s /bin/bash -m -p $(perl -e 'print crypt($ARGV[0], "password")' "$SSH_PASS") $SSH_USER \
&& usermod -aG sudo $SSH_USER && passwd --expire $SSH_USER && mkdir /home/$SSH_USER/.ssh \
&& chmod 700 /home/$SSH_USER/.ssh && cp ~/.ssh/authorized_keys /home/$SSH_USER/.ssh/ \
&& chown $SSH_USER:$SSH_USER -R /home/$SSH_USER/.ssh

# Configure SSH (Change port and disable Root login)
SSHD_FILE=/etc/ssh/sshd_config

sed -i 's/#Port 22/Port 223/' $SSHD_FILE
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' $SSHD_FILE
sed -i 's/#AddressFamily any/AddressFamily inet/' $SSHD_FILE
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' $SSHD_FILE
sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 200/' $SSHD_FILE
sed -i 's/#MaxAuthTries 6/MaxAuthTries 3/' $SSHD_FILE
sed -i '/Include \/etc\/ssh\/sshd_config.d\/\*\.conf/i Protocol 2' $SSHD_FILE

# Activate Firewall
sed -i 's/-A ufw-before-input -p icmp --icmp-type echo-request -j ACCEPT/-A ufw-before-input -p icmp --icmp-type echo-request -j DROP/' /etc/ufw/before.rules

# -----------------------------
# SSH
# -----------------------------
ufw allow 223

# Enable & Reload UFW
ufw enable && ufw reload