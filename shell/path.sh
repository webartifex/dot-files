# Put a folder on the $PATH if it is not already there.
put-on-path () {
    if [ -d "$1" ] ; then
        case :$PATH: in
            *:$1:*) ;;
            *) PATH=$1:$PATH ;;
        esac
    fi
}

# List the $PATH variable, one element per line.
# If an argument is passed, grep for it.
path() {
    if [ -n "$1" ]; then
        echo "$PATH" | perl -p -e 's/:/\n/g;' | grep -i "$1"
    else
        echo "$PATH" | perl -p -e 's/:/\n/g;'
    fi
}
