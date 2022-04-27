echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Zoom\033[0m\n'

cd "$HOME"
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install -y ./zoom_amd64.deb
rm zoom_amd64.deb


if [ -n "$SETUP_SYSTEM" ]; then

    zoom >/dev/null 2>/dev/null &
    echo "
|----------------|
| Configure Zoom |
|----------------|
 - sign in with SSO (whuedu.zoom.us)
"
    read -p "Press a key to continue ..." -n1 -r


fi
