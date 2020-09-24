# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


DROPBOX_VER="2020.03.04"  # -> https://www.dropbox.com/download?dl=packages/ubuntu/


echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Dropbox\033[0m\n'
sudo apt-get install -y\
    python3-gpg\
    qt5-default
cd "$HOME"
wget "https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_${DROPBOX_VER}_amd64.deb" -O dropbox.deb
sudo apt-get install -y ./dropbox.deb
rm dropbox.deb
sudo nautilus --quit
mkdir -p "$HOME/.dropbox.synced"
dropbox start -i >/dev/null 2>/dev/null &

echo "
|-------------------------|
| Configure Dropbox (1/2) |
|-------------------------|
 - proceed in the dropbox installer
 - sign in via Firefox with credentials below
 - pause syncing
 - move Dropbox folder to ~/.dropbox.synced/Dropbox
 - disable all notifications
"
read -p "Press a key to continue ..." -n1 -r
echo

dropbox autostart y
dropbox exclude add "$HOME/.dropbox.synced/Dropbox/nosync"
dropbox throttle unlimited unlimited
dropbox lansync n
dropbox proxy none
ln -s "$HOME/.dropbox.synced/Dropbox/sync" dropbox

echo "
|-------------------------|
| Configure Dropbox (2/2) |
|-------------------------|
 - verify selective sync, throttles, and proxy
 - resume syncing
 - create dropbox bookmark in Nautilus for sync sub-folder
"
read -p "Press a key to continue ..." -n1 -r
echo

echo "
|------------------------------------------|
| Sync Dropbox (NOTE: this may be delayed) |
|------------------------------------------|
 - wait for Dropbox to finish syncing
 - in a new terminal
   + verify open-*-vault's work
   + verify backup-*-vault-to-*-vault's work
   + verify close-*-vault's work
"
read -p "Press a key to continue ..." -n1 -r
echo
