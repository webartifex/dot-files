# Machine-specific directories.
export REPOS="$HOME/repos"
export DOT_FILES="$REPOS/dot-files"
export SH_SCRIPTS="$DOT_FILES/shell"

# Generic environment variables.
export EDITOR=vim
export PAGER='less --chop-long-lines --ignore-case --LONG-PROMPT --no-init --status-column --quit-if-one-screen'
export TERM=xterm-256color
export TZ='Europe/Berlin'
export VISUAL=$EDITOR

# Environment varibales configuring various utilities.
export BAT_CONFIG_PATH="$DOT_FILES/.batrc"
export LESSHISTFILE="$HOME/.cache/.lesshst"
export PSQLRC="$DOT_FILES/.psqlrc"
# No need for *.pyc files on a dev machine.
export PYTHONDONTWRITEBYTECODE=1

# $PATH related stuff.
source "$SH_SCRIPTS/path.sh"
put-on-path "$HOME/.local/bin"
put-on-path "$HOME/.poetry/bin"
put-on-path "$HOME/.pyenv/bin"
export PATH
