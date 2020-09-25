#!/bin/bash

# This is an installation script to set up
# development machines based on Pop! OS.

# Name of the machine. Adjust before installation.
export HOSTNAME="wa-Oryx"

# Some sourced *.sh scripts behave different during installation and update.
export SETUP_SYSTEM="true"

# We need sudo rights for installation but must not be root!
if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root!"
    exit
fi

echo "
|--------------------------------|
| webartifex installation script |
|--------------------------------|
 - adjust the hostname: $HOSTNAME
 - make sure gpg keys are available
"
read -p "Press a key to continue ..." -n1 -r

sudo --validate || exit
cd "$HOME"

echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating the system\033[0m\n'
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get autoremove -y

echo -e '\n\033[36m\033[2m\033[1m\033[7mChanging default folders to lower case names\033[0m\n'
xdg-user-dirs-update --set DESKTOP "$HOME/desktop"
mv "$HOME/Desktop" "$HOME/desktop"
xdg-user-dirs-update --set DOCUMENTS "$HOME/documents"
mv "$HOME/Documents" "$HOME/documents"
xdg-user-dirs-update --set DOWNLOAD "$HOME/downloads"
mv "$HOME/Downloads" "$HOME/downloads"
xdg-user-dirs-update --set MUSIC "$HOME"
rm -r "$HOME/Music"
xdg-user-dirs-update --set PICTURES "$HOME"
rm -r "$HOME/Pictures"
xdg-user-dirs-update --set PUBLICSHARE "$HOME/public"
mv "$HOME/Public" "$HOME/public"
xdg-user-dirs-update --set TEMPLATES "$HOME/templates"
mv "$HOME/Templates" "$HOME/templates"
xdg-user-dirs-update --set VIDEOS "$HOME"
rm -r "$HOME/Videos"

# A lower swappiness results in less hard disk usage by temporary data.
echo -e '\n\033[36m\033[2m\033[1m\033[7mLowering the swappiness\033[0m\n'
echo "vm.swappiness = 5" | sudo tee -a /etc/sysctl.conf > /dev/null

echo -e '\n\033[36m\033[2m\033[1m\033[7mDownloading the setup scripts\033[0m\n'
sudo apt-get install -y git
git clone https://github.com/webartifex/dot-files.git
export DOT_FILES="$HOME/dot-files"
export SH_SCRIPTS="$DOT_FILES/shell"

echo -e '\n\033[36m\033[2m\033[1m\033[7mUse main mirrors and disable reminder\033[0m\n'
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily-upgrade.timer
sudo cp "$DOT_FILES/static/sources.list" /etc/apt/sources.list
sudo apt-get update
sudo apt-get autoclean -y

echo -e '\n\033[36m\033[2m\033[1m\033[7mConfiguring network settings\033[0m\n'
sudo hostnamectl set-hostname "$HOSTNAME"
sudo cp "$DOT_FILES/static/etc_hosts" /etc/hosts
sudo apt-get install -y macchanger
sudo cp "$DOT_FILES/static/macchange.conf" /etc/NetworkManager/conf.d/macchange.conf
# Disable automated network printer search.
sudo systemctl disable avahi-daemon
sudo systemctl disable cups-browsed

echo -e '\n\033[36m\033[2m\033[1m\033[7mRunning the setup scripts\033[0m\n'
source "$SH_SCRIPTS/utils.sh"
source "$SH_SCRIPTS/setup.d/apt.sh"
source "$SH_SCRIPTS/setup.d/firefox.sh"
source "$SH_SCRIPTS/setup.d/git.sh"
source "$SH_SCRIPTS/setup.d/zsh.sh"
source "$SH_SCRIPTS/setup.d/gnome.sh"
source "$SH_SCRIPTS/setup.d/gpg.sh"
source "$SH_SCRIPTS/setup.d/vault_folders.sh"
source "$SH_SCRIPTS/setup.d/python.sh"
source "$SH_SCRIPTS/setup.d/dropbox.sh"
source "$SH_SCRIPTS/setup.d/vpn.sh"
source "$SH_SCRIPTS/setup.d/chromium.sh"
source "$SH_SCRIPTS/setup.d/exa.sh"
source "$SH_SCRIPTS/setup.d/flameshot.sh"
source "$SH_SCRIPTS/setup.d/microsoft.sh"
source "$SH_SCRIPTS/setup.d/signal.sh"
source "$SH_SCRIPTS/setup.d/spotify.sh"
source "$SH_SCRIPTS/setup.d/teamviewer.sh"
source "$SH_SCRIPTS/setup.d/thunderbird.sh"
source "$SH_SCRIPTS/setup.d/zoom.sh"

echo -e '\n\033[36m\033[2m\033[1m\033[7mRemoving the setup scripts\033[0m\n'
rm -rf "$HOME/dot-files"
rm -rf "$HOME/setup.sh"

echo -e "\nInstallation completed. Please restart the machine!"
