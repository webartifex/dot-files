# Re-run last command with sudo priviledges.
if in-zsh; then
    alias ,,='sudo $(fc -ln -1)'
else
    alias ,,='sudo $(history -p !!)'
fi

alias cls='clear'

source "$DOT_FILES/shell/aliases.d/files.sh"
source "$DOT_FILES/shell/aliases.d/python.sh"
source "$DOT_FILES/shell/aliases.d/utils.sh"
source "$DOT_FILES/shell/aliases.d/vaults.sh"
