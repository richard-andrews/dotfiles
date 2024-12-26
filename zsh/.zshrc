# Enable Powerlevel10k instant prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# update automatically without asking
zstyle ':omz:update' mode auto

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Display dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Command execution time format in history
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use aliases python ubuntu)
source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias p10kconfig="code ~/.p10k.zsh"
alias main="git switch main && git fetch --all && git pull"
alias master="git switch master && git fetch --all && git pull"
alias stash="git stash push -m \"$(git branch --show-current)\""
alias pop="git stash pop"
alias back="git switch -"
alias rmlog="rm -v *.log"
alias cpy="xclip -sel c < "
alias pst="xclip -o"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Functions
