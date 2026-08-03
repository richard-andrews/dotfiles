# dotfiles

## About

Personal dotfiles for my Windows dev environment — Git Bash running Zsh with Oh My Zsh and Powerlevel10k, plus Git, Scoop, and VS Code configuration. Everything here is symlinked into place so config changes are tracked in version control automatically, and a single install script can bootstrap a brand new machine.

> **Setting up a brand new machine?** See [`SETUP.md`](./SETUP.md) first — it covers the manual prerequisites (Developer Mode, Git for Windows, Zsh installation) that have to happen before `install.sh` can run.

## What's included

| Path | Links to | Purpose |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | Zsh config, Oh My Zsh + p10k setup |
| `zsh/.p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config |
| `zsh/.aliases.zsh` | `~/.aliases.zsh` | Custom aliases and functions |
| `git/.gitconfig` | `~/.gitconfig` | Git user info and settings |
| `bash/.bashrc` | `~/.bashrc` | Execs into Zsh,  sets `MSYS=winsymlinks:nativestrict`|
| `vscode/settings.json` | `%APPDATA%\Code\User\settings.json` | VS Code editor settings |
| `vscode/keybindings.json` | `%APPDATA%\Code\User\keybindings.json` | VS Code keybindings |
| `vscode/extensions.txt` | — | List of installed extensions (reinstalled, not symlinked) |
| `scoop-packages.json` | — | Exported Scoop package list (reinstalled via `scoop import`) |

Oh My Zsh itself, the Powerlevel10k theme, and Zsh plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`) are **not** tracked in this repo — they're installed fresh by `install.sh` since they're third-party frameworks rather than personal config.

## Requirements

- Windows with [Git for Windows](https://gitforwindows.org/) (provides Git Bash)
- [Developer Mode](https://learn.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development) enabled, so symlinks can be created without admin privileges
- [Scoop](https://scoop.sh/) (installed automatically by the script if missing)
- [VS Code](https://code.visualstudio.com/) with the `code` CLI available on PATH, if you want extensions/settings synced

## Installation

```
git clone https://github.com/yourname/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
chmod +x install.sh install-scoop.sh install-vscode.sh
./install.sh
```

This will:

1. Install Scoop and import packages from `scoop-packages.json`
2. Install Oh My Zsh, Powerlevel10k, and Zsh plugins
3. Symlink `.zshrc`, `.p10k.zsh`, `.aliases.zsh`, `.gitconfig`, and `.bashrc` into `$HOME`
4. Symlink VS Code `settings.json` and `keybindings.json`, and install extensions from `extensions.txt`

Any existing file at a symlink target is backed up to `<file>.bak` before being replaced.

Once finished, restart your terminal or run:

```
source ~/.zshrc
```


## Keeping things in sync

Since `.zshrc`, `.gitconfig`, etc. are symlinks, editing them directly edits the repo — just `git add`, `commit`, and `push` from `~/Projects/dotfiles` when you want to save changes.

Scoop packages and VS Code extensions aren't symlinked (they're installed, not config files), so they can drift out of sync with what's tracked. A few helper commands (defined in `zsh/.aliases.zsh`) make this easy to manage:

| Command | What it does |
|---|---|
| `scoop-sync` | Updates `scoop-packages.json` with currently installed packages |
| `vscode-sync` | Updates `vscode/extensions.txt` with currently installed extensions |
| `dotfiles-sync` | Runs both of the above, then shows `git status` for review |

A `dotfiles-sync-check` runs automatically on every new shell and warns if your installed packages/extensions have drifted from what's tracked in the repo, so nothing gets forgotten before a commit.

## Repo structure

```
dotfiles/
├── install.sh
├── install-scoop.sh
├── install-vscode.sh
├── scoop-packages.json
├── zsh/
│ ├── .zshrc
│ ├── .p10k.zsh
│ └── .aliases.zsh
├── git/
│ └── .gitconfig
├── bash/
│ └── .bashrc
└── vscode/
├── settings.json
├── keybindings.json
└── extensions.txt
```
