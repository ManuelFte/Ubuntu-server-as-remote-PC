# VPS as remote PC

## Description

Turns a VPS into a basic remote PC. Essentially an automated version of [this tutorial](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-16-04), with multiple changes:

* LXDE instead of Xfce
* Chromium ~~(because who uses Firefox nowadays)~~
* OpenDNS
* DWService (downloads script, doesn't install)

Tested on Ubuntu 16.04 on OVH.

## Usage

* On the VPS: `cd ~ && wget https://bitbucket.org/ManuelFte/VPS-as-remote-PC/raw/master/vps-as-remote-pc.sh && bash vps-as-remote-pc.sh`