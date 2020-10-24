# Make less understand some binary types (e.g., PDFs).
# Source: https://github.com/wofr06/lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load custom $LS_COLORS if available.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Initialize pyenv if it is installed.
if command-exists pyenv; then
    if [ -z "$PYENV_SHELL" ]; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    else
        eval "$(pyenv init - | grep --invert-match 'export PATH')"
        eval "$(pyenv virtualenv-init - | grep --invert-match 'export PATH')"
    fi
fi

# Configure the keyboard:
#  - make (right) menu key the compose key, e.g., for umlauts
#  - make caps lock a ctrl modifier and Esc key
setxkbmap us -option 'compose:menu,caps:ctrl_modifier'
if command-exists xcape; then
    xcape -e "Caps_Lock=Escape"
fi
