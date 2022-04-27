echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling xcape\033[0m\n'

# Source: https://github.com/alols/xcape

sudo apt install -y\
    git\
    gcc\
    make\
    pkg-config\
    libx11-dev\
    libxtst-dev\
    libxi-dev

cd "$HOME"

git clone https://github.com/alols/xcape.git
cd "$HOME/xcape"
make
sudo make install

cd "$HOME"
rm -rf "$HOME/xcape"
