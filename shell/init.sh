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

# Map second keyboard for wa-WildDog.
if [[ "$(hostname)" == "wa-WildDog" ]]; then
    setxkbmap -device 10 -layout us
    setxkbmap -device 11 -layout us
    setxkbmap -device 12 -layout us
    setxkbmap -device 13 -layout de
    setxkbmap -device 14 -layout de
    setxkbmap -device 15 -layout de
fi