" Set to the folder of the current file
" and its subdirectories. Exclude *.pyc
" files from the path.
setlocal path=.,,src/**,tests
setlocal wildignore=*/__pycache__/*,*.pyc

" TODO: This does not work, maybe because we spell out
" all project-local imports (e.g. from lalib.fields import base).
" Include *.py files imported as modules when searching.
" Source: https://www.youtube.com/watch?v=Gs1VDYnS-Ac
set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
" 1) import foo.bar -> foo/bar.py
" 2) from foo import bar as var -> foo/bar.py or foo.py
function! PyInclude(fname)
    let parts = split(a:fname, ' import ')  " 1) [foo.bar] or 2) [foo, bar]
    let left = parts[0]  " 1) foo.bar or 2) foo
    if len(parts) > 1
        let right = parts[1]  " only 2) bar
        let joined = join([left, right], '.')
        let fpath = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fpath, 1)
        if len(found)
            return found
        endif
    endif
    return substitute(left, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)

" Number of spaces used for each step of auto-indent.
set shiftwidth=4
" Number of spaces a <Tab> counts for in the file.
set tabstop=4
" Number of spaces a <Tab> counts for in editing mode.
set softtabstop=4
" Change <Tab>s into spaces.
set expandtab
" Copy indent from previous line when starting a new line.
set autoindent
" Use indent according to the syntax of the open file.
set smartindent

" Auto-wrap lines after 88 characters.
set textwidth=88

" Make the background color of every character
" beyond 80 red so that we see that the end
" according to a relaxed PEP8 is near.
highlight ColorColumn ctermbg=DarkRed
call matchadd('ColorColumn', '\%80v', 100)
match ErrorMsg '\%>80v.\+'
" The alternative would be make column 80 red in all rows.
" set colorcolumn=80
