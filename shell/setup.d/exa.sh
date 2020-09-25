echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Exa\033[0m\n'

EXA_VER="0.9.0"  # -> https://github.com/ogham/exa/releases/

cd "$HOME"

wget "https://github.com/ogham/exa/releases/download/v${EXA_VER}/exa-linux-x86_64-${EXA_VER}.zip" -O exa.zip
unzip exa.zip -d exa
sudo mv "$HOME/exa/exa-linux-x86_64" /usr/local/bin/exa
rm exa.zip
rm -rf exa/

wget "https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.bash"
sudo mv "$HOME/completions.bash" /etc/bash_completion.d/exa.sh

wget "https://raw.githubusercontent.com/ogham/exa/master/contrib/completions.zsh"
sudo mv "$HOME/completions.zsh" /usr/local/share/zsh/site-functions/exa.zsh
