#!/usr/bin/bash

############################################################
# Help                                                     #
############################################################
Help()
{
   echo "Syntax: [-huza]"
   echo "Options:"
   echo "h     Print help"
   echo "u     The user to install the dotfiles"
   echo "z     Install and set zsh as default shell"
   echo "a     Install apps like discord, obsidian, vscode and telegram"   
}

############################################################
# Process the input options. Add options as needed.        #
############################################################
while getopts ":h:u:z:a" option; do
   case $option in
      h) # Print this help
         Help
         exit 0;;
      u) # User name
         USER_NAME=$OPTARG ;;
      z) # Install and set zsh as default shell
         ZSH='true' ;;
      a) # Install apps
         APPS='true' ;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit 1;;
   esac
done

if [[ -z "$USER_NAME" ]]; then
   echo "User option is needed"
   echo -e "\tUSAGE: ./setup.sh -u <user>"
   Help
   exit 1
fi

sudo apt update
sudo apt upgrade -y
sudo apt install -y rofi brightnessctl flameshot xclip redshift ntfs-3g
sudo apt autoremove -y
# For debian
sudo ln -sf /sbin/shutdown /usr/bin/shutdown
sudo ln -sf /sbin/reboot /usr/bin/reboot
# add to sudoers group
sudo chmod u+w /etc/sudoers
sudo echo -e "${USER_NAME}\tALL=(ALL:ALL) ALL" >> /etc/sudoers
sudo chmod u-w /etc/sudoers
# Custom menu and backgrounds
sudo cp onedark.rasi /usr/share/rofi/themes
sudo cp .config/user.png /usr/share/backgrounds/
sudo cp -r img/ /usr/share/backgrounds/
# Install dotfiles
cp -r .config/rofi /home/${USER_NAME}/.config
cp .bashrc /home/${USER_NAME}/.
cp .bash_aliases /home/${USER_NAME}/.
# Install zsh
if [[ -n $ZSH ]]; then
   sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting
   cp .zshrc /home/${USER_NAME}/.
   sudo cp .zshrc /root
   sudo usermod -s /usr/bin/zsh root
   sudo usermod -s /usr/bin/zsh ${USER_NAME}
fi
# Install Apps
if [[ -n $APPS ]]; then
   firefox https://discord.com/api/download?platform=linux&format=deb
   firefox https://code.visualstudio.com/docs/?dv=linux64_deb
   firefox https://obsidian.md/download
   firefox https://telegram.org/dl/desktop/linux
fi
# Set xfce4 enviroment 
xfce4-panel-profiles load xfce4-custom.tar.bz2
xfconf-query -c xfce4-desktop -p $(xfconf-query -c xfce4-desktop -l | grep "workspace0/last-image") -s /usr/share/backgrounds/img/forest.png
# xfconf-query -c xfce4-keyboard-shortcuts -l
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>e' -s "thunar"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>m' -s "rofi -show drun"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super><Shift>m' -s "rofi -show"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>Return' -s "kitty"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/Print' -s "flameshot gui"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>b' -s "firefox"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Shift>F3' -s "brightnessctl set +5%"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Shift>F2' -s "brightnessctl set 5%-"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super>r' -s "redshift -O 2000"
xfconf-query -c xfce4-keyboard-shortcuts -n -t 'string' -p '/commands/custom/<Super><Shift>r' -s "redshift -x"

read -p "Reboot the system? [Y/n]: " response
if [[ "$response" == "Y" || "$response" == "y" ]]; then
   reboot
else
   echo "Reboot is needed"
fi