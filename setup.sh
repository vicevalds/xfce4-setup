#!/usr/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
  echo "Syntax: [-hua]"
  echo "Options:"
  echo -e "\th\tPrint help"
  echo -e "\ta\tDownload discord, obsidian, vscode and telegram"
}

############################################################
# Process the input options. Add options as needed.        #
############################################################
while getopts ":h:a" option; do
  case $option in
      h) # Print this help
         Help
         exit 0 ;;
      a) # Install apps
         APPS='true' ;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit 1 ;;
  esac
done

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
# Install Apps
if [[ -n $APPS ]]; then
  bash apps.sh
fi
# Set xfce4 enviroment
xfce4-panel-profiles load xfce4-custom.tar.bz2
xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image") -s /usr/share/images/desktop-base/puppet_master.jpg
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
