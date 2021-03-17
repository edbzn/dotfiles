#!/bin/sh

set -e

dir=~/.dotfiles
user=$(whoami)

# Ensure dotfiles were installed in home directory
if [ ! -d "$dir" ]; then
  echo -e "${RED}[Error]${NC} dotfiles not found in home directory."
  exit 1
fi

# Add work folder aliased in .zshrc
mkdir -p ~/work

chmod +x install/common.sh
sh install/common.sh

chmod +x install/docker.sh
sh install/docker.sh

chmod +x install/yarn.sh
sh install/yarn.sh