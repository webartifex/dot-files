# Update system-wide packages.

alias agac='sudo apt autoclean'
alias agar='sudo apt autoremove'
alias agi='sudo apt install'
alias agp='sudo apt purge'
alias agr='sudo apt remove'
alias agu='sudo apt update && sudo apt upgrade'

# Run entire aptitude upgrade cycle (incl. removal of old packages).
update-apt() {
    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating apt packages\033[0m\n'

    sudo apt update
    echo
    sudo apt upgrade
    echo
    sudo apt autoremove
    echo
    sudo apt autoclean
}

# Pull down latest version of dot files.
update-dot-files() {
    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating dot files\033[0m\n'

    local cwd
    cwd=$(pwd)
    cd "$DOT_FILES"
    git stash
    git pull
    git stash pop
    cd $cwd
}

update-repositories() {
    local cwd
    cwd=$(pwd)
    cd "$REPOS"
    for dir in */; do
        [ "$dir" = "zsh/" ] && continue
        echo "$REPOS/$dir"
        cd "$REPOS/$dir"
        git fetch --all --prune
        echo
    done
    cd $cwd
}

remove-old-snaps() {
    sudo snap list --all | awk "/disabled/{print $1, $3}" |
        while read snapname revision; do
            sudo snap remove "$snapname" --revision="$revision"
        done
}

update-python() {
    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating the Python tool chain\033[0m\n'

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
    echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating zsh\033[0m\n'

    if in-zsh; then
        zplug update
    else
        local cwd
        cwd=$(pwd)
        # Pull down latest versions manually.
        for dir in $REPOS/zsh/*/*/; do
            echo "$dir"
            cd $dir
            git pull
        done
        cd $cwd
    fi
}

# Wrapper to run all update functions.
update-machine() {
    sudo --validate || return

    update-apt
    update-dot-files

    if command-exists flatpak; then
        echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating flatpaks\033[0m\n'
        sudo flatpak update -y
    fi

    if command-exists snap; then
        echo -e '\n\033[36m\033[2m\033[1m\033[7mUpdating snaps\033[0m\n'
        sudo snap refresh
        remove-old-snaps
    fi

    update-python
    update-zsh

    echo -e '\n\033[36m\033[2m\033[1m\033[7mOther\033[0m\n'

    pass git pull
    echo

    sudo updatedb -U /
    echo

    sudo --reset-timestamp
}

# Copy dot files from repo to the $HOME directory.
sync-dot-files() {
    update-dot-files

    dot_files=('.bashrc' '.gitconfig' '.mackup.cfg' '.p10k.zsh' '.zshrc')
    for file in ${dot_files[@]}; do
        cp "$DOT_FILES/$file" "$HOME/$file"
    done

    mackup backup
}

# Sync machine to the state kept in the dot-files repo.
# This basically ensures that a machine has all the packages/stuff
# specified in the dot-files repo installed loacally.
# Old packages/stuff is NOT removed.
sync-machine() {
    sudo --validate || return

    sync-dot-files

    source "$SH_SCRIPTS/setup.d/vault_folders.sh"
    source "$SH_SCRIPTS/setup.d/apt.sh"
    source "$SH_SCRIPTS/setup.d/firefox.sh"
    source "$SH_SCRIPTS/setup.d/git.sh"
    source "$SH_SCRIPTS/setup.d/zsh.sh"
    source "$SH_SCRIPTS/setup.d/gnome.sh"

    sudo --reset-timestamp
}
