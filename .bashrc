# Ensure bash is running interactively.
[[ $- != *i* ]] && return


# ====================
# bash/zsh environment
# ====================

source "$HOME/repos/dot-files/shell/env.sh" || return


# ==================
# base configuration
# ==================

# Disable Ctrl-S and Ctrl-Q.
stty -ixon

# Report status of background jobs immediately.
set -o notify
# Show # of running jobs when exiting a shell
shopt -s checkjobs

# Just type the directory to cd into it.
shopt -s autocd
# Correct minor spelling mistakes with cd.
shopt -s cdspell

# Include hidden files in * glob expansion.
shopt -s dotglob
shopt -s extglob
# Expand ** into (recursive) directories.
shopt -s globstar
# Ignore case when * expanding
shopt -s nocaseglob

# Update $ROWS and $COLUMNS.
shopt -s checkwinsize


# =======
# history
# =======

# Remember multi-line commands in history as one command.
shopt -s cmdhist
# Do not overwrite .bash_history file.
shopt -s histappend
# Allow re-editing a failed history substitution.
shopt -s histreedit
# Store multi-line commands in history without semicolons.
shopt -s lithist

# Ignore commands prefixed with a space,
# and ones used identically just before.
export HISTCONTROL=ignoreboth

export HISTFILE="$HOME/.cache/.bash_history"
export HISTFILESIZE=99999
export HISTSIZE=99999

# Keep common built-in commands out of the history.
export HISTIGNORE='[bf]g:cd:cd ..:clear:date:datetime:exit:history:jobs:jobs -l:ls:ls *:pwd'

# Show date and time when using history command.
export HISTTIMEFORMAT='%Y-%m-%d %H:%M  '

# Append the history after each command to avoid accidental loss.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


# ==================
# bash/zsh utilities
# ==================

source "$SH_SCRIPTS/utils.sh" || return
source "$SH_SCRIPTS/init.sh" || return


# ===========
# completions
# ===========

# Enable programmable completion features.
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

# Enable completions for various tools.
command-exists pip && eval "$(pip completion --bash)"
command-exists gh && eval "$(gh completion --shell bash)"
command-exists invoke && eval "$(invoke --print-completion-script bash)"
command-exists nox && eval "$(register-python-argcomplete nox)"
# poetry -> /etc/bash_completion.d/poetry


# ======
# prompt
# ======

# Mimic PowerLevel10k's git prompt (only rough approximation).
_prompt_git() {
    local out ref uncommited unstaged untracked ahead behind
    # Check if the pwd contains a git repository and exit early if it does not.
    ref=$(git rev-parse --abbrev-ref --symbolic-full-name HEAD 2> /dev/null)
    [ "$ref" == "" ] && return
    # Check if the current HEAD is detached or reachable by a ref.
    echo -en "\033[0;37m "
    if [ "$ref" == "HEAD" ]; then
        ref=$(git rev-parse --short HEAD)
        echo -en "@"
    fi
    echo -en "\033[0;32m$ref\033[0m"
    # Indicate if local is ahead and/or behind upstream.
    ahead=0
    behind=0
    git status 2>/dev/null | (
        while read -r line ; do
            case "$line" in
                 *'diverged'*)  # For simplicity, a diverged local branch is
                     ahead=1 ; behind=1 ; break ; ;;  # indicated as being
                 *'ahead'*)     # both ahead and behind its upstream
                     ahead=1 ; ;;
                 *'behind'*)
                     behind=1 ; ;;
            esac
        done

        if [ $ahead -gt 0 ] && [ $behind -gt 0 ]; then
            echo -en "\033[0;32m <>\033[0m"
        elif [ $ahead -gt 0 ]; then
            echo -en "\033[0;32m >\033[0m"
        elif [ $behind -gt 0 ]; then
            echo -en "\033[0;32m <\033[0m"
        fi
    )
    # Indicate stashed files with a *
    [ "$(git stash list 2> /dev/null)" != "" ] && echo -en "\033[0;32m *\033[0m"
    # Indicate uncommited/staged with a +
    git diff-index --cached --exit-code --quiet HEAD -- 2> /dev/null
    [ $? -gt 0 ] && echo -en "\033[0;33m +\033[0m"
    # Indicate unstaged with a !
    git diff-files --exit-code --quiet 2> /dev/null
    [ $? -gt 0 ] && echo -en "\033[0;33m !\033[0m"
    # Indicate untracked files with a ?
    if [ "$(git ls-files --exclude-standard --others 2> /dev/null)" != "" ]; then
        echo -en "\033[0;34m ?\033[0m"
    fi
}

# Mimic zsh's "%" symbol indicating background jobs.
_prompt_jobs() {
      local running
      (( $(jobs -rp | wc -l) )) && echo -e "\033[0;32m %\033[0m"
}

# Mimic zsh's pyenv/venv integration.
_prompt_pyenv() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo -e "\033[0;36m py $(python -c "import os, sys; (hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix)) and print(os.path.basename(sys.prefix))")\033[0m"
    elif [ -n "$PYENV_VERSION" ]; then
        if [ "$PYENV_VERSION" != "system" ]; then
            echo -e "\033[0;36m py $PYENV_VERSION\033[0m"
        fi
    elif [ -f "$(pwd)/.python-version" ]; then
        echo -e "\033[0;36m py $(cat .python-version | sed ':a;N;$!ba;s/\n/:/g')\033[0m"
    fi
}
# Disable the default prompts set by pyenv and venv.
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

PS1='\w$(_prompt_git)$(_prompt_jobs)$(_prompt_pyenv) > '
PS2='... '

# Show the pwd as the window title in X terminals.
case ${TERM} in
    xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
        xtitle() {
            echo -ne "\033]0;$(pwd)\007"
        }
        ;;
    *)
        ;;
esac
export PROMPT_COMMAND="xtitle; $PROMPT_COMMAND"


# =======
# aliases
# =======

source "$SH_SCRIPTS/aliases.sh" || return

# Add tab completion for all aliases to commands with completion functions
# Source: https://superuser.com/a/437508
_alias_completion() {
    local namespace="alias_completion"
    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"
    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0
    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1
    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"
    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"
        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"
        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"
        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi
        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && \rm -f "$tmp_file"
}; _alias_completion
