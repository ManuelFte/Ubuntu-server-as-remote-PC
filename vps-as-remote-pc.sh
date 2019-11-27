#!/bin/bash
# Mandatory stuff
sudo apt update
sudo apt upgrade -y
# Installs LXDE, Chromium, and DWService
sudo apt install lubuntu-desktop chromium-browser -y
# OpenDNS
# dhclient=$( sudo find /etc -name dhclient.conf )
# echo "supersede domain-name-servers 208.67.222.222,208.67.220.220; # OpenDNS nameservers" >> $dhclient
# sudo systemctl restart networking
wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/resolv.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo mv resolv.conf /etc
# sudo touch /etc/resolv.conf
# sudo echo -e "nameserver 208.67.222.222\nnameserver 208.67.220.220" >> /etc/resolv.conf