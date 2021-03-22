#!/bin/bash

# Ensure dotfiles were installed in home directory.
dir=~/.dotfiles
if [ ! -d "$dir" ]; then
  echo -e  "❌ Directory $dir not found, .dotfiles should be cloned in home directory."
  exit 1
fi

# Create work folder.
mkdir -p ~/work

# Run the install scripts.
for script in .scripts/*; do
  chmod +x $script && sh $script
done

# Configure dotfiles.
for dotfile in *(/); do
  stow -v -t ~/ -S $dotfile
done