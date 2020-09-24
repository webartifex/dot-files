echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Chromium\033[0m\n'

sudo apt-get install -y\
    chromium\
    chromium-browser\
    chromium-codecs-ffmpeg-extra


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo "
|---------------------|
| Sign in to Chromium |
|---------------------|
 - use credentials below
 - the webdata-password is needed further below
"
pass show misc/google.com
echo
read -p "Press a key to continue ..." -n1 -r

echo "
|--------------------|
| Configure Chromium |
|--------------------|
 - sync
   + apps
   + bookmarks
   + extensions
   + settings
   + themes
   + open tabs
 - no other google services
 - autofill: no passwords, no payments, no addresses
 - appearance: only show bookmarks bar
 - search engine: only DuckDuckGo + https://docs.python.org/3/search.html?q=%s
 - restore DuckDuckGo settings (phrase: FRoUDTZcOcFnOTrZ5fQYtnx3u)
"
read -p "Press a key to continue ..." -n1 -r
