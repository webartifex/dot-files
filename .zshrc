# Ensure zsh is running interactively.
[[ $- != *i* ]] && return

# Enable Powerlevel10k instant prompt.
if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable colors and change prompt.
autoload -Uz colors
colors


# ====================
# bash/zsh environment
# ====================

source "$HOME/repos/dot-files/shell/env.sh" || return


# ==================
# base configuration
# ==================

# Enable VI mode.
bindkey -v

setopt AUTO_CD

# Try to correct the spelling of commands.
setopt CORRECTALL

setopt EXTENDEDGLOB
# Warn if there are no matches.
setopt NOMATCH

setopt NO_BEEP

# Report status of background jobs immediately.
setopt NOTIFY

# Remove all "built-in" aliases.
unalias -a

export ZSH_COMPDUMP="$HOME/.cache/.zcompdump-$HOST-$ZSH_VERSION"


# =============
# zplug/plugins
# =============

source "$REPOS/zsh/zplug/zplug/init.zsh"

export ZPLUG_REPOS="$REPOS/zsh"

# Must use double quotes in this section.
# Source: https://github.com/zplug/zplug#example

zplug "zplug/zplug", hook-build:"zplug --self-manage"

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/dotenv", from:oh-my-zsh
zplug "plugins/git-auto-fetch", from:oh-my-zsh
zplug "plugins/git-escape-magic", from:oh-my-zsh
zplug "plugins/poetry", from:oh-my-zsh
zplug "plugins/pyenv", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

zplug "MichaelAquilina/zsh-you-should-use"
export YSU_MESSAGE_POSITION="after"
# Show all matching aliases.
export YSU_MODE="ALL"

zplug "romkatv/powerlevel10k", as:theme, depth:1

zplug load


# =======
# history
# =======

export HISTFILE="$HOME/.cache/.zsh_history"
export HISTSIZE=99999
export SAVEHIST=99999

# Keep common built-in commands out of the history.
export HISTORY_IGNORE="([bf]g|cd|cd ..|clear|date|datetime|exit|history|jobs|jobs -l|ls|ls *|pwd)"

# Show date and time when using history command.
alias history="history -i"

# Append the history after each command to avoid accidental loss.
setopt INC_APPEND_HISTORY

# Enable Ctrl-R.
bindkey "^R" history-incremental-search-backward


# ==================
# bash/zsh utilities
# ==================

source "$SH_SCRIPTS/utils.sh" || return
source "$SH_SCRIPTS/init.sh" || return


# ===========
# completions
# ===========

autoload -Uz compinit
compinit

zmodload zsh/complist

# Include hidden files in tab completion.
_comp_options+=(GLOB_DOTS)

# Enable arrow-key driven interface.
zstyle ':completion:*' menu select

# Use VI keys to navigate the completions in the menu.
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Make compinit find new executables right away.
zstyle ':completion:*' rehash true

# Enable grouping and group headers.
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Completions for various tools.

command-exists pip && eval "$(pip completion --zsh)"

if command-exists gh; then
    eval "$(gh completion --shell zsh)"
    # Bug: The first line in the completion script has NO effect.
    # Fix: https://github.com/cli/cli/issues/716#issuecomment-669596677
    compdef _gh gh
    compdump
fi

command-exists invoke && eval "$(invoke --print-completion-script zsh)"

if command-exists nox; then
    autoload -U bashcompinit
    bashcompinit
    eval "$(register-python-argcomplete nox)"
fi

# poetry -> $ZSH/plugins/poetry/_poetry


# ============
# key bindings
# ============

# zsh-autosuggestions plugin.
bindkey "^ " autosuggest-accept

# history-substring-search plugin.
# Source: https://github.com/zsh-users/zsh-history-substring-search#usage
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down


# =======
# aliases
# =======

source "$SH_SCRIPTS/aliases.sh" || return


# =====
# other
# =====

# Enable Powerlevel10k "full" prompt.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
