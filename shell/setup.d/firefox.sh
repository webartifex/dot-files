echo "Installing Firefox"
sudo apt-get install -y\
    firefox\
    apparmor-profiles\
    apparmor-utils\
    appmenu-gtk2-module\
    appmenu-gtk3-module\
    chrome-gnome-shell\
    gir1.2-gtop-2.0  # needed for system-monitor extension
echo

echo "Moving Gnome shell extensions to global folder (from user-site)"
# The global folder may contain old versions that are removed.
cwd=$(pwd)
cd "$HOME/.local/share/gnome-shell/extensions"
for dir in */; do
    echo "Remove old verson of Gnome Shell extension $dir"
    rm -rf "/usr/share/gnome-shell/extensions/$dir"
done
sudo mv "$HOME/.local/share/gnome-shell/extensions/*" /usr/share/gnome-shell/extensions
cd $cwd
echo


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|-------------------|
| Configure Firefox |
|-------------------|
 - unpack firefox-profile.zip (from another source) into ~/.mozilla
 - get Firefox account details from another source and log-in
 - close/restart browser
"
read -p "Press a key to continue ..." -n1 -r
echo

# Don't use the system uBlock extension.
sudo rm -rf /usr/share/mozilla/extensions/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}/uBlock0@raymondhill.net/
# Chromium has a symbolic link.
sudo rm -rf /usr/share/chromium/extensions/ublock-origin/
echo
