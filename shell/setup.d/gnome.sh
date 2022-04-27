echo -e '\n\033[36m\033[2m\033[1m\033[7mRestoring Gnome settings\033[0m\n'
sudo apt install -y dconf-cli

# The wallpaper is referenced (twice) in gnome-settings.ini
sudo cp "$DOT_FILES/static/wallpapers/lake_in_front_of_mountains.jpg" /usr/share/backgrounds/lake_in_front_of_mountains.jpg
dconf load / < "$DOT_FILES/static/gnome-settings.ini"


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo -e '\n\033[36m\033[2m\033[1m\033[7mConfiguring languages\033[0m\n'
# This removes, e.g., English (Australia), from the installed languages.
sudo cp "$DOT_FILES/static/supported_locales" /var/lib/locales/supported.d/en
sudo locale-gen en_IE.UTF.8
sudo locale-gen en_US.UTF.8
sudo update-locale LANG=en_US.UTF-8


echo "
|--------------------|
| Configure language |
|--------------------|
 - open 'Language Support' app
 - remove all languages except English
 - set regional format to 'English (Ireland)'
   + apply system-wide
"
read -p "Press a key to continue ..." -n1 -r


echo "
|-----------------|
| Configure Gnome |
|-----------------|
 - create bookmarks for repo folder and important repos in Nautilus
 - rename old bookmarks in Nautilus
 - remove Flatpack Transition, Pop! OS, and firmware upgrade checker from startup applications
"
read -p "Press a key to continue ..." -n1 -r
