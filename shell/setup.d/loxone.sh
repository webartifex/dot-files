echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Loxone\033[0m\n'

cd "$HOME"
wget https://updatefiles.loxone.com/linux/Release/122920220403-amd64.deb -O loxone.deb
sudo apt-get install -y ./loxone.deb
rm loxone.deb


if [ -n "$SETUP_SYSTEM" ]; then

    kerberos >/dev/null 2>/dev/null &
    echo "
|------------------|
| Configure Loxone |
|------------------|
 - sign in with account details below
"
    pass show wifis/loxone_office
    read -p "Press a key to continue ..." -n1 -r


fi
