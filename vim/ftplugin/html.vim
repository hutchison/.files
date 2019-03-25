setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

setlocal expandtab

setlocal autoindent

nnoremap <F8> :%!tidy -m -xml -i -q -utf8 -w 0<CR>
