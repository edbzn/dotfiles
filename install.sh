#!/bin/bash
set -e 

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt install ansible
fi

ansible-playbook -i ./hosts ./dotfiles.yml --ask-become-pass

# If terminal-notifier is installed, use it to display a notification.
if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: install complete" -message "Successfully set up dev environment."
fi
