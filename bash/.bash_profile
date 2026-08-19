# ~/.bash_profile
# Note: Windows Terminal's Git Bash profile launches bash non-login, so this
# file is not read in normal use. MSYS is set in .bashrc instead. Kept here
# for portability in case Git Bash is ever launched as a login shell.

test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc
