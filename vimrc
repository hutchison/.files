runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" most common options:
syntax on
set number
set nocompatible
filetype plugin indent on
set laststatus=2
set hlsearch
set incsearch
set ignorecase

let mapleader=','

set backspace=indent,eol,start
set smartindent
set wildmenu
set nobackup
set noswapfile

colorscheme solarized

let g:airline_powerline_fonts = 1

"schaltet hlsearch aus
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" zum Tag/Funktionsdef. springen:
nmap <leader>f <C-]>
" buffer movement:
nmap <leader>e <ESC>:bnext<CR>
nmap <leader>q <ESC>:bprevious<CR>

""" Snippets
" Was müssen wir drücken, damit Snippets ausgelöst werden?
let g:UltiSnipsExpandTrigger="<c-j>"
" Zum nächsten Snippet:
let g:UltiSnipsJumpForwardTrigger="<c-j>"
" Zum vorherigen Snippet:
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" Alle Snippets anzeigen:
let g:UltiSnipsListSnippets="<c-K>"
