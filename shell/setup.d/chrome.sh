echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Google Chrome\033[0m\n'

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|--------------------------|
| Sign in to Google Chrome |
|--------------------------|
 - use credentials below
 - the webdata-password is needed further below
"
pass show tools/google.com
echo
read -p "Press a key to continue ..." -n1 -r

echo "
|-------------------------|
| Configure Google Chrome |
|-------------------------|
 - sync
   + apps
   + bookmarks
   + extensions
   + settings
   + themes
   + open tabs
 - no google services except 'Allow Chrome sign-in'
 - autofill: no passwords, no payments, no addresses
 - appearance: only show bookmarks bar
 - search engine: only DuckDuckGo + https://docs.python.org/3/search.html?q=%s
 - restore DuckDuckGo settings (phrase: FRoUDTZcOcFnOTrZ5fQYtnx3u)
"
read -p "Press a key to continue ..." -n1 -r
