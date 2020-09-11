# Show folders by size.
disk-usage() {
    local dest
    if [ -n "$1" ]; then
        dest="$1"
    else
        dest=.
    fi
    \du --human-readable --max-depth=1 $dest 2>/dev/null | sort --human-numeric-sort --reverse
}

# Extract a compressed archive or file.
extract() {
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2) tar xjvf "$1" ;;
            *.tar.gz)  tar xzvf "$1" ;;
            *.tar.xz)  tar xvf "$1" ;;
            *.bz2)     bzip2 -d "$1" ;;
            *.rar)     unrar2dir "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip2dir "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *.ace)     unace x "$1" ;;
            *)         echo "'$1' cannot be extracted automatically" ;;
        esac
    else
        echo "'$1' is not a file"
    fi
}

# Search all files in a directory and its children.
lsgrep() {
    ls --almost-all --directory . ./**/* | uniq | grep --color=auto -i "$*"
}

# Make a directory and cd there.
mcd() {
    test -n "$1" || return
    mkdir -p "$1" && cd "$1" || return
}

# Create a tar.gz archive from a given directory.
mktar() {
    tar cvzf "${1%%/}.tar.gz" "${1%%/}/"
}

# Create a zip archive from a given file or directory.
mkzip() {
    zip -r "${1%%/}.zip" "$1"
}
