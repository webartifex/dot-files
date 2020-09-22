echo "Installing zsh"
echo
sudo apt-get install -y\
    zsh\
    zsh-doc
echo


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "Installing zplug"
echo
mkdir -p "$HOME/repos/zsh/zplug"
cd "$HOME/repos/zsh/zplug"
git clone git@github.com:zplug/zplug.git
cd "$HOME"
# Contains zplug configuration.
cp "$DOT_FILES/.zshrc" "$HOME/.zshrc"
zsh -ic "zplug install"
echo
