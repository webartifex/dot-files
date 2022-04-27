echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling TeamViewer\033[0m\n'

cd "$HOME"

# The key must be put into the trusted.gpg.d directory explicitly, not the deprecated trusted.gpg file
wget -qO- https://download.teamviewer.com/download/linux/signature/TeamViewer2017.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/teamviewer.gpg >/dev/null
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install -y ./teamviewer_amd64.deb
rm teamviewer_amd64.deb


if [ -n "$SETUP_SYSTEM" ]; then

    mkdir -p "$HOME/.config/teamviewer"
    cp "$DOT_FILES/static/teamviewer.conf" "$HOME/.config/teamviewer/client.conf"

    teamviewer >/dev/null 2>/dev/null &
    echo "
|----------------------|
| Configure TeamViewer |
|----------------------|
 - assign device to account with credentials shown below
 - set pass password for unattended access
 - disable TeamViewer shutdown if workstation
 - changes require admin rights with password
"
    pass show tools/teamviewer.com
    echo
    read -p "Press a key to continue ..." -n1 -r
    echo

fi
