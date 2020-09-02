# VPS as remote PC

## Description

Turns a VPS into a basic remote PC. Installed software:

* LXQt
* TightVNC Server
* Chromium
* OpenDNS

## Usage

```
git clone https://ManuelFte@bitbucket.org/ManuelFte/vps-as-remote-pc.git
cd vps-as-remote-pc
sh vps-as-remote-pc.sh
```

To connect, type this in the client machine:

`ssh -L 59000:127.0.0.1:5901 user@IP -N -v -v`

Then use a VNC program like TigerVNC to connect to `127.0.0.1:59000`.

<!--https://serverfault.com/questions/489192/ssh-tunnel-refusing-connections-with-channel-2-open-failed-->