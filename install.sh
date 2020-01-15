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

echo -e "${GREEN}[Start]${NC} installing dependencies..."

chmod +x ./install/common.sh
./install/common.sh

chmod +x ./install/docker.sh
./install/docker.sh

chmod +x ./install/yarn.sh
./install/yarn.sh

# Configure Terminator
ln -ls $dotfiles/.terminator ~/.config/terminator/config

cd $dir

# Make symlink for configuration files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dotfiles/$file ~/$file
done

source ~/.zshrc

echo -e "${GREEN}[Done]${NC} Installation succeed."
