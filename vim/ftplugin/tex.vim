setlocal textwidth=90  " lines longer than 90 columns will be broken
setlocal colorcolumn=+1
setlocal shiftwidth=2  " operation >> indents 4 columns; << unindents 4 columns
setlocal tabstop=2     " a hard TAB displays as 4 columns
setlocal expandtab     " insert spaces when hitting TABs
setlocal softtabstop=2 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
setlocal shiftround    " round indent to multiple of 'shiftwidth'
setlocal autoindent    " align the new line indent with the previous line

setlocal syntax=plaintex

let g:tex_flavor='plaintex'
let g:syntastic_tex_checkers = ["chktex"]
""" Um in tex-Dateien Warnungen abzuschalten musst du folgendes tun:
"
" % chktex-file ##
"
" sorgt dafür, dass Warnungen mit der Nummer ## in der ganzen Datei ignoriert
" werden. Benutze :Errors um diese Nummer herauszufinden.
"
" % chktex ##
"
" ignoriert die Warnung mit der Nummer ## in der aktuellen Zeile.
"
" setlocal makeprg=pdflatex\ %
