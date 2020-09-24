echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Firefox\033[0m\n'
sudo apt-get install -y\
    firefox\
    apparmor-profiles\
    apparmor-utils\
    appmenu-gtk2-module\
    appmenu-gtk3-module\
    chrome-gnome-shell\
    gir1.2-gtop-2.0  # needed for system-monitor extension


# Non-installation specific code is executed after this if statement.
if [ -n "$SETUP_SYSTEM" ]; then

    echo "
|-------------------|
| Configure Firefox |
|-------------------|
 - unpack firefox-profile.zip (from another source) into ~/.mozilla
 - get Firefox account details from another source
 - log out and back in -> ensure no devices are sharing logins
 - change device name in sync settings
 - sync the Gnome Shell extensions
 - close/restart browser
"
    read -p "Press a key to continue ..." -n1 -r
    echo

fi

echo -e '\n\033[36m\033[2m\033[1m\033[7mMoving Gnome Shell extensions to global folder\033[0m\n'
# The global folder may contain old versions that are removed.
cwd=$(pwd)
cd "$HOME/.local/share/gnome-shell/extensions"
in-zsh && unsetopt NOMATCH
for dir in */; do
    sudo rm -rf "/usr/share/gnome-shell/extensions/$dir"
done
sudo mv $HOME/.local/share/gnome-shell/extensions/* /usr/share/gnome-shell/extensions 2>/dev/null
in-zsh && setopt NOMATCH
cd "$cwd"
