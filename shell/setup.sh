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
sudo --validate || exit
cd $HOME
echo

echo "Updating the system"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get autoremove -y
echo

echo "Changing default folders to lower case names"
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
echo

# A lower swappiness results in less hard disk usage by temporary data.
echo "Lowering the swappiness"
echo "vm.swappiness = 5" | sudo tee -a /etc/sysctl.conf > /dev/null
echo

echo "Downloading the setup scripts"
sudo apt-get install -y git
git clone https://github.com/webartifex/dot-files.git
export DOT_FILES="$HOME/dot-files"
export SH_SCRIPTS="$DOT_FILES/shell"
echo

echo "Use main mirrors and disable annoying reminder"
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily-upgrade.timer
sudo cp "$DOT_FILES/static/sources.list" /etc/apt/sources.list
sudo apt-get update
sudo apt-get autoclean -y
echo

echo "Running the setup scripts"
source "$SH_SCRIPTS/utils.sh"
source "$SH_SCRIPTS/setup.d/apt.sh"
source "$SH_SCRIPTS/setup.d/firefox.sh"
source "$SH_SCRIPTS/setup.d/git.sh"
echo

echo "Removing the setup scripts"
rm -rf "$HOME/dot-files"
echo

echo "Installation completed. Please restart the machine!"
