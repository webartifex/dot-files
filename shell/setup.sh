#!/bin/bash

# This is an installation script to set up
# development machines based on "Pop! OS 21.10".

# Name of the machine. Adjust before installation.
export HOSTNAME="CHANGE-ME"

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
 - it's enough to put only this file in the ~ folder
 - adjust the hostname: $HOSTNAME
 - make sure gpg keys are available
"
read -p "Press a key to continue ..." -n1 -r

sudo --validate || exit
cd "$HOME"

echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating the system\033[0m\n'
sudo sed -i 's|http://us.|http://de.|' /etc/apt/sources.list.d/system.sources
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt autoclean -y
sudo apt clean -y
sudo apt autoremove -y

echo -e '\n\033[36m\033[2m\033[1m\033[7mChanging default folders to lower case names\033[0m\n'
# All folders except `~/desktop` and `~/downloads` will be integrated into `~/nextcloud` later
xdg-user-dirs-update --set DESKTOP "$HOME/desktop"
xdg-user-dirs-update --set DOCUMENTS "$HOME/desktop"  # only temporary
xdg-user-dirs-update --set MUSIC "$HOME/desktop"  # only temporary
xdg-user-dirs-update --set PICTURES "$HOME/desktop"  # only temporary
xdg-user-dirs-update --set PUBLICSHARE "$HOME/desktop"  # only temporary
xdg-user-dirs-update --set TEMPLATES "$HOME/desktop"  # only temporary
xdg-user-dirs-update --set VIDEOS "$HOME/desktop"  # only temporary
mv "$HOME/Desktop" "$HOME/desktop"
rm -r "$HOME/Documents"
rm -r "$HOME/Music"
rm -r "$HOME/Pictures"
rm -r "$HOME/Public"
rm -r "$HOME/Templates"
rm -r "$HOME/Videos"
xdg-user-dirs-update --set DOWNLOAD "$HOME/downloads"
mv "$HOME/Downloads" "$HOME/downloads"

echo -e '\n\033[36m\033[2m\033[1m\033[7mDownloading the setup scripts\033[0m\n'
sudo apt install -y git
git clone https://github.com/webartifex/dot-files.git
export DOT_FILES="$HOME/dot-files"
export SH_SCRIPTS="$DOT_FILES/shell"

echo -e '\n\033[36m\033[2m\033[1m\033[7mDelaying update reminders\033[0m\n'
sudo cp "$DOT_FILES/static/apt-daily.timer" /lib/systemd/system/apt-daily.timer
sudo cp "$DOT_FILES/static/apt-daily-upgrade.timer" /lib/systemd/system/apt-daily-upgrade.timer

echo "
|------------------------------------|
| Is this install on an SSD/NVME ??? |
|------------------------------------|
"
read -p "Respond to proceed ? [y/N] " -n1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    sudo systemctl enable fstrim.timer
fi

echo -e '\n\033[36m\033[2m\033[1m\033[7mConfiguring network settings\033[0m\n'
sudo hostnamectl set-hostname "$HOSTNAME"
sudo apt install -y macchanger
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
source "$SH_SCRIPTS/setup.d/xcape.sh"
source "$SH_SCRIPTS/setup.d/gnome.sh"
source "$SH_SCRIPTS/setup.d/gpg.sh"
source "$SH_SCRIPTS/setup.d/vault_folders.sh"
source "$SH_SCRIPTS/setup.d/python.sh"
source "$SH_SCRIPTS/setup.d/nextcloud.sh"
source "$SH_SCRIPTS/setup.d/vpn.sh"
source "$SH_SCRIPTS/setup.d/chrome.sh"
source "$SH_SCRIPTS/setup.d/exa.sh"
source "$SH_SCRIPTS/setup.d/flameshot.sh"
# Currently, spotify-desktop has a dependency issue
# source "$SH_SCRIPTS/setup.d/spotify.sh"
source "$SH_SCRIPTS/setup.d/teamviewer.sh"
source "$SH_SCRIPTS/setup.d/thunderbird.sh"
source "$SH_SCRIPTS/setup.d/zoom.sh"
source "$SH_SCRIPTS/setup.d/printer.sh"

echo "
|------------------------------|
| Remove the setup scripts ??? |
|------------------------------|
"
read -p "Respond to proceed ? [y/N] " -n1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf "$HOME/dot-files"
    rm -rf "$HOME/setup.sh"
fi

echo -e "\nInstallation completed. Please restart the machine!"
