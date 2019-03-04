#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

dir=~/.dotfiles
files=".gitconfig .zshrc"

echo -e "${GREEN}[Start]${NC} installing dependencies..."

sudo apt update
sudo apt install git zsh terminator curl htop vim nodejs npm -y
sudo npm install npm -g

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Check if .dotfiles where installed in the right place
if [ ! -d "$dir" ]; then
  echo -e "${RED}[Error]${NC} .dotfiles not found in home directory."
  exit 1
fi

cd $dir

# Make symlink for configuration files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dir/$file ~/$file
done

source ~/.zshrc

echo -e "${GREEN}[Done]${NC} Installation succeed."
