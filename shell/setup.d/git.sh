PASS_LN_VER="1.0.0"  # -> https://github.com/raxod502/pass-ln/releases 


echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling git\033[0m\n'
sudo apt install -y\
    git\
    git-flow\
    git-lfs


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


EMAIL="alexander@webartifex.biz"
GH_VER="2.9.0"  # -> https://github.com/cli/cli/releases/
TIG_VER="2.5.5"  # -> https://github.com/jonas/tig/releases/


echo "
|------------------|
| Generate SSH key |
|------------------|
 - follow the instructions in the CLI below
"
ssh-keygen -a 100 -t ed25519 -C "$EMAIL ($HOSTNAME)"
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_ed25519"
xclip -sel clip < "$HOME/.ssh/id_ed25519.pub"
firefox --new-tab "https://github.com/settings/keys" >/dev/null 2>/dev/null &
echo

echo "
|----------------------|
| Configure git/GitHub |
|----------------------|
 - get GitHub account details from another source
 - copy SSH key to GitHub (already in clipboard)
 - confirm 'github.com' as authentic in the CLI below
"
read -p "Press a key to continue ..." -n1 -r
echo

echo -e '\n\033[36m\033[2m\033[1m\033[7mCloning repositories\033[0m\n'
export REPOS="$HOME/repos"
mkdir "$REPOS"
cd "$REPOS"
# Clone repos from gitlab.webartifex.biz
git clone git@git.webartifex.biz:alexander/ames-housing.git
git clone git@git.webartifex.biz:alexander/collectartworks.git
git clone git@git.webartifex.biz:alexander/dot-files.git
git clone git@git.webartifex.biz:alexander/intro-to-data-science.git
git clone git@git.webartifex.biz:alexander/intro-to-python.git
git clone git@git.webartifex.biz:alexander/intro-to-sql.git
git clone git@git.webartifex.biz:alexander/lalib.git
git clone git@git.webartifex.biz:alexander/scripts.git
git clone git@git.webartifex.biz:alexander/tidy-data.git
git clone git@git.webartifex.biz:alexander/urban-meal-delivery.git
git clone git@git.webartifex.biz:alexander/urban-meal-delivery-demand-forecasting.git
# The passwords go into pass's default folder
git clone git@git.webartifex.biz:alexander/passwords.git ~/.password-store
# Clone repos from github.com
git clone git@github.com:webartifex/webartifex.git ./github-profile
cd "$HOME"

echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling pass-ln extension\033[0m\n'
wget "https://github.com/raxod502/pass-ln/releases/download/v${PASS_LN_VER}/pass-extension-ln-${PASS_LN_VER}.deb" -O pass-ln.deb
sudo apt install ./pass-ln.deb
rm pass-ln.deb

rm "$HOME/.bash_history" 2>/dev/null
rm "$HOME/.bash_logout" 2>/dev/null
rm "$HOME/.profile" 2>/dev/null
cp "$DOT_FILES/.bashrc" "$HOME/.bashrc"
cp "$DOT_FILES/.gitconfig" "$HOME/.gitconfig"

echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling gh\033[0m\n'
wget "https://github.com/cli/cli/releases/download/v${GH_VER}/gh_${GH_VER}_linux_amd64.deb" -O gh.deb
sudo apt install -y ./gh.deb
rm gh.deb

echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling tig\033[0m\n'
sudo apt install tig
