# --- Dotfiles sync helpers ---
export DOTFILES_DIR="$HOME/Projects/dotfiles"

alias scoop-sync="scoop export > $DOTFILES_DIR/scoop-packages.json && echo 'Scoop package list updated.'"
alias vscode-sync="code --list-extensions > $DOTFILES_DIR/vscode/extensions.txt && echo 'VS Code extensions list updated.'"

dotfiles-sync() {
  scoop-sync
  vscode-sync
  echo ""
  echo "Updated. Review and commit:"
  cd "$DOTFILES_DIR" && git status --short
}

dotfiles-sync-check() {
  local scoop_diff vscode_diff

  scoop_diff=$(diff <(scoop export) "$DOTFILES_DIR/scoop-packages.json" 2>/dev/null)
  vscode_diff=$(diff <(code --list-extensions) "$DOTFILES_DIR/vscode/extensions.txt" 2>/dev/null)

  if [ -n "$scoop_diff" ] || [ -n "$vscode_diff" ]; then
    echo "⚠️  Dotfiles out of sync:"
    [ -n "$scoop_diff" ] && echo "   - scoop packages changed"
    [ -n "$vscode_diff" ] && echo "   - vscode extensions changed"
    echo "   Run: dotfiles-sync"
  fi
}
# Run dotfiles-sync-check once, after the first prompt has drawn
# (avoids breaking p10k instant prompt with console output during init)
_dotfiles_check_once() {
  dotfiles-sync-check
  add-zsh-hook -d precmd _dotfiles_check_once
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _dotfiles_check_once

# Copy the template .gitignore into the current directory
gitignore-init() {
  local template="$HOME/Projects/dotfiles/git/gitignore-template"
  local dest="./.gitignore"

  if [ ! -f "$template" ]; then
    echo "Template not found at $template"
    return 1
  fi

  if [ -f "$dest" ]; then
    echo ".gitignore already exists here. Overwrite? (y/n)"
    read -r confirm
    if [[ "$confirm" != "y" ]]; then
      echo "Cancelled."
      return 1
    fi
  fi

  cp "$template" "$dest"
  echo "Copied gitignore template to $(pwd)/.gitignore"
}
