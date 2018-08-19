# VPS as remote PC

## Description


Turns a VPS into a basic remote PC appropriate for downloading and streaming media at high speed. Essentially an automated version of [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-16-04), with multilple changes:

* LXDE instead of Xfce
* Google Chrome ~~(because who uses Firefox nowadays)~~
* OpenDNS
* youtube-dl
* jDownloader (downloads script, doesn't install)
* Nginx

Tested on Ubuntu 16.04 on DigitalOcean and Google Cloud.

## Usage

* On the VPS: `cd ~ && wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/vps-as-remote-pc.sh && bash vps-as-remote-pc.sh`
* While it installs, do this on your local machine: `ssh -L 5901:127.0.0.1:5901 -N -f -l <VPS user> <VPS IP>`
* After it has finished, connect your VNC client (I use [Remmina](https://www.remmina.org)) to `localhost:5901` with your VPS user and the password chosen during installation.