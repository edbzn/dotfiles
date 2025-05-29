#!/bin/bash

# Regular install script (with idempotency - only installs what's missing)
# Usage: ./install.sh [role_tags]
# Example: ./install.sh --tags zsh,docker
# For force reinstall: use ./force-install.sh

set -e

cd "$(dirname "$0")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Installing Dotfiles Environment${NC}"
echo -e "${GREEN}✨ Only missing components will be installed (idempotent)${NC}"
echo ""

if ! [ -x "$(command -v ansible)" ]; then
  echo -e "${YELLOW}📦 Installing Ansible...${NC}"
  sudo apt install ansible
fi

echo -e "${BLUE}📋 Installing Ansible Galaxy requirements...${NC}"
ansible-galaxy install -r ./meta/requirements.yml

echo -e "${BLUE}🎭 Running Ansible playbook...${NC}"
ansible-playbook -i ./hosts ./playbook.yml --ask-become-pass "$@"

if command -v notify-send 1>/dev/null 2>&1; then
  notify-send -i face-smile "Dotfiles install complete" "Successfully set up dev environment."
fi

echo ""
echo -e "${GREEN}✅ Installation completed successfully!${NC}"
echo -e "${BLUE}💡 Tip: You may need to restart your shell or run 'source ~/.bashrc' to use new tools${NC}"
echo -e "${YELLOW}🔄 To force reinstall everything, use: ./force-install.sh${NC}"
