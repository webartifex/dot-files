echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling flameshot\033[0m\n'

sudo apt-get install --no-install-recommends --yes\
    flameshot\
    appmenu-gtk2-module\
    appmenu-gtk3-module


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


flameshot config &
echo "
|---------------------|
| Configure Flameshot |
|---------------------|
 - import flameshot.conf from repo
"
read -p "Press a key to continue ..." -n1 -r
