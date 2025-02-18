#!/usr/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
  echo "Syntax: [-hua]"
  echo "Options:"
  echo -e "\th\tPrint help"
  echo -e "\ta\tInstall discord, obsidian, vscode and telegram apps"
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
sudo apt install -y vim htop rofi brightnessctl flameshot xclip redshift ntfs-3g xfce4-panel-profiles
# To use the trackpad
sudo apt install -y xserver-xorg-input-synaptics
sudo apt autoremove -y
# For debian
sudo ln -sf /sbin/shutdown /usr/bin/shutdown
sudo ln -sf /sbin/reboot /usr/bin/reboot
# Custom menu and backgrounds
sudo cp onedark.rasi /usr/share/rofi/themes/.
sudo cp .config/user.png /usr/share/backgrounds/.
sudo cp img/* /usr/share/backgrounds/.
# Install dotfiles
cp -r .config/rofi ~/.config/.
cp .bashrc ~/.
cp .bash_aliases ~/.
# Install Apps
if [[ -n $APPS ]]; then
  firefox https://discord.com/api/download?platform=linux&format=deb
  firefox https://code.visualstudio.com/docs/?dv=linux64_deb
  firefox https://telegram.org/dl/desktop/linux
  firefox https://obsidian.md/download
fi
# Set xfce4 enviroment
xfce4-panel-profiles load xfce4-custom.tar.bz2
xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image") -s /usr/share/backgrounds/forest.png
# xfconf-query -c xfce4-keyboard-shortcuts -l
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>m' -s "rofi -show drun"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super><Shift>m' -s "rofi -show"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/Print' -s "flameshot gui"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>b' -s "firefox"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Shift>F3' -s "brightnessctl set +3%"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Shift>F2' -s "brightnessctl set 3%-"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>r' -s "redshift -O 2000"
#xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super><Shift>r' -s "redshift -x"

read -p "Reboot the system? [Y/n]: " response
if [[ "$response" == "Y" || "$response" == "y" ]]; then
  reboot
else
  echo "[!] Reboot is needed to use the trackpad"
  echo "[!] After reboot run synclient tapbutton1=1 to use the trackpad"
fi
