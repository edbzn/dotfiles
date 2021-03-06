#!/bin/bash

sudo apt install nodejs npm -y
sudo npm install npm n nx @angular/cli http-server -g

# Take ownership to allow n without sudo
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Switch to the last LTS Node.js version
n lts

# Install Nx completion
sudo apt install jq
git clone git@github.com:jscutlery/nx-completion.git ~/.oh-my-zsh/custom/plugins/nx-completion