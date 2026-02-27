#!/usr/bin/env bash

# install.sh — Installs git-acm so you can use `git acm` globally

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/git-acm"

echo ""
echo -e "${CYAN}Installing git-acm...${RESET}"

# Determine install location
if [[ -d "$HOME/.local/bin" ]]; then
  INSTALL_DIR="$HOME/.local/bin"
elif [[ -d "/usr/local/bin" ]]; then
  INSTALL_DIR="/usr/local/bin"
else
  INSTALL_DIR="$HOME/.local/bin"
  mkdir -p "$INSTALL_DIR"
fi

DEST="$INSTALL_DIR/git-acm"

# Copy and make executable
cp "$SOURCE" "$DEST"
chmod +x "$DEST"

echo -e "${GREEN}✓ Installed to: $DEST${RESET}"

# Check if install dir is in PATH
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo ""
  echo -e "${YELLOW}⚠ $INSTALL_DIR is not in your PATH.${RESET}"
  echo "  Add this line to your ~/.bashrc or ~/.zshrc:"
  echo ""
  echo -e "    ${CYAN}export PATH=\"\$HOME/.local/bin:\$PATH\"${RESET}"
  echo ""
  echo "  Then run: source ~/.bashrc  (or source ~/.zshrc)"
else
  echo -e "${GREEN}✓ $INSTALL_DIR is already in your PATH${RESET}"
fi

echo ""
echo -e "${GREEN}🎉 Done! You can now use:${RESET}"
echo "   git acm \"your message\""
echo "   git acm \"your message\" -p"
echo "   git acm \"your message\" -p orm"
echo ""
