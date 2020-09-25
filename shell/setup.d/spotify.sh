echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Spotify\033[0m\n'

# Non-installation specific code is executed after this if statement.
if [ -n "$SETUP_SYSTEM" ]; then

    curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
    curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

    sudo apt-get update
    sudo apt-get upgrade --yes

fi

sudo apt-get install --no-install-recommends --yes spotify-client
