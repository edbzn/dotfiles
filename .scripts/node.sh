#!/bin/bash

sudo apt install nodejs npm -y
sudo npm install npm n -g

# Take ownership to allow n without sudo
sudo mkdir -p /usr/local/n
sudo chown -R $(whoami) /usr/local/n
sudo chown -R $(whoami) /usr/local/bin /usr/local/lib /usr/local/include /usr/local/share

# Switch to the last LTS Node.js version
n lts