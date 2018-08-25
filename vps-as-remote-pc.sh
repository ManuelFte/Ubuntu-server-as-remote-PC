#!/bin/bash
# Adds PPAs for youtube-dl and Google Chrome
sudo add-apt-repository ppa:nilarimogard/webupd8 -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
# Mandatory stuff
sudo apt update
sudo apt upgrade -y
# Installs LXDE, TightVNC Server, youtube-dl, Chrome and Nginx
sudo apt install lubuntu-desktop tightvncserver youtube-dl google-chrome-stable nginx -y
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
wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/resolv.conf
sudo mv /etc/resolv.conf /etc/resolv.conf.bak
sudo mv resolv.conf /etc
# sudo touch /etc/resolv.conf
# sudo echo -e "nameserver 208.67.222.222\nnameserver 208.67.220.220" >> /etc/resolv.conf
#Downloads jDownloader
wget http://aotwiki.com/u/jdownloader.sh
#Sets permissions for the Nginx directory
sudo mkdir -p /var/www/stream.aotwiki.com/html
sudo chown -R $USER:www-data /var/www/stream.aotwiki.com/html
#Downloads the pages for streams
cd var/www/stream.aotwiki.com/html
wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/streams.zip
unzip streams.zip
rm streams.zip