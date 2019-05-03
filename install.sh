#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

dir=~/.dotfiles
configurations=$dir/configurations
files=".gitconfig .zshrc"
user=$(whoami)

# Check if .dotfiles where installed in the right place
if [ ! -d "$dir" ]; then
  echo -e "${RED}[Error]${NC} .dotfiles not found in home directory."
  exit 1
fi

# Add work folder aliased in zsh
mkdir ~/work

echo -e "${GREEN}[Start]${NC} installing dependencies..."

# Remove cmdtest before Yarn install (Ubuntu only)
sudo apt remove cmdtest

# Add Yarn package
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Common dependencies
sudo apt update
sudo apt install git zsh terminator curl htop vim nodejs npm yarn -y
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

# Install Docker CE
sudo apt install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
 
sudo usermod -aG docker $(user)

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Install Docker-Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

# Configure Terminator
ln -sf $configurations/.terminator ~/.config/terminator/config

# Add ssh key at bootstrap (KDE only)
ln -sf $configurations/.add-ssh-key.sh ~/.config/autostart-scripts/ssh-add.sh

cd $dir

# Make symlink for configuration files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $configurations/$file ~/$file
done

source ~/.zshrc

echo -e "${GREEN}[Done]${NC} Installation succeed."
