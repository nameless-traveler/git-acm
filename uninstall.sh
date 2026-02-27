#!/usr/bin/env bash

# uninstall.sh — Removes git-acm from your system

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'

LOCATIONS=(
  "$HOME/.local/bin/git-acm"
  "/usr/local/bin/git-acm"
)

REMOVED=false

for LOC in "${LOCATIONS[@]}"; do
  if [[ -f "$LOC" ]]; then
    rm "$LOC"
    echo -e "${GREEN}✓ Removed: $LOC${RESET}"
    REMOVED=true
  fi
done

if ! $REMOVED; then
  echo -e "${RED}✗ git-acm not found in common install locations.${RESET}"
  exit 1
fi

echo ""
echo -e "${GREEN}🗑 git-acm uninstalled.${RESET}"
