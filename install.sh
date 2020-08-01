#!/bin/sh

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

dir=~/dotfiles
dotfiles=$dir/files
files=".gitconfig .gitignore .zshrc"
user=$(whoami)

# Check if dotfiles where installed in the right place
if [ ! -d "$dir" ]; then
  echo -e "${RED}[Error]${NC} dotfiles not found in home directory."
  exit 1
fi

# Add work folder aliased in zsh
mkdir -p ~/work

echo -e "${GREEN}[START]${NC} configuring"

chmod +x install/common.sh
sh install/common.sh

chmod +x install/docker.sh
sh install/docker.sh

chmod +x install/yarn.sh
sh install/yarn.sh

# Configure Terminator
mkdir -p ~/.config/terminator/
mv $dotfiles/.terminator ~/.config/terminator/config

cd $dir

# Make symlink for configuration files
for file in $files; do
  echo "${GREEN}[CREATED]${NC} symlink for $file"
  ln -sf $dotfiles/$file ~/$file
done

source ~/.zshrc

echo -e "${GREEN}[DONE]${NC}"
