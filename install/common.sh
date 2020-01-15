#!/bin/sh

user=$(whoami)

sudo apt install git zsh terminator curl htop vim nodejs npm keychain ksshaskpass kwalletcli -y
sudo npm install npm n -g

# Configure zsh 
sudo chmod -R 755 /usr/local/share/zsh/site-functions
sudo chown -R root:root /usr/local/share/zsh/site-functions

# Take ownership to allow n without sudo
sudo mkdir -p /usr/local/n
sudo chown -R $(user) /usr/local/n
sudo chown -R $(user) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Switch to the last LTS Node.js version
n lts

# Diff tool for Git
sudo npm install diff-so-fancy -g

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"

# Install Chrome stable (x64)
sudo apt install libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome*.deb -f

# Install Fira Code Font
sudo add-apt-repository universe
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"
sudo add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
sudo apt update
sudo apt install fonts-firacode
