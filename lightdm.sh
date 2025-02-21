#!/usr/bin/bash

AVATAR=".shinji.ico"
# Set gtk theme as default
sudo apt install -y lightdm lightdm-gtk-greeter
sudo sed -e 's|#greeter-session=.*|greeter-session=lightdm-gtk-greeter|g' /etc/lightdm/lightdm.conf -i.old
# Write gtk theme
sudo sed -e 's|#background=|background=/usr/share/images/desktop-base/evangelion_warning.png|g' /etc/lightdm/lightdm-gtk-greeter.conf -i.old
sudo cp img/${AVATAR} /usr/share/images/desktop-base/.face
echo "default-user-image=/usr/share/images/desktop-base/.face" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
# Install nody-greeter for use custom themes
wget https://github.com/JezerM/nody-greeter/releases/download/1.6.2/nody-greeter-1.6.2-debian.deb
sudo apt install -y gobject-introspection liblightdm-gobject-dev
sudo dpkg -i nody-greeter-1.6.2-debian.deb
rm nody-greeter-1.6.2-debian.deb
# Set nody-greeter theme
git clone https://github.com/vicevalds/lightdm-web-greeter-theme-simple
sudo mv lightdm-web-greeter-theme-simple /usr/share/web-greeter/themes/.
# gruvbox is the default theme for nody-greeter
sudo sed -e 's|gruvbox|lightdm-web-greeter-theme-simple|g' /etc/lightdm/web-greeter.yml -i.old
sudo sed -e 's|greeter-session=.*|greeter-session=nody-greeter|g' /etc/lightdm/lightdm.conf -i.old
# Set theme for lightdm-web-greeter-theme-simple
sudo sed -e "s|''|'ghost_in_the_shell.gif'|g" /usr/share/web-greeter/themes/lightdm-web-greeter-theme-simple/background.js -i.old