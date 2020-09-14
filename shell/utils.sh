# Define utility functions for bash and zsh.

# Check if a command can be found on the $PATH.
command-exists() {
    command -v "$1" 1>/dev/null 2>&1
}

# Check if we are running from within a zsh instance.
in-zsh() {
    [ -n "$ZSH_VERSION" ]
}

source "$SH_SCRIPTS/utils.d/files.sh"
source "$SH_SCRIPTS/utils.d/passwords.sh"
source "$SH_SCRIPTS/utils.d/services.sh"
source "$SH_SCRIPTS/utils.d/update.sh"
source "$SH_SCRIPTS/utils.d/misc.sh"
