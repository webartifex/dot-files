# Aliases to make working with files easier.

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Avoid bad mistakes and show what happens.
alias cp="cp --interactive --verbose"
alias ln='ln --interactive --verbose'
alias mv='mv --interactive --verbose'
alias rm='rm -I --preserve-root --verbose'

alias mkdir='mkdir -p'
alias md='mkdir'
alias rmdir='rmdir --parents --verbose'
alias rd='rmdir'

alias grep='grep --color=auto --exclude-dir={.cache,\*.egg-info,.git,.nox,.tox,.venv}'
alias egrep='egrep --color=auto --exclude-dir={.cache,\*.egg-info,.git,.nox,.tox,.venv}'
alias fgrep='fgrep --color=auto --exclude-dir={.cache,*.egg-info,.git,.nox,.tox,.venv}'

alias fdir='find . -type d -name'
alias ffile='find . -type f -name'

alias ls='ls --classify --color=auto --group-directories-first --human-readable --no-group --time-style=long-iso'
alias la='ls --almost-all'
alias lal='la -l'
alias ll='ls -l'
alias l.='ls --directory .*'
alias ll.='l. -l'

alias df='df --human-readable'
alias du='du --human-readable'
alias diff='diff --color=auto --unified'
command-exists colordiff && alias diff='colordiff --unified'
alias free='free --human --total'
alias less='less --chop-long-lines --ignore-case --LONG-PROMPT --no-init --status-column --quit-if-one-screen'
alias more='less'
alias tree='tree -C --dirsfirst'

# Global aliases.
if in-zsh; then
    alias -g G='| grep'
    alias -g H='| head'
    alias -g L='| less'
    alias -g T='| tail'
    alias -g NE='2 > /dev/null'
    alias -g NUL='> /dev/null 2>&1'
fi
