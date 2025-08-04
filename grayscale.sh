# https://alexanderzeitler.com/articles/setting-display-monochrome-saturation-0-on-xubuntu-xfce/
# https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_12_.22Bookworm.22

sudo sed -e 's|deb http://deb.debian.org/debian/ bookworm main non-free-firmware|deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware|g' /etc/apt/sources.list -i.old
sudo apt update
sudo apt install nvidia-driver firmware-misc-nonfree libx11-dev xorg-dev libglu1-mesa-dev libxnvctrl-dev -y

git clone https://github.com/libvibrant/libvibrant
mkdir libvibrant/build
cd libvibrant/build; cmake ..; make; sudo make install
cd
sudo /sbin/ldconfig -v

xfconf-query -c xfce4-keyboard-shortcuts \
  -p "/commands/custom/<Super>g" \
  -n -t string \
  -s "sh -c 'vibrant-cli $(xrandr |grep -w connected |head -n1 |cut -d" " -f1) 0'"
xfconf-query -c xfce4-keyboard-shortcuts \
  -p "/commands/custom/<Super><Shift>g" \
  -n -t string \
  -s "sh -c 'vibrant-cli $(xrandr |grep -w connected |head -n1 |cut -d" " -f1) 1'"

read -p "Reboot the system? [Y/n]: " response
if [[ "$response" == "Y" || "$response" == "y" ]]; then
  reboot
else
  echo "[!] Reboot is needed to use nvidia"
fi
