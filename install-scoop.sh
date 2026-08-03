#!/usr/bin/env bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"

# --- Install Scoop itself ---
if ! command -v scoop &> /dev/null; then
  echo "Installing Scoop..."
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \
    "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod get.scoop.sh | Invoke-Expression"
else
  echo "Scoop already installed, skipping."
fi

# --- Import packages ---
if [ -f "$DOTFILES_DIR/scoop-packages.json" ]; then
  echo "Importing Scoop packages..."
  scoop import "$DOTFILES_DIR/scoop-packages.json"
else
  echo "No scoop-packages.json found, skipping package import."
fi
