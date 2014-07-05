#!/bin/bash

########################################################
### This script is created by Hasn T. Emdad Rumi <h.t.emdad@gmail.com>.
### Released under GPL 2.0 licensing
########################################################

# Warning message
echo -n "CDROM repo need to be disable. if you already disabled it you can hit [ENTER] or else click ctrl+C to terminate..."
read -t 10 -p "Otherwise auto installation will beging in 10 seconds..."
echo "Starting installation of Virtualbox Headless Auto Installation. Use at your own risk..."

# Adding repository of Virtualmin instlation direcoty
echo "deb http://download.virtualbox.org/virtualbox/debian wheezy contrib" >> /etc/apt/sources.list
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -
echo "Virtualbox Public Key Added"
# Update apt repository
apt-get update
echo "Aptitude is updated"

# Start installing Virtualbox with DKMS
echo "Virtualbox installation is goin on..."
apt-get install -y linux-headers-$(uname -r) build-essential virtualbox-4.3 dkms
echo "Virtualbox Core Installaiton is completed!"

#  Extension pack
echo "Now installing Extension pack..."
cd /tmp
extpack_url='http://download.virtualbox.org/virtualbox/4.3.12/Oracle_VM_VirtualBox_Extension_Pack-4.3.12-93733.vbox-extpack'
wget $extpack_url
VBoxManage  extpack install Oracle*.vbox-extpack
echo "Extension pack installed"

#Useradd
echo "Now adding vbox user and group account..."
useradd -m vbox -G vboxusers
echo "Enter vbox account password"
passwd vbox
echo "vbox user password is updated"
rm -rf /etc/default/virtualbox
echo "VBOXWEB_USER=vbox" >> /etc/default/virtualbox
echo "User profile added for web services..."
echo "Adding VBoxWebservice on service level-"
update-rc.d vboxweb-service defaults /etc/init.d/vboxweb-service start
echo "Service added successfully"

# Web Control Panel
echo "Now installing Apache with PHP..."
apt-get install -y apache2-mpm-prefork apache2-utils apache2.2-bin apache2.2-common apache2 apache2-doc apache2-suexec libapache2-mod-php5 libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libapr1 php5-common php5-mysql php-pear 
/etc/init.d/apache2 restart
/etc/init.d/vboxweb-service restart
echo "Web Service with PHP successfully installed"

# PhpVirtualbox
echo "Installing PHPVirtualbox..."
rm -rf /var/www/virtualbox
mkdir /var/www/virtualbox
cd /tmp
echo `pwd`
wget http://linux.mango.com.bd/phpvirtualbox-4.3-1.zip
apt-get install -y unzip
unzip phpv*.zip
cd /tmp/phpv*
mv * /var/www/virtualbox
cd /var/www/virtualbox
# mv config.php-example config.php

read -p "Enter your vbox user account password: " mypass
sed 's/'"'"'pass'"'"'/'"'""$mypass""'"'/g' /var/www/virtualbox/config.php-example > /var/www/virtualbox/config.php
echo "PHPVirtualbox password updated!!!"

echo "Your installation is completed. Now Sit back and open your browser and point to: http://<your virtualbox server ip>/virtualbox"

echo "enjoy!!!"
