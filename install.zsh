#!/usr/bin/env zsh

# Ensure dotfiles were installed in home directory.
dir=~/.dotfiles
if [ ! -d "$dir" ]; then
  echo -e  "❌ Error: Directory $dir not found, .dotfiles should be cloned in ~/.dotfiles directory."
  exit 1
fi

# Create work folder.
mkdir -p ~/work

# Run the install scripts.
for script in (.scripts/*); chmod +x $script && sh $script

# Configure dotfiles.
for dotfile in *(/); stow -v -t ~/ -S $dotfile