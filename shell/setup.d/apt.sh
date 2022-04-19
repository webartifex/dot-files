if [ -n "$SETUP_SYSTEM" ]; then
    echo -e '\n\033[36m\033[2m\033[1m\033[7mRemoving unneeded apt packages\033[0m\n'
    sudo apt purge -y\
        apport
    sudo apt-get autoremove -y
fi

echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling apt packages\033[0m\n'
sudo apt-get install -y\
    bat\
    bleachbit\
    cloc\
    cmake\
    colordiff\
    curl\
    exuberant-ctags\
    fd-find\
    fzf\
    gimp\
    gnome-tweaks\
    gocryptfs\
    gpw\
    httpie\
    imagemagick\
    jq\
    libreoffice-base\
        libreoffice-calc\
        libreoffice-impress\
        libreoffice-math\
        libreoffice-writer\
    make\
    mdp\
    mlocate\
    netcat\
    net-tools\
    gparted\
    libgstreamer1.0-0\
        gstreamer1.0-tools\
        gstreamer1.0-plugins-bad\
        gstreamer1.0-plugins-good\
        gstreamer1.0-plugins-ugly\
        libavcodec-extra\
    htop\
    libpam-tmpdir\
    locales\
    nautilus-admin\
    nfs-common\
    nmap\
    pandoc\
    pavucontrol\
    postgresql\
        postgresql-contrib\
        libjson-perl\
        isag\
        libgmp3-dev\
        libpq-dev\
    pwgen\
    ranger\
    rsync\
    smbclient\
        cifs-utils\
    screenfetch\
    screenkey\
    shellcheck\
    sqlite3\
        sqlitebrowser\
    system76-keyboard-configurator\
    texlive\
        texlive-xetex\
        texmaker\
        fonts-lyx\
    timeshift\
    tmux\
    tor\
        torbrowser-launcher\
    traceroute\
    tree\
    ttf-mscorefonts-installer\
        ttf-anonymous-pro\
        ttf-ubuntu-font-family\
        ttf-unifont\
    uuid\
    xclip\
    ufw\
    v4l-utils\
    vim\
        vim-addon-manager\
        vim-python-jedi\
        vim-scripts\
    vlc\
    wget\
    whois


# The apps and utilities listed here can either not be removed due
# to a dependency issue with pop-shell or are used via the CLI only.
echo -e '\n\033[36m\033[2m\033[1m\033[7mRemoving unneeded application launchers\033[0m\n'
sudo rm /usr/share/applications/com.github.donadigo.eddy.desktop 2>/dev/null
sudo rm /usr/share/applications/display-im6.q16.desktop 2>/dev/null
sudo rm /usr/share/applications/htop.desktop 2>/dev/null
sudo rm /usr/share/applications/im-config.desktop 2>/dev/null
sudo rm /usr/share/applications/info.desktop 2>/dev/null
sudo rm /usr/share/applications/isag.desktop 2>/dev/null
sudo rm /usr/share/applications/libreoffice-xsltfilter.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Calendar.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Contacts.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Geary.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Screenshot.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Totem.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Weather.desktop 2>/dev/null
sudo rm /usr/share/applications/ranger.desktop 2>/dev/null
sudo rm /usr/share/applications/texdoctk.desktop 2>/dev/null
sudo rm /usr/share/applications/vim.desktop 2>/dev/null
sudo rm /usr/share/applications/yelp.desktop 2>/dev/null

echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling flatpaks\033[0m\n'
sudo apt-get install -y flatpak
if [ -n "$SETUP_SYSTEM" ]; then
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

echo -e '\n\033[36m\033[2m\033[1m\033[7mCreating VIM tmp folders\033[0m\n'
if [ -n "$SETUP_SYSTEM" ]; then
    mkdir -p "$HOME/.vim/tmp/backup"
    mkdir -p "$HOME/.vim/tmp/swap"
    mkdir -p "$HOME/.vim/tmp/undo"
fi

# Update the font cache.
sudo fc-cache -f -v
