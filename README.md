# VPS as remote PC

## Description


Turns a VPS into a basic remote PC. Essentially an automated version of [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-16-04), with several changes:

* LXDE instead of Xfce
* Chromium ~~(because who uses Firefox nowadays)~~
* OpenDNS
* youtube-dl (:smirk:)

**It is meant for my personal tests and not for general usage**, but it can work for other cases as is or with simple modifications. Tested on a droplet with Ubuntu 16.04 on DigitalOcean, should run as well on most VPS with that system.

## Usage

* On the VPS: `cd ~ && wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/vps-as-remote-pc.sh && bash vps-as-remote-pc.sh`
* While it installs, do this on your local machine: `ssh -L 5901:127.0.0.1:5901 -N -f -l <VPS user> <VPS IP>`
* After it has finished, connect your VNC client (I use [Remmina](https://www.remmina.org)) to `localhost:5901` with your VPS user and the password chosen during installation.