firefox & disown
firefox https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
firefox https://obsidian.md/download
firefox https://code.visualstudio.com/docs/?dv=linux64_deb
firefox https://discord.com/api/download?platform=linux&format=deb
firefox https://telegram.org/dl/desktop/linux

if false; then
    wget -qO- https://get.pnpm.io/install.sh | sh -
    pnpm env use --global lts
fi

if false; then
    curl -f https://zed.dev/install.sh | sh
    # Miniconda quick install
    mkdir -p ~/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm ~/miniconda3/miniconda.sh
fi
