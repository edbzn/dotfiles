#!/bin/bash

echo "[Start] .dotfiles not found in home directory"

sudo apt update
sudo apt install git zsh terminator curl htop vim -y

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

dir=~/.dotfiles
files=".gitconfig .zshrc"

if [ ! -d "$dir" ]; then
  echo "[Error] .dotfiles not found in home directory"
  exit 1
fi

cd $dir

for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dir/$file ~/$file
done

source ~/.zshrc

echo "[Done] Installation succeed"
