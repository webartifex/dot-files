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
    calibre\
    cloc\
    cmake\
        cmake-doc\
    cmatrix\
    colordiff\
    curl\
    discord\
    exuberant-ctags\
    fd-find\
    feh\
    fzf\
    gimp\
        gimp-help-en\
    gnome-tweaks\
    gnutls-bin\
    gocryptfs\
    gpw\
    httpie\
    hunspell\
        hunspell-de-de\
    imagemagick\
        imagemagick-doc\
    jq\
    julia\
        julia-doc\
    libnotify-bin\
    libreoffice-calc\
        libreoffice-impress\
        libreoffice-writer\
    make\
        make-doc\
    mdp\
    mlocate\
    net-tools\
    nodejs\
        npm\
    gparted\
    gstreamer1.0-libav\
        gstreamer1.0-plugins-bad\
        gstreamer1.0-plugins-good\
        gstreamer1.0-plugins-ugly\
        libavcodec-extra\
    htop\
    libpam-tmpdir\
    locales-all\
    pandoc\
    pavucontrol\
    postgresql\
        postgresql-contrib\
        postgresql-doc\
        libjson-perl\
        isag\
        libgmp3-dev\
        libpq-dev\
    pwgen\
    r-base\
        r-base-core\
        libcurl4-openssl-dev\
    ranger\
    rsync\
        grsync\
    smbclient\
        cifs-utils\
    screenfetch\
    screenkey\
    shellcheck\
    sqlite3\
        sqlite3-doc\
        sqlitebrowser\
    synaptic\
    system76-keyboard-configurator\
    texlive\
        texlive-xetex\
        texmaker\
        fonts-lyx\
    tmux\
    tor\
        torbrowser-launcher\
    tree\
    ttf-mscorefonts-installer\
        ttf-anonymous-pro\
        ttf-ubuntu-font-family\
        ttf-unifont\
    usb-creator-gtk\
    uuid\
    xclip\
    ufw\
        gufw\
    usbguard\
    v4l-utils\
    vim\
        vim-doc\
        vim-julia\
        vim-python-jedi\
        vim-scripts\
    virtualbox\
    vlc\
    wget

# Make Julia available in Jupyter notebooks.
echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling/updating iJulia\033[0m\n'
julia --eval 'using Pkg; Pkg.add("IJulia")'

# Install the tldr utility for nice and concise man pages.
sudo npm install -g tldr

# The apps and utilities listed here can either not be removed due
# to a dependency issue with pop-shell or are used via the CLI only.
echo -e '\n\033[36m\033[2m\033[1m\033[7mRemoving unneeded application launchers\033[0m\n'
sudo rm /usr/share/applications/calibre-ebook-edit.desktop 2>/dev/null
sudo rm /usr/share/applications/calibre-ebook-viewer.desktop 2>/dev/null
sudo rm /usr/share/applications/calibre-lrfviewer.desktop 2>/dev/null
sudo rm /usr/share/applications/cmatrix.desktop 2>/dev/null
sudo rm /usr/share/applications/com.github.donadigo.eddy.desktop 2>/dev/null
sudo rm /usr/share/applications/com.system76.Popsicle.desktop 2>/dev/null
sudo rm /usr/share/applications/display-im6.q16.desktop 2>/dev/null
sudo rm /usr/share/applications/htop.desktop 2>/dev/null
sudo rm /usr/share/applications/im-config.desktop 2>/dev/null
sudo rm /usr/share/applications/info.desktop 2>/dev/null
sudo rm /usr/share/applications/isag.desktop 2>/dev/null
sudo rm /usr/share/applications/julia.desktop 2>/dev/null
sudo rm /usr/share/applications/libreoffice-draw.desktop 2>/dev/null
sudo rm /usr/share/applications/libreoffice-math.desktop 2>/dev/null
sudo rm /usr/share/applications/libreoffice-startcenter.desktop 2>/dev/null
sudo rm /usr/share/applications/libreoffice-xsltfilter.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Calendar.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Contacts.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Extensions.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Geary.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Screenshot.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Totem.desktop 2>/dev/null
sudo rm /usr/share/applications/org.gnome.Weather.desktop 2>/dev/null
sudo rm /usr/share/applications/R.desktop 2>/dev/null
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
