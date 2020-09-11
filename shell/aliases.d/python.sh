alias p='python'
alias py='python'
alias ipy='ipython'

if command-exists poetry; then
    alias pr='poetry run'
fi

if command-exists pyenv; then
    alias pvenvs='pyenv virtualenvs --bare --skip-aliases'
    alias pyvenvs='pvenvs'
    alias pver='pyenv version'
    alias pyver='pver'
    alias pvers='pyenv versions --skip-aliases'
    alias pyvers='pvers'
    alias pwhich='pyenv which'
    alias pywhich='pwhich'
fi
