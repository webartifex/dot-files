echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Spotify\033[0m\n'

# Non-installation specific code is executed after this if statement.
if [ -n "$SETUP_SYSTEM" ]; then
    # The key must be put into the trusted.gpg.d directory explicitly, not the deprecated trusted.gpg file
    wget -qO- https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/spotify.gpg >/dev/null
    curl -sS  | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo apt update
    sudo apt upgrade -y

fi

sudo apt install -y spotify-client
