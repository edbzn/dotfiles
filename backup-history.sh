#!/bin/bash

# Backup shell history to dotfiles repository
# This allows you to restore your command history on new machines
# Automatically filters out commands containing secrets and API keys

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$SCRIPT_DIR/.dotfiles/zsh"
HISTORY_FILE="$HOME/.zsh_history"
BACKUP_FILE="$BACKUP_DIR/.zsh_history.backup"
TEMP_FILE="$(mktemp)"

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

# Patterns to filter out (case-insensitive)
# These patterns match common secrets, tokens, and API keys
FILTER_PATTERNS=(
    "export.*API.*KEY"
    "export.*TOKEN"
    "export.*SECRET"
    "export.*PASSWORD"
    "AWS_.*KEY"
    "GITHUB_TOKEN"
    "NPM_TOKEN"
    "api[_-]?key"
    "api[_-]?secret"
    "access[_-]?token"
    "auth[_-]?token"
    "bearer.*token"
    "password"
    "passwd"
    "[0-9a-fA-F]{32,}"  # Long hex strings (API keys)
    "NRAK-[A-Z0-9]+"    # New Relic keys
    "xox[baprs]-[0-9a-zA-Z-]+"  # Slack tokens
    "ghp_[0-9a-zA-Z]{36}"       # GitHub Personal Access Tokens
    "gho_[0-9a-zA-Z]{36}"       # GitHub OAuth tokens
    "sk-[0-9a-zA-Z]{20,}"       # OpenAI API keys
    "AIza[0-9A-Za-z\\-_]{35}"   # Google API keys
)

# Get file sizes
ORIGINAL_SIZE=$(wc -l < "$HISTORY_FILE")
if [[ -f "$BACKUP_FILE" ]]; then
    BACKUP_SIZE=$(wc -l < "$BACKUP_FILE")
else
    BACKUP_SIZE=0
fi

echo -e "${YELLOW}Original history:${NC} $ORIGINAL_SIZE commands"
echo -e "${YELLOW}Previous backup:${NC} $BACKUP_SIZE commands"
echo ""

# Build grep pattern
GREP_PATTERN=$(IFS='|'; echo "${FILTER_PATTERNS[*]}")

# Filter out sensitive commands
echo -e "${BLUE}🔒 Filtering sensitive information...${NC}"
grep -viE "$GREP_PATTERN" "$HISTORY_FILE" > "$TEMP_FILE" || true

FILTERED_SIZE=$(wc -l < "$TEMP_FILE")
REMOVED=$((ORIGINAL_SIZE - FILTERED_SIZE))

if [[ $REMOVED -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  Removed $REMOVED potentially sensitive commands${NC}"
fi
echo -e "${GREEN}✅ Filtered history:${NC} $FILTERED_SIZE commands"
echo ""

# Move filtered history to backup location
mv "$TEMP_FILE" "$BACKUP_FILE"

echo -e "${GREEN}✅ History backed up to:${NC} $BACKUP_FILE"
echo ""
echo -e "${BLUE}💡 Tips:${NC}"
echo "  - Sensitive commands (API keys, tokens, passwords) were automatically filtered"
echo "  - Commit and push this backup to keep it in sync"
echo "  - History will be automatically restored on new machines during install"
echo "  - Run this script periodically to keep backup up-to-date"
echo ""
echo -e "${YELLOW}To commit the backup:${NC}"
echo "  cd $SCRIPT_DIR"
echo "  git add .dotfiles/zsh/.zsh_history.backup"
echo "  git commit -m 'chore: backup shell history'"
echo "  git push"
