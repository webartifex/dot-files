# Enable Powerlevel10k instant prompt.
if [ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ====================
# bash/zsh environment
# ====================

source "$HOME/repos/dot-files/shell/env.sh" || return


# ========================
# zsh specific environment
# ========================

plugins=(
    command-not-found
    dotenv
    git-auto-fetch
    git-escape-magic
    history-substring-search
    pyenv
    z
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

# Update together with system update.
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

ZSH_COMPDUMP="$HOME/.cache/.zcompdump-$HOST-$ZSH_VERSION"

# Make dotenv source .env files silently.
ZSH_DOTENV_PROMPT=false

ZSH_THEME="powerlevel10k/powerlevel10k"


# ==================
# base configuration
# ==================

# Enable VI mode.
bindkey -v

setopt AUTO_CD

# Try to correct the spelling of commands.
setopt CORRECT

setopt EXTENDEDGLOB
# Warn if there are no matches.
setopt NOMATCH

setopt NO_BEEP

# Report status of background jobs immediately.
setopt NOTIFY

# Initialize oh-my-zhs.
export ZSH="$HOME/repos/ohmyzsh"
source "$ZSH/oh-my-zsh.sh"

# Remove all "built-in" aliases.
unalias -a


# =======
# history
# =======

HISTFILE="$HOME/.cache/.zsh_history"
HISTSIZE=99999
SAVEHIST=99999

# Keep common built-in commands out of the history.
HISTORY_IGNORE="([bf]g|cd|cd ..|clear|date|datetime|exit|history|jobs|jobs -l|ls|ls *|pwd)"

# Show date and time when using history command.
alias history="history -i"

# Append the history after each command to avoid accidental loss.
setopt INC_APPEND_HISTORY

# Enable Ctrl-R.
bindkey "^R" history-incremental-search-backward


# ==================
# bash/zsh utilities
# ==================

source "$DOT_FILES/shell/utils.sh" || return


# ===============
# initializations
# ===============

source "$DOT_FILES/shell/init.sh" || return


# ===========
# completions
# ===========

autoload -Uz compinit
compinit

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
command-exists nox && eval "$(register-python-argcomplete nox)"

if command-exists poetry; then
    # Causes output during zsh initialization.
    eval "$(poetry completions zsh)" 1>/dev/null 2>&1
fi


# ============
# key bindings
# ============

# zsh-autosuggestions plugin.
bindkey "^ " autosuggest-accept

# history-substring-search plugin.
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down


# =======
# aliases
# =======

source "$DOT_FILES/shell/aliases.sh" || return

# =====
# other
# =====

# Enable Powerlevel10k "full" prompt.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
