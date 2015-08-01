runtime bundle/pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

if !has('python')
	call add(g:pathogen_disabled, 'ultisnips')
	call add(g:pathogen_disabled, 'youcompleteme')
endif

execute pathogen#infect()

" most common options:
syntax on
set number
set hidden
set nocompatible
filetype plugin indent on
set laststatus=2
set hlsearch
set incsearch
set ignorecase
" setzt automatisch das g Flag bei Textersetzungen:
set gdefault
" wechselt automatisch das Verzeichnis:
set autochdir

let mapleader=','

set backspace=indent,eol,start
set smartindent
set wildmenu
set nobackup
set noswapfile

colorscheme solarized

set ttyfast

" zeige besondere Zeichen bei Tabs etc. an:
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮

let g:airline_powerline_fonts = 1

"schaltet hlsearch aus
noremap <silent> <return> :nohlsearch<Bar>:echo<CR>
" zum Tag/Funktionsdef. springen:
nmap <leader>f <C-]>
" buffer movement:
nnoremap <space> :bnext<cr>
nnoremap <backspace> :bprevious<cr>
" NERDTree:
noremap <C-l> :NERDTreeToggle<CR>
inoremap <C-l> <ESC>:NERDTreeToggle<CR>

""" Snippets
" Was müssen wir drücken, damit Snippets ausgelöst werden?
let g:UltiSnipsExpandTrigger="<c-j>"
" Zum nächsten Snippet:
let g:UltiSnipsJumpForwardTrigger="<c-j>"
" Zum vorherigen Snippet:
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" Alle Snippets anzeigen:
let g:UltiSnipsListSnippets="<c-H>"

""" Konfiguration von YouCompleteMe
""" bei Bedarf auskommentieren
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

""" Airline
" der zweite Algorithmus zur Whitespaceerkennung funktioniert wohl besser:
let g:airline#extensions#whitespace#mixed_indent_algo = 1

""" Syntastic
let g:syntastic_python_checkers = ["pyflakes", "python"]

""" NERDTree
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
