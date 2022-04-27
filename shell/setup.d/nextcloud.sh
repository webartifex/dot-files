# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Nextcloud\033[0m\n'
sudo apt install nextcloud-desktop

echo "
|---------------------|
| Configure Nextcloud |
|---------------------|
 - proceed in the Nextcloud app
 - sign in with credentials below
 - sync everything
 - use monochrome icons
"
pass show getraenkemarkt/services/nextcloud.webartifex.biz/alexander
echo
read -p "Press a key to continue ..." -n1 -r


# Works after installing mackup with pipx.
echo -e '\n\033[36m\033[2m\033[1m\033[7mConfiguring Mackup\033[0m\n'

cp "$DOT_FILES/.mackup.cfg" "$HOME/.mackup.cfg"
mackup restore -f

find "$HOME/.gnupg" -type f -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;
