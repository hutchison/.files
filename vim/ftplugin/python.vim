setlocal textwidth=87  " lines longer than 88 columns will be broken
setlocal colorcolumn=+1
setlocal shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
setlocal tabstop=4     " a hard TAB displays as 4 columns
setlocal expandtab     " insert spaces when hitting TABs
setlocal softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
setlocal shiftround    " round indent to multiple of 'shiftwidth'
setlocal autoindent    " align the new line indent with the previous line

let g:syntastic_python_checkers = ["ruff"]
