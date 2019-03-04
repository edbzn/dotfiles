#!/bin/bash

sudo apt update
sudo apt install git zsh terminator curl htop

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

dir=~/.dotfiles
git clone git@github.com:Edouardbozon/.dotfiles.git $dir

files=".oh-my-zsh .gitconfig .zshrc"

cd $dir

for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -sf $dir/$file ~/$file
done

echo "done"
