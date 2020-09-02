#!/bin/bash
# Update server time
sudo mv /etc/localtime /etc/localtime.old
sudo ln -s /usr/share/zoneinfo/America/Mexico_City /etc/localtime
# Update system
sudo apt update
sudo apt upgrade -y
# Installs LXQt, TightVNC Server, Chromium
sudo apt install lxqt openbox sddm tightvncserver chromium-browser -y
# Starts VNC server to set initial configuration
vncserver
# Kills it in order to override settings
vncserver -kill :1
# Backup because why not
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
# Downloads new configuration file
mv xstartup ~/.vnc
# Executable permissions
chmod +x ~/.vnc/xstartup
# Launches again
vncserver
# OpenDNS
# dhclient=$( sudo find /etc -name dhclient.conf )
# echo "supersede domain-name-servers 208.67.222.222,208.67.220.220; # OpenDNS nameservers" >> $dhclient
# sudo systemctl restart networking
# wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/resolv.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo mv resolv.conf /etc
# sudo touch /etc/resolv.conf
# sudo echo -e "nameserver 208.67.222.222\nnameserver 208.67.220.220" >> /etc/resolv.conf