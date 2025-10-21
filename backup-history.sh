#!/bin/bash

# Backup shell history to dotfiles repository
# This allows you to restore your command history on new machines

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/.dotfiles/zsh"
HISTORY_FILE="$HOME/.zsh_history"
BACKUP_FILE="$BACKUP_DIR/.zsh_history.backup"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📚 Backing up Shell History${NC}"
echo ""

# Check if history file exists
if [[ ! -f "$HISTORY_FILE" ]]; then
    echo -e "${RED}❌ No history file found at $HISTORY_FILE${NC}"
    exit 1
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Get file sizes
CURRENT_SIZE=$(wc -l < "$HISTORY_FILE")
if [[ -f "$BACKUP_FILE" ]]; then
    BACKUP_SIZE=$(wc -l < "$BACKUP_FILE")
else
    BACKUP_SIZE=0
fi

echo -e "${YELLOW}Current history:${NC} $CURRENT_SIZE commands"
echo -e "${YELLOW}Backup history:${NC} $BACKUP_SIZE commands"
echo ""

# Backup the history
cp "$HISTORY_FILE" "$BACKUP_FILE"

echo -e "${GREEN}✅ History backed up to:${NC} $BACKUP_FILE"
echo ""
echo -e "${BLUE}💡 Tips:${NC}"
echo "  - Commit and push this backup to keep it in sync"
echo "  - History will be automatically restored on new machines during install"
echo "  - Run this script periodically to keep backup up-to-date"
echo ""
echo -e "${YELLOW}To commit the backup:${NC}"
echo "  cd $SCRIPT_DIR"
echo "  git add .dotfiles/zsh/.zsh_history.backup"
echo "  git commit -m 'chore: backup shell history'"
echo "  git push"
