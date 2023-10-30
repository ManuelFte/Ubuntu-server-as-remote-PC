# VPS as remote PC

## Description

Turns a VPS into a basic remote PC. Installed software:

* LXQt (with Openbox)
* TigerVNC Standalone Server
* Chromium

## Usage

Clone the repository:

`git clone https://github.com/ManuelFte/VPS-as-remote-PC`

Enter the script's directory:

`cd vps-as-remote-pc`

Open `main.sh` and set the correct timezone in the variables:

`nano main.sh`

Run the script:

`bash main.sh`

After the script has finished, type this in the **client** machine:

`ssh -t -L 7001:localhost:5901 -N -v <user>@<IP>`

Then, also from the **client** machine, use a VNC program like TigerVNC to connect to `localhost:7001` (on Linux you can use `vncviewer localhost:7001`).