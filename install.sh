#!/bin/sh

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

dir=~/dotfiles
dotfiles=$dir/files
files=".gitconfig .zshrc"
user=$(whoami)

# Check if dotfiles where installed in the right place
if [ ! -d "$dir" ]; then
  echo -e "${RED}[Error]${NC} dotfiles not found in home directory."
  exit 1
fi

# Add work folder aliased in zsh
mkdir ~/work

# Yarn completion plugin
git clone https://github.com/buonomo/yarn-completion ~/.oh-my-zsh/custom/plugins/yarn-completion

echo -e "${GREEN}[Setup]${NC} dependencies..."

chmod +x install/common.sh
sh install/common.sh

chmod +x install/docker.sh
sh install/docker.sh

chmod +x install/yarn.sh
sh install/yarn.sh

# Configure Terminator
ln -sf $dotfiles/.terminator ~/.config/terminator/config

cd $dir

# Make symlink for configuration files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dotfiles/$file ~/$file
done

echo -e "${GREEN}[Setup]${NC} KDE scripts..."

cp add_key.sh ~/.kde/Autostart/
chmod +x ~/.kde/Autostart/add_key.sh

cp keychain.sh ~/.kde/env/
chmod +x ~/.kde/env/keychain.sh

echo -e "${GREEN}[Setup]${NC} KDE scripts copied."

source ~/.zshrc

echo -e "${GREEN}[Done]${NC}"
