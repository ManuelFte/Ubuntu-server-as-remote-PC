#!/bin/bash

# User variables
timezone="America/Mexico_City"

# Other variables
missing_packages=""
script_dir="$(pwd)"
initial_setup=false
dns=false
hyperbeam=false
full=false

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Parsing command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --include-initial-setup|-iis) initial_setup=true ;;
        --dns|-dn) dns=true ;;
        --hyperbeam|-hb) hyperbeam=true ;;
        --full|-fl) full=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo -e "${GREEN}Starting script...${NC}"

# Stop on errors
set -e

# Check if wget exists first, only if hyperbeam mode is enabled
if [[ "$hyperbeam" == true ]]; then
    if ! command -v wget &> /dev/null; then
        echo -e "${YELLOW}wget not found! Adding it to the installation list....${NC}"
        missing_packages+="wget "
    fi
fi

# Add resolvconf to missing packages, only if dns or full mode are enabled
if [[ "$dns" == true || "$full" == true ]]; then
    missing_packages+="resolvconf "
fi

# Add appimagelauncher to missing packages, only if hyperbeam mode is enabled
if [[ "$hyperbeam" == true ]]; then
    missing_packages+="appimagelauncher "
fi

# Adjust the clock, only if initial_setup or full mode are enabled
if [[ "$initial_setup" == true || "$full" == true ]]; then
    echo -e "${GREEN}Adjusting the clock...${NC}"
    if [ -f "/etc/localtime" ]; then
        sudo mv /etc/localtime /etc/localtime.old
    fi
    sudo ln -s /usr/share/zoneinfo/"$timezone" /etc/localtime
fi

# Upgrade the system
echo -e "${GREEN}Upgrading the system...${NC}"
sudo apt update && sudo apt upgrade -y

# Set a password for the current user, only if initial_setup or full mode are enabled
if [[ "$initial_setup" == true || "$full" == true ]]; then
    echo -e "${GREEN}Setting a password for the current user...${NC}"
    sudo passwd "$USER"
fi

# Backup and update SSH configuration, only if initial_setup or full mode are enabled
if [[ "$initial_setup" == true || "$full" == true ]]; then
    echo -e "${GREEN}Backing up and updating SSH configuration...${NC}"
    sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
    sudo sed -i 's/#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
fi

# Restart SSH services, only if initial_setup or full mode are enabled
if [[ "$initial_setup" == true || "$full" == true ]]; then
    echo -e "${GREEN}Restarting SSH services...${NC}"
    sleep 1
    sudo systemctl restart ssh sshd
fi

# Install software packages
echo -e "${GREEN}Installing software packages...${NC}"
# Add AppImage Launcher repository, only if hyperbeam mode is enabled
if [[ "$hyperbeam" == true ]]; then
    sudo add-apt-repository ppa:appimagelauncher-team/stable -y
    sudo apt update
fi

sudo apt install lxqt openbox sddm tigervnc-standalone-server chromium-browser "$missing_packages" -y

# Download Hyperbeam, only if hyperbeam mode is enabled
if [[ "$hyperbeam" == true ]]; then
    echo -e "${GREEN}Downloading Hyperbeam...${NC}"
    wget https://cdn.hyperbeam.com/Hyperbeam-0.21.0.AppImage
    chmod u+x Hyperbeam-0.21.0.AppImage
fi

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

# Set OpenDNS's nameservers in resolved.conf, only if dns or full mode are enabled
if [[ "$dns" == true || "$full" == true ]]; then
    echo -e "${GREEN}Setting OpenDNS's nameservers in resolved.conf...${NC}"
    if [ -f "/etc/systemd/resolved.conf" ]; then
        echo -e "${GREEN}resolved.conf found. Backing it up...${NC}"
        sudo cp /etc/systemd/resolved.conf /etc/systemd/resolved.conf.backup
    fi
    sudo cp "${script_dir}/resolved.conf" /etc/systemd/

    # Restart DNS
    echo -e "${GREEN}Restarting DNS...${NC}"
    sleep 1
    sudo systemctl restart systemd-resolved
fi

echo -e "${GREEN}Script completed.${NC}"
