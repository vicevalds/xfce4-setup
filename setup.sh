#!/usr/bin/bash

local BACKGROUND="monet.png"

if [[ $(whoami) == "root" ]]; then
  echo "[!] Run this script as unprivileged user (no sudo)"
  exit 1
fi

sudo apt update
sudo apt upgrade -y
sudo apt install -y xfce4 xfce4-panel-profiles xfce4-power-manager
sudo apt install -y bat vim htop rofi curl cmake brightnessctl flameshot xclip redshift ntfs-3g
# To use the trackpad
sudo apt install -y xserver-xorg-input-synaptics
sudo apt autoremove -y
# For debian
sudo ln -sf /sbin/shutdown /usr/bin/shutdown
sudo ln -sf /sbin/reboot /usr/bin/reboot
# Custom menu and backgrounds
sudo cp onedark.rasi /usr/share/rofi/themes/.
sudo cp img/* /usr/share/images/desktop-base/.
# Install dotfiles
cp -r .config/rofi .config/xfce4/ ~/.config/.
cp .bashrc ~/.
# Set xfce4 enviroment
xfce4-panel-profiles load xfce4-custom.tar.bz2
xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image") -s /usr/share/images/desktop-base/${BACKGROUND}

# Custom lightdm
bash lightdm.sh

read -p "Reboot the system? [Y/n]: " response
if [[ "$response" == "Y" || "$response" == "y" ]]; then
  reboot
else
  echo "[!] Reboot is needed to refresh xfce4"
  echo "[!] After reboot run to use the trackpad"
  echo "        synclient tapbutton1=1"
fi
