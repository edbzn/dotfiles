#!/bin/bash
set -e 

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt install ansible
fi


# # Ensure dotfiles were installed in home directory.
# dir=~/.dotfiles
# if [ ! -d "$dir" ]; then
#   echo -e  "❌ Directory $dir not found, .dotfiles should be cloned in home directory."
#   exit 1
# fi

# # Create work folder.
# mkdir -p ~/work

# # Run the install scripts.
# for script in .scripts/*; do
#   chmod +x $script && sh $script
# done

# # Configure dotfiles.
# for dotfile in *(/); do
#   stow -v -t ~/ -S $dotfile
# done

ansible-playbook -i ./hosts ./dotfiles.yml --ask-become-pass

# If terminal-notifier is installed, use it to display a notification.
if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: install complete" -message "Successfully set up dev environment."
fi