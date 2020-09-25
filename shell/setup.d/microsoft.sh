echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Microsoft products\033[0m\n'

cd "$HOME"

echo "Installing Teams"
# Source: https://www.microsoft.com/de-de/microsoft-365/microsoft-teams/download-app
wget "https://go.microsoft.com/fwlink/p/?linkid=2112886" -O teams.deb
sudo apt-get install -y ./teams.deb
rm teams.deb

echo "Installing Skype"
wget https://go.skype.com/skypeforlinux-64.deb
sudo apt-get install -y ./skypeforlinux-64.deb
rm skypeforlinux-64.deb


if [ -n "$SETUP_SYSTEM" ]; then

    teams
    echo "
|-----------------|
| Configure Teams |
|-----------------|
  - sign in with WHU account details below
"
    pass show university/whu.edu
    echo
    read -p "Press a key to continue ..." -n1 -r

    skypeforlinux
    echo "
|-----------------|
| Configure Skype |
|-----------------|
  - sign in with account details below
"
    pass show communicate/microsoft.skype.live.com
    echo
    read -p "Press a key to continue ..." -n1 -r

fi
