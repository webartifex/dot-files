# Update system-wide packages.

alias agac='sudo apt autoclean'
alias agar='sudo apt autoremove'
alias agi='sudo apt install'
alias agp='sudo apt purge'
alias agr='sudo apt remove'
alias agu='sudo apt update && sudo apt upgrade'

# Run entire aptitude upgrade cycle (incl. removal of old packages).
update-apt() {
    sudo apt update
    echo
    sudo apt upgrade
    echo
    sudo apt autoremove
    echo
    sudo apt autoclean
}

remove-old-snaps() {
    sudo snap list --all | awk "/disabled/{print $1, $3}" |
        while read snapname revision; do
            sudo snap remove "$snapname" --revision="$revision"
        done
}

update-python() {
    /usr/bin/python -m pip install --user --upgrade pip pipx setuptools virtualenv
    echo

    pipx upgrade-all
    echo

    if command-exists pyenv; then
        pyenv update
        echo
    fi

    if command-exists poetry; then
        poetry self update
    fi
}

# Update everything related to zsh.
update-zsh() {
    # Pull down latest versions of manually installed zsh plugins.
    for dir in $HOME/repos/ohmyzsh/custom/{plugins,themes}/*/; do
        echo "$dir"
        cd $dir
        git pull
    done
    cd

    # omz only works from within a zsh instance.
    if in-zsh; then
        omz update
    fi
}

# Copy dot files from git repo to $HOME.
update-dot-files() {
    # Pull down latest version of dot files.
    cd "$DOT_FILES"
    git pull
    cd

    # Copy all dot files to the home directory.
    for file in '.bashrc .gitconfig .p10k.zsh .zshrc'; do
        cp "$DOT_FILES/$file" "$HOME/$file"
    done
}

# Wrapper to run all update functions.
update-system() {
    # Enforce sudo rights from the getgo.
    sudo --validate || return

    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating apt packages\033[0m\n'
    update-apt

    if command-exists snap; then
        echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating snaps\033[0m\n'
        sudo snap refresh
        remove-old-snaps
    fi

    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating the Python tool chain\033[0m\n'
    update-python

    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating zsh\033[0m\n'
    update-zsh

    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating dot files\033[0m\n'
    update-dot-files()

    sudo updatedb -U /
    echo

    sudo --reset-timestamp
}
