#!/bin/bash
# Adds PPA for youtube-dl
sudo add-apt-repository ppa:nilarimogard/webupd8 -y
# Mandatory stuff
sudo apt update
sudo apt upgrade -y
# Installs LXDE, TightVNC Server, Chromium and youtube-dl
sudo apt install lubuntu-desktop tightvncserver chromium-browser youtube-dl -y
# Starts VNC server to set initial configuration
vncserver
# Kills it in order to override settings
vncserver -kill :1
# Backup because why not
mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
# Downloads new configuration file
cd ~/.vnc
wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/xstartup
# Executable permissions
chmod +x xstartup
# Returns to user folder
cd ~
# Launches again
vncserver
# OpenDNS
# dhclient=$( sudo find /etc -name dhclient.conf )
# echo "supersede domain-name-servers 208.67.222.222,208.67.220.220; # OpenDNS nameservers" >> $dhclient
# sudo systemctl restart networking
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo echo -e "nameserver 208.67.222.222\nnameserver 208.67.220.220" >> /etc/resolv.conf

