export EXTS=$(code --list-extensions)
for ext in $EXTS
do
    code --uninstall-extension $ext
done

export EXTS=$(cat ${HOME}/Projects/dotfiles/vscode/extensions)
for ext in $EXTS
do
    code --install-extension $ext
done
