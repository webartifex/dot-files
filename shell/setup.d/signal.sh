echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Signal\033[0m\n'

# Non-installation specific code is executed after this if statement.
if [ -n "$SETUP_SYSTEM" ]; then

    curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

    sudo apt-get update
    sudo apt-get upgrade -y

fi

sudo apt-get install -y signal-desktop
