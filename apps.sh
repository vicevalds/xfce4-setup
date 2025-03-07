# txt editor
firefox https://code.visualstudio.com/docs/?dv=linux64_deb
curl -f https://zed.dev/install.sh | sh
#cp -r .config/zed ~/.config/.
# Miniconda
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
#mv Miniconda3-latest-Linux-x86_64.sh ~/Downloads/.
# Miniconda quick install
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm ~/miniconda3/miniconda.sh
# Others
firefox https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
firefox https://discord.com/api/download?platform=linux&format=deb
firefox https://obsidian.md/download
firefox https://telegram.org/dl/desktop/linux
