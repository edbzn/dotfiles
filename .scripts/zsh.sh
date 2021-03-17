#!/bin/sh

sudo apt update
sudo apt install zsh -y

sudo chmod -R 755 /usr/local/share/zsh/site-functions
sudo chown -R root:root /usr/local/share/zsh/site-functions

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"