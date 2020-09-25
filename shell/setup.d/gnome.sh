echo -e '\n\033[36m\033[2m\033[1m\033[7mRestoring Gnome settings\033[0m\n'
sudo apt-get install -y dconf-cli

# The wallpaper is referenced (twice) in gnome-settings.ini
sudo cp "$DOT_FILES/static/wallpapers/beach_tropics_sea_sand_palm_trees.jpg" /usr/share/backgrounds/beach_tropics_sea_sand_palm_trees.jpg
dconf load / < "$DOT_FILES/static/gnome-settings.ini"
# Remove Pop! OS's default application folders
dconf reset -f /org/gnome/desktop/app-folders/folders/Pop-Office/
dconf reset -f /org/gnome/desktop/app-folders/folders/Pop-System/
dconf reset -f /org/gnome/desktop/app-folders/folders/Pop-Utility/


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|--------------------|
| Configure language |
|--------------------|
 - open 'Language Support' app
 - remove all languages except English and German
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
 - remove Pop! OS and firmware upgrade checker from startup applications
"
read -p "Press a key to continue ..." -n1 -r


echo "
|-------------------------------|
| Configure second keyboard ??? |
|-------------------------------|
"
read -p "Respond to proceed ? [y/N] " -n1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo
    echo "
|---------------------------|
| Configure second keyboard |
|---------------------------|
 - grep for wa-WildDog in ~/repos/dot-files/shell/init.sh and
   adjust the keyboards according to the output below
"
    xinput -list | grep -i key
    echo
    read -p "Press a key to continue ..." -n1 -r
fi
