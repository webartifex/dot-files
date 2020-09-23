if [ -n "$SETUP_SYSTEM" ]; then
    echo "Removing unneeded apt packages"
    echo
    sudo apt purge -y\
        apport\
        popularity-contest\
        whoopsie
    sudo apt-get autoremove -y
    echo
fi

echo "Installing apt packages"
echo
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
    flatpak\
    gimp\
        gimp-help-en\
    gnome-tweaks\
    gnupg\
        gpg-agent\
        gpgsm\
        parcimonie\
        pinentry-gtk2 pinentry-doc\
        scdaemon\
    gnutls-bin\
    gocryptfs\
    gpw\
    httpie\
    hunspell\
        hunspell-de-de\
    imagemagick\
        imagemagick-doc\
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
    pass\
    pavucontrol\
    pwgen\
    r-base\
        r-base-core\
        libcurl4-openssl-dev\
    ranger\
    rsync\
        grsync\
    screenfetch\
    spotify-client\
    sqlite3\
        sqlite3-doc\
        sqlitebrowser\
    synaptic\
    telegram-desktop\
    texlive\
        texlive-xetex\
        texmaker\
        fonts-lyx\
    thunderbird\
        enigmail\
    tree\
    usb-creator-gtk\
    uuid\
    xclip\
    ufw\
        gufw\
    usbguard\
    vim\
        vim-doc\
        vim-julia\
        vim-python-jedi\
        vim-scripts\
    vlc\
    wget
echo

# Make Julia available in Jupyter notebooks.
echo "Installing/updating iJulia"
echo
julia --eval 'using Pkg; Pkg.add("IJulia")'
echo

# The apps and utilities listed here can either not be removed due
# to a dependency issue with pop-shell or are used via the CLI only.
echo "Removing unneeded launchers from Gnome's applications list"
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
sudo rm /usr/share/applications/simple-scan.desktop 2>/dev/null
sudo rm /usr/share/applications/texdoctk.desktop 2>/dev/null
sudo rm /usr/share/applications/vim.desktop 2>/dev/null
sudo rm /usr/share/applications/yelp.desktop 2>/dev/null
echo
