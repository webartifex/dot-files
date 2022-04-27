echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Thunderbird\033[0m\n'
sudo apt install -y\
    thunderbird\
    enigmail


if [ -n "$SETUP_SYSTEM" ]; then

    sudo cp "$DOT_FILES/static/mailbox.org.xml" /usr/lib/thunderbird/isp/mailbox.org.xml

    echo "
|-----------------------|
| Configure Thunderbird |
|-----------------------|
 - unpack thunderbird-profile.zip (from another source) into ~/.thunderbird
"
    read -p "Press a key to continue ..." -n1 -r
    echo

fi
