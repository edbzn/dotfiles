#!/bin/bash

# Update all dotfiles roles - reinstalls everything regardless of current state
# Usage: ./update.sh [role_tags]
# Example: ./update.sh zsh,docker
# Example: ./update.sh bootstrap (update only bootstrap role)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYBOOK="$SCRIPT_DIR/playbook.yml"
INVENTORY="$SCRIPT_DIR/hosts"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 Updating Dotfiles Environment${NC}"
echo -e "${YELLOW}⚠️  This will reinstall everything regardless of current state${NC}"
echo ""

# Check if ansible is installed
if ! command -v ansible-playbook &> /dev/null; then
    echo -e "${RED}❌ ansible-playbook is not installed. Please install Ansible first.${NC}"
    echo "Run: sudo apt update && sudo apt install ansible"
    exit 1
fi

# Check if inventory file exists
if [[ ! -f "$INVENTORY" ]]; then
    echo -e "${RED}❌ Inventory file not found: $INVENTORY${NC}"
    exit 1
fi

# Check if playbook exists
if [[ ! -f "$PLAYBOOK" ]]; then
    echo -e "${RED}❌ Playbook file not found: $PLAYBOOK${NC}"
    exit 1
fi

# Build the ansible command
ANSIBLE_CMD="ansible-playbook -i $INVENTORY $PLAYBOOK --ask-become-pass -e force_install=true"

# Parse arguments - separate tags from ansible options
TAGS=""
ANSIBLE_OPTIONS=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --check|--diff|--list-tasks|--list-tags|--syntax-check)
            ANSIBLE_OPTIONS="$ANSIBLE_OPTIONS $1"
            shift
            ;;
        -*)
            ANSIBLE_OPTIONS="$ANSIBLE_OPTIONS $1"
            if [[ $# -gt 1 && ! $2 =~ ^- ]]; then
                shift
                ANSIBLE_OPTIONS="$ANSIBLE_OPTIONS $1"
            fi
            shift
            ;;
        *)
            if [[ -z "$TAGS" ]]; then
                TAGS="$1"
            else
                TAGS="$TAGS,$1"
            fi
            shift
            ;;
    esac
done

# Add tags if specified
if [[ -n "$TAGS" ]]; then
    echo -e "${BLUE}🏷️  Updating specific roles: $TAGS${NC}"
    ANSIBLE_CMD="$ANSIBLE_CMD --tags $TAGS"
else
    echo -e "${BLUE}🏷️  Updating all roles${NC}"
fi

# Add any ansible options
if [[ -n "$ANSIBLE_OPTIONS" ]]; then
    ANSIBLE_CMD="$ANSIBLE_CMD$ANSIBLE_OPTIONS"
fi

echo ""
echo -e "${YELLOW}Running command:${NC} $ANSIBLE_CMD"
echo ""

# Run the playbook
if eval "$ANSIBLE_CMD"; then
    echo ""
    echo -e "${GREEN}✅ Update completed successfully!${NC}"
    echo -e "${BLUE}💡 Tip: You may need to restart your shell or run 'source ~/.bashrc' to use new tools${NC}"

    # Optional desktop notification if available
    if command -v notify-send 1>/dev/null 2>&1; then
        notify-send -i face-smile "Dotfiles update complete" "Successfully updated dev environment."
    fi
else
    echo ""
    echo -e "${RED}❌ Update failed. Check the output above for errors.${NC}"
    exit 1
fi
