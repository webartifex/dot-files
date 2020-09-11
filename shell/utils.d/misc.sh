# Send notification to Gnome.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Delete privacy relevant data stored by Chromium.
clear-chromium() {
    shopt -u failglob
    rm -rf "$HOME"/.cache/chromium/*
    rm -rf "$HOME"/.config/chromium/Default/Local\ Storage/leveldb/*
    rm -rf "$HOME"/.config/chromium/Default/Application\ Cache/*
    rm -rf "$HOME"/.config/chromium/Default/databases/*
    rm -rf "$HOME"/.config/chromium/Default/File\ System/*
    rm -rf "$HOME"/.config/chromium/Default/IndexedDB/*
    rm -rf "$HOME"/.config/chromium/Default/Service\ Worker/*
    shopt -s failglob
    echo 'Cleared all privacy relevant Chromium files'
}

# Run a DANE check against mailbox.org's IMAP/SMTP servers.
dane-check() {
    danetool --check imap.mailbox.org --port 993
    if [ $? -ne 0 ]; then
        zenity --error --text='DANE/TLSA error with imap.mailbox.org' --no-wrap
        exit 0
    fi
    danetool --check smtp.mailbox.org --port 465
    if [ $? -ne 0 ]; then
        zenity --error --text='DANE/TLSA error with smtp.mailbox.org' --no-wrap
        exit 0
    fi
 }

external-ip() {
    curl 'icanhazip.com'
}

# List all internal IPs.
internal-ips() {
    if command-exists ifconfig; then
        ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
    else
        echo 'ifconfig not installed'
    fi
}

speedtest() {
    curl --silent 'https://raw.githubusercontent.com/sivel/speedtest-cli/c58ad3367bf27f4b4a4d5b1bca29ebd574731c5d/speedtest.py' | python -
}

weather() {
    if [ -n "$1" ]; then
        curl "v1.wttr.in/$1"
    else
        curl 'v1.wttr.in'
    fi
}
