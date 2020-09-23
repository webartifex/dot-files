echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling gnupg/pass\033[0m\n'
sudo apt-get install -y\
    pass\
    gnupg\
    gpg-agent\
    gpgsm\
    parcimonie\
    pinentry-gtk2 pinentry-doc\
    scdaemon


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|---------------------|
| Configure GPG (1/2) |
|---------------------|
 - make the public/private GPG key-pair available as
   ~/gpg/public.gpg and ~/gpg/private.gpg
 - make the ownertrust database available as
   ~/gpg/trustdb.txt
 - make the gpg.conf file available as
   ~/gpg/gpg.conf
"
read -p "Proceed to import key pair ..." -n1 -r

rm -rf "$HOME/.gnupg"
gpg --import "$HOME/gpg/public.gpg"
gpg --allow-secret-key-import --import "$HOME/gpg/private.gpg"
gpg --import-ownertrust "$HOME/gpg/trustdb.txt"

echo "\nImported public key:"
gpg --list-keys

echo "\nImported private key:"
gpg --list-secret-keys

cp "$HOME/gpg/gpg.conf" "$HOME/.gnupg/gpg.conf"

echo "
|---------------------|
| Configure GPG (2/2) |
|---------------------|
 - remove all files in the ~/gpg folder!
 - check if pass works on the CLI
"
read -p "Press a key to continue ..." -n1 -r
