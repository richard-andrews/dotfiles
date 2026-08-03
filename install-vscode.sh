#!/usr/bin/env bash
set -e

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
VSCODE_USER_DIR="$HOME/AppData/Roaming/Code/User"

link_vscode() {
  local src="$DOTFILES_DIR/vscode/$1"
  local dest="$VSCODE_USER_DIR/$1"

  mkdir -p "$VSCODE_USER_DIR"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $dest -> $src"
}

link_vscode "settings.json"
link_vscode "keybindings.json"

# --- Install extensions ---
if command -v code &> /dev/null; then
  if [ -f "$DOTFILES_DIR/vscode/extensions.txt" ]; then
    echo "Installing VS Code extensions..."
    while read -r ext; do
      [ -n "$ext" ] && code --install-extension "$ext"
    done < "$DOTFILES_DIR/vscode/extensions.txt"
  fi
else
  echo "VS Code CLI ('code') not found in PATH, skipping extension install."
fi
