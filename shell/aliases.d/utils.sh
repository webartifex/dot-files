# Aliases for various utilities.

alias datetime='date +"%Y-%m-%d %H:%M:%S %z (%Z)"'
alias datetime-iso='date --iso-8601=seconds'

# Fix common typos.
command-exists ifconfig && alias ipconfig='ifconfig'
command-exists R && alias r='R'

# Use sane defaults.
command-exists netstat && alias ports='netstat -tulanp'
command-exists octave && alias octave='octave --no-gui'
command-exists screenfetch && alias screenfetch='screenfetch -n'
alias uptime='uptime --pretty'
alias wget='wget --continue'

# Create short aliases.
command-exists batcat && alias bat='batcat'
command-exists fdfind && alias fd='fdfind'
command-exists ranger && alias rn='ranger'
command-exists screenfetch && alias sf='screenfetch'

# Integrate git.
if command-exists git; then
    alias g='git'

    # All git aliases are shell aliases with a 'g' prefix.
    for al in $(git internal-aliases); do
        # Only "real" (i.e., short) aliases are created.
        [ ${#al} -lt 7 ] && eval "alias g$al='git $al'"
    done

    # Check if a 'main' branch exists in place of a 'master' branch.
    git_main_branch() {
        if [[ -n "$(git branch --list main)" ]]; then
           echo 'main'
        else
           echo 'master'
        fi
    }
fi

# Aliases for flags.

if command-exists exa; then
    alias exa='exa --group-directories-first --git --time-style=long-iso'
    alias exal='exa --long'
    alias exat='exal --tree'
fi

command-exists tig && alias tiga='tig -a'
