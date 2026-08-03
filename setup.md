# Setup

Manual, one-time steps required on a fresh Windows machine before `install.sh` can do the rest. Setup for Zsh + Oh My Zsh + Powerlevel10k was originally adapted from [glenkusuma's Git Bash + Zsh + p10k gist](https://gist.github.com/glenkusuma/7d7df65a89e485ec2f4690fdc88fffd6), with some deviations noted below (this setup uses Windows Terminal rather than standalone mintty).

## 1. Enable Developer Mode

Required so Git Bash can create real symlinks without admin elevation.

Settings → Privacy & security → For developers → Developer Mode → On

## 2. Install Windows Terminal

Usually preinstalled on Windows 11. If missing, install from the Microsoft Store.

## 3. Install Git for Windows (official installer — not Scoop)

Download and run: https://git-scm.com/download/win

This provides Git Bash and registers a `GitForWindows` registry key, which Windows Terminal reads automatically to generate a working Git Bash profile — no manual Windows Terminal configuration needed for this part.

Default install options are fine. Confirm afterwards:

```bash
which git
git --version
```

Should resolve to something under `/mingw64/bin/git`.

> [!NOTE] 
> Windows Terminal's Git Bash profile launches bash as a **non-login interactive shell**, meaning `.bash_profile` is never read — only `.bashrc` runs. Any environment variables needed before Zsh starts (e.g. `MSYS=winsymlinks:nativestrict` for native symlink support) must be set in `.bashrc`, not `.bash_profile`.

## 4. Install Zsh into Git Bash

Git for Windows ships Bash, but not Zsh — it needs to be added manually.

1. Download the latest zsh package for MSYS2 (x86_64) from:
   https://packages.msys2.org/package/zsh?repo=msys&variant=x86_64
2. Extract the `.pkg.tar.zst` archive using [PeaZip](https://peazip.github.io/zst-compressed-file-format.html) or similar.
3. Extract the contents into `C:\Program Files\Git` (merge with existing folders).
4. Open Git Bash and confirm:

```bash
zsh --version
```

5. Run `zsh` once standalone and step through its first-run configuration prompts (history, completion, etc.) — this creates a baseline `.zshrc` that will be overwritten by the dotfiles repo shortly, so answers here don't matter much.


## 5. Fix the git-prompt.sh warning (if it appears)

If you see `ERROR: this script is obsolete, please see git-completion.zsh` when opening a shell:

```bash
mkdir -p ~/.config/git
touch ~/.config/git/git-prompt.sh
```

## 6. (Optional) Install a Nerd Font for Powerlevel10k icons

Only needed if p10k's prompt shows broken/missing icons (boxes, blanks) rather than clean symbols. Can be installed via Scoop:

```bash
scoop bucket add nerd-fonts
scoop install nerd-fonts/CascadiaCode-NF
```

Then set it in Windows Terminal: Settings → Git Bash profile → Appearance → Font face → `CaskaydiaCove Nerd Font` (or similar, depending on exact package naming).

## 7. Clone and run the dotfiles installer

```bash
git clone https://github.com/yourname/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
chmod +x install.sh install-scoop.sh install-vscode.sh
./install.sh
```

This handles: Scoop + packages, Oh My Zsh, Powerlevel10k, the `git` plugin, all symlinked config files, VS Code settings/extensions, and Windows Terminal settings.

## 8. Restart the terminal

Close and reopen Windows Terminal completely (not just a new tab) so the Git Bash profile, symlinked `.bashrc`/`.zshrc`, and p10k config all take effect cleanly.

If Powerlevel10k's configuration wizard doesn't run automatically and the prompt looks unconfigured, trigger it manually:

```bash
p10k configure
```
