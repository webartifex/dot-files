# Re-run last command with sudo priviledges.
if in-zsh; then
    alias ,,='sudo $(fc -ln -1)'
else
    alias ,,='sudo $(history -p !!)'
fi

alias cls='clear'

source "$SH_SCRIPTS/aliases.d/files.sh"
source "$SH_SCRIPTS/aliases.d/python.sh"
source "$SH_SCRIPTS/aliases.d/utils.sh"
source "$SH_SCRIPTS/aliases.d/vaults.sh"
