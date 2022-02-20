echo -e '\n\033[36m\033[2m\033[1m\033[7mRestoring Gnome settings\033[0m\n'
sudo apt-get install -y dconf-cli

# The wallpaper is referenced (twice) in gnome-settings.ini
sudo cp "$DOT_FILES/static/wallpapers/beach_tropics_sea_sand_palm_trees.jpg" /usr/share/backgrounds/beach_tropics_sea_sand_palm_trees.jpg
dconf load / < "$DOT_FILES/static/gnome-settings.ini"


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


sudo locale-gen en_DK.UTF.8
sudo locale-gen en_US.UTF.8
sudo update-locale LANG=en_US.UTF-8

echo "
|--------------------|
| Configure language |
|--------------------|
 - open 'Language Support' app
 - remove all languages except English
 - set regional format to 'English (Denmark)'
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
