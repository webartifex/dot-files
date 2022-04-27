echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling zsh\033[0m\n'
sudo apt install -y\
    zsh


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling zplug\033[0m\n'
mkdir -p "$HOME/repos/zsh/zplug"
cd "$HOME/repos/zsh/zplug"
git clone git@github.com:zplug/zplug.git
cd "$HOME"
# Contains zplug configuration.
cp "$DOT_FILES/.zshrc" "$HOME/.zshrc"
zsh -ic "zplug install"
# Make zsh the default logon shell
chsh -s $(which zsh)
# Needed during installation; afterwards, set by zsh itself.
export ZSH="$REPOS/zsh/robbyrussell/oh-my-zsh"
