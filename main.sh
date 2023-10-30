#!/bin/bash

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting script...${NC}"

# Variables
timezone="America/Mexico_City"
script_dir="$(pwd)"

# Stop on errors
set -e

# Adjust the clock
echo -e "${GREEN}Adjusting the clock...${NC}"
if [ -f "/etc/localtime" ]; then
    sudo mv /etc/localtime /etc/localtime.old
fi

sudo ln -s /usr/share/zoneinfo/"$timezone" /etc/localtime

# Upgrade the system
echo -e "${GREEN}Upgrading the system...${NC}"
sudo apt update && sudo apt upgrade -y

# Set a password for the current user
echo -e "${GREEN}Setting a password for the current user...${NC}"
sudo passwd "$USER"

# Backup and update SSH configuration
echo -e "${GREEN}Backing up and updating SSH configuration...${NC}"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH services
echo -e "${GREEN}Restarting SSH services...${NC}"
sleep 1
sudo systemctl restart ssh sshd

# Install software packages
echo -e "${GREEN}Installing software packages...${NC}"
sudo apt install lxqt openbox sddm tigervnc-standalone-server chromium-browser resolvconf -y

# Download Hyperbeam
echo -e "${GREEN}Downloading Hyperbeam...${NC}"
wget https://cdn.hyperbeam.com/Hyperbeam-0.21.0.AppImage
chmod u+x Hyperbeam-0.21.0.AppImage

# Start VNC server to set initial configuration
echo -e "${GREEN}Starting VNC server for initial configuration...${NC}"
vncserver

# Kill it to override settings
echo -e "${GREEN}Killing VNC server to override settings...${NC}"
vncserver -kill :1

# Backup xstartup
if [ -f "$HOME/.vnc/xstartup" ]; then
    echo -e "${GREEN}xstartup found. Backing it up...${NC}"
    mv "$HOME/.vnc/xstartup" "$HOME/.vnc/xstartup.bak"
fi

# Copy new xstartup configuration
echo -e "${GREEN}Copying new xstartup configuration...${NC}"
cp "${script_dir}/xstartup" "$HOME/.vnc/"
chmod +x "$HOME/.vnc/xstartup"

# Launch the server again
echo -e "${GREEN}Launching VNC server again...${NC}"
vncserver :1 -geometry 1920x1080 -depth 24 -dpi 96

# Backup resolved.conf
if [ -f "/etc/systemd/resolved.conf" ]; then
    echo -e "${GREEN}resolved.conf found. Backing it up...${NC}"
    sudo cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.backup
fi

# Set OpenDNS's nameservers in resolved.conf
echo -e "${GREEN}Setting OpenDNS's nameservers in resolved.conf...${NC}"
sudo cp "${script_dir}/resolved.conf" /etc/systemd/

# Restart DNS
echo -e "${GREEN}Restarting DNS...${NC}"
sleep 1
sudo systemctl restart systemd-resolved

echo -e "${GREEN}Script completed.${NC}"