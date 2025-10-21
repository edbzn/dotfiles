#!/bin/bash

# Setup git hooks for local development
# Run this once after cloning the repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$SCRIPT_DIR/.git/hooks"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔗 Setting up Git hooks...${NC}"

# Create hooks directory if it doesn't exist
mkdir -p "$HOOKS_DIR"

# Copy pre-commit hook
if [ -f "$SCRIPT_DIR/.git-hooks/pre-commit" ]; then
    cp "$SCRIPT_DIR/.git-hooks/pre-commit" "$HOOKS_DIR/pre-commit"
    chmod +x "$HOOKS_DIR/pre-commit"
    echo -e "${GREEN}✅ Pre-commit hook installed${NC}"
else
    echo "⚠️  Pre-commit hook not found at .git-hooks/pre-commit"
fi

echo ""
echo -e "${GREEN}✅ Git hooks setup complete!${NC}"
echo ""
echo "The following checks will run before each commit:"
echo "  - Ansible syntax validation"
echo "  - YAML linting"
echo "  - Shell script checking"
echo "  - Secret scanning"
