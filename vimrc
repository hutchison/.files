runtime bundle/pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

if !has('python3')
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

" zeige immer die Statuszeile an
" (ist wichtig, damit die schöne airline angezeigt wird)
set laststatus=2
" zeige _nicht_ den aktuellen Modus an
" (das übernimmt die schöne airline)
set noshowmode
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
set backup
let $BACKUPDIR=$HOME . '/.vim/backup/'
set backupdir=$BACKUPDIR
set noswapfile

colorscheme solarized
hi Normal ctermbg=none
hi NonText ctermbg=none
hi SpecialKey ctermbg=none
hi LineNr ctermbg=none

set ttyfast

" zeige besondere Zeichen bei Tabs etc. an:
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,eol:¬

let g:airline_powerline_fonts = 1

"schaltet hlsearch aus
noremap <silent> <return> :nohlsearch<Bar>:echo<CR>
" zum Tag/Funktionsdef. springen:
nmap <leader>f <C-]>
" map <F5> to make:
nmap <F5> :make<CR>
" öffne meine .vimrc:
nmap <silent> <leader>v :next $MYVIMRC<CR>
" wenn meine .vimrc verändert wurde, dann lade sie automatisch neu:
augroup VimReload
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end
" buffer movement:
nnoremap <space> :bnext<cr>
nnoremap <backspace> :bprevious<cr>
" NERDTree:
noremap <C-g> :NERDTreeToggle<CR>
" split navigations:
nnoremap <DOWN> <C-W><C-J>
nnoremap <UP> <C-W><C-K>
nnoremap <RIGHT> <C-W><C-L>
nnoremap <LEFT> <C-W><C-H>
" Shortcuts für häufig benutzte Zeichen:
inoremap <C-l> \
cnoremap <C-l> \
inoremap <C-c> [
inoremap <C-v> ]
inoremap <C-y> \|

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
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_confirm_extra_conf = 0

map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

""" Airline
" der zweite Algorithmus zur Whitespaceerkennung funktioniert wohl besser:
let g:airline#extensions#whitespace#mixed_indent_algo = 1

""" Syntastic
let g:syntastic_python_checkers = ["pyflakes", "python"]
let g:syntastic_tex_checkers = ["chktex", "lacheck"]
" Flake8
let python_highlight_all=1

""" NERDTree
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\.pyc$', '\~$']

""" Startify
let g:startify_custom_header = map(split(system('fortune -a'), '\n'), '"   ". v:val') + ['','']
