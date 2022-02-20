echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling gnupg/pass\033[0m\n'
sudo apt-get install -y\
    pass\
    gnupg\
    gpg-agent\
    gpgsm\
    parcimonie\
    pinentry-gtk2\
    scdaemon


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|---------------|
| Configure GPG |
|---------------|
 - make the public/private GPG key-pair available as
   ~/gpg/public.gpg and ~/gpg/private.gpg
 - make the ownertrust database available as
   ~/gpg/trustdb.txt
"
read -p "Proceed to import key pair ..." -n1 -r

rm -rf $HOME/.gnupg
gpg --import "$HOME/gpg/public.gpg"
gpg --allow-secret-key-import --import "$HOME/gpg/private.gpg"
gpg --import-ownertrust "$HOME/gpg/trustdb.txt"

echo -e "\nImported public key:"
gpg --list-keys
echo -e "\nImported private key:"
gpg --list-secret-keys

rm -rf $HOME/gpg

find "$HOME/.gnupg" -type f -exec chmod 600 {} \;
find "$HOME/.gnupg" -type d -exec chmod 700 {} \;
