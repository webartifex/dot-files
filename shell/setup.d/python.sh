echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Python\033[0m\n'

# pyenv dependencies
sudo apt install -y\
    build-essential\
    curl\
    git\
    libbz2-dev\
    libffi-dev\
    liblzma-dev\
    libncursesw5-dev\
    libreadline-dev\
    libsqlite3-dev\
    libssl-dev\
    libxml2-dev\
    libxmlsec1-dev\
    llvm\
    make\
    tk-dev\
    wget\
    xz-utils\
    zlib1g-dev


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


cd "$HOME"

echo -e "\nInstalling pyenv\n"
# curl https://pyenv.run | bash
git clone https://github.com/pyenv/pyenv.git "$HOME/.pyenv"
git clone https://github.com/pyenv/pyenv-doctor.git "$HOME/.pyenv/plugins/pyenv-doctor"
git clone https://github.com/pyenv/pyenv-update.git "$HOME/.pyenv/plugins/pyenv-update"
git clone https://github.com/pyenv/pyenv-virtualenv.git "$HOME/.pyenv/plugins/pyenv-virtualenv"
git clone https://github.com/pyenv/pyenv-which-ext.git "$HOME/.pyenv/plugins/pyenv-which-ext"
exec $SHELL -l


source "$HOME/.config/shell/utils.sh"
create-or-update-python-develop-envs


pyenv virtualenv "$py_versions[-1]" utils
export PYENV_VERSION="utils"
pip install --upgrade pip setuptools
py_utilities=('pipx')
for util in ${py_utilities[@]}; do
    pip install --upgrade $util
done
