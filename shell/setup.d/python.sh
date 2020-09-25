echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Python\033[0m\n'

# testresources as otherwise setuptools emits a weird warning,
# and venv as otherwise pipx does not work.
sudo apt-get install -y\
    python-is-python3\
    python3-pip\
    python3-testresources\
    python3-venv

# pyenv dependencies.
sudo apt-get install -y\
    build-essential\
    curl\
    git\
    libbz2-dev\
    libffi-dev\
    liblzma-dev\
    libncurses5-dev\
    libncursesw5-dev\
    libreadline-dev\
    libsqlite3-dev\
    libssl-dev\
    libxml2-dev\
    libxmlsec1-dev\
    llvm\
    make\
    python-is-python3\
    python-setuptools-doc\
    python3-openssl\
    tk-dev\
    wget\
    xz-utils\
    zlib1g-dev

# Make put-on-path available.
if [ -n "$SETUP_SYSTEM" ]; then
    source "$SH_SCRIPTS/path.sh"
fi

# Create a new user-site environment with various utilities.
python3 -m pip install --user --upgrade pip pipx setuptools virtualenv
echo -e "\nInstalling pipx"
rm -rf "$HOME/.local/pipx"
put-on-path "$HOME/.local/bin"
pipx install autoflake
pipx install black
pipx install bpython
pipx install invoke
pipx install ipython
pipx install isort
pipx install mackup
pipx install nox
pipx install pipenv
pipx install pylint
pipx install toml-sort
pipx install tox
pipx install twine
pipx install youtube-dl


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


cd "$HOME"

echo -e "\nInstalling poetry"
# Note: This must be done here "globally." Installing poetry with,
# for example, pipx results in poetry not integrating well with pyenv.
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
put-on-path "$HOME/.poetry/bin"
poetry -V
eval "$(poetry completions bash)"
poetry config virtualenvs.create true
poetry config virtualenvs.in-project true

echo -e "\nInstalling pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
put-on-path "$HOME/.pyenv/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
# The following should be updated regularly.
pyenv install 2.7.18
pyenv install 3.5.10
pyenv install 3.6.12
pyenv install 3.7.9
pyenv install 3.8.5
pyenv install 3.9.0rc1
pyenv install anaconda3-2020.02
pyenv local anaconda3-2020.02
pyenv rehash
conda update -y conda
conda install -y -c anaconda anaconda-navigator
rm .python-version
