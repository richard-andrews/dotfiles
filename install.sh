#!/usr/bin/env bash
set -e

export MSYS=winsymlinks:nativestrict

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

link() {
  local src="$DOTFILES_DIR/$1"
  local dest="$HOME/$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "Backing up existing $dest -> $dest.bak"
    mv "$dest" "$dest.bak"
  fi

  ln -sf "$src" "$dest"
  echo "Linked $dest -> $src"
}

# --- Scoop + packages ---
source "$DOTFILES_DIR/install-scoop.sh"

# --- Install oh-my-zsh (framework, not tracked in repo) ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "oh-my-zsh already installed, skipping."
fi

# --- Install Powerlevel10k theme ---
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "Powerlevel10k already installed, skipping."
fi

# --- Install any oh-my-zsh plugins you rely on ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/you-should-use" ]; then
  echo "Installing you-should-use..."
  git clone --depth=1 https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"
fi

# --- Symlink personal config files ---
link "zsh/.zshrc"         ".zshrc"
link "zsh/.p10k.zsh"      ".p10k.zsh"
link "git/.gitconfig"     ".gitconfig"
link "bash/.bashrc"       ".bashrc"
link "zsh/.aliases.zsh"   ".aliases.zsh"

# --- VS Code ---
source "$DOTFILES_DIR/install-vscode.sh"

echo "Done. Restart your shell or run: source ~/.zshrc"