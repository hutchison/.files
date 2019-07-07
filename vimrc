runtime bundle/pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

if !has('python3')
	call add(g:pathogen_disabled, 'ultisnips')
	call add(g:pathogen_disabled, 'youcompleteme')
endif

execute pathogen#infect()

" Syntaxhighlighting muss schon sein:
syntax enable
" versteckte Buffer bleiben erhalten:
set hidden
" This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way:
set nocompatible
" enable detection, plugins and indenting in one step:
filetype plugin indent on

" zeige immer die Statuszeile an
" (ist wichtig, damit die schöne airline angezeigt wird)
set laststatus=2
" zeige _nicht_ den aktuellen Modus an
" (das übernimmt die schöne airline)
set noshowmode
" zeige die Zeilennummern an:
set number
" aber zeige die relative Zeilennummer an, damit man schnell springen kann:
set relativenumber
set hlsearch
set incsearch
set ignorecase
" Always replace all occurences of a line
set gdefault
" wechselt automatisch das Verzeichnis:
set autochdir

set backspace=indent,eol,start
" enable detection, plugins and indenting in one step:
set smartindent
" Enhanced command line completion:
set wildmenu
" Complete files like a shell:
set wildmode=list:longest
set backup
let $BACKUPDIR=$HOME . '/.vim/backup/'
set backupdir=$BACKUPDIR
set noswapfile
" Automatically read a file that has changed on disk:
set autoread
" make plugins smoother:
set lazyredraw

" Farbenspiel:
set t_Co=16
let g:solarized_termcolors=16
let g:solarized_termtrans=0
let g:solarized_menu=0
let g:solarized_italic=1
let g:solarized_contrast="high"

colorscheme solarized

hi Normal ctermbg=none
hi NonText ctermbg=none
hi SpecialKey ctermbg=none
hi LineNr ctermbg=none

set ttyfast

" zeige besondere Zeichen bei Tabs etc. an:
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,eol:¬

" wenn meine .vimrc verändert wurde, dann lade sie automatisch neu:
augroup VimReload
	autocmd!
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup end

""" Mappings

let mapleader=','

" zur Definition/Deklaration springen:
nnoremap <leader>f :YcmCompleter GoTo<CR>

" zum Tag springen:
" hilfreich für help-files
nnoremap <leader>t <C-]>

" map <F5> to make:
nnoremap <leader>m :make<CR>

" Shortcuts für Orthographie:
" Move to next misspelled word after the cursor.
nnoremap <leader>r ]s

" Start a substitute
nnoremap <leader>s :%s,

" öffne meine .vimrc:
nnoremap <silent> <leader>v :next $MYVIMRC<CR>

"schaltet hlsearch aus
noremap <silent> <return> :nohlsearch<Bar>:echo<CR>

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

" H und L benutze ich ohnehin nicht. Daher ist‘s clever, wenn sie was
" sinnvolles tun:
nnoremap H 0
nnoremap L $

" Yank from the cursor to the end of the line, to be consistent with C and D:
nnoremap Y y$

" Shortcuts für häufig benutzte Zeichen:
inoremap <C-l> \
cnoremap <C-l> \
inoremap <C-c> [
inoremap <C-v> ]
inoremap <C-_> <Bar>
inoremap <C-d> {
inoremap <C-f> }

""" Snippets
" Wo wird nach Snippets gesucht?
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
" Was müssen wir drücken, damit Snippets ausgelöst werden?
" Default ist <TAB>
"let g:UltiSnipsExpandTrigger="<c-j>"
" Zum nächsten Snippet:
let g:UltiSnipsJumpForwardTrigger="<c-j>"
" Zum vorherigen Snippet:
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" Alle Snippets anzeigen:
let g:UltiSnipsListSnippets="<c-H>"

""" YouCompleteMe
" bei Bedarf auskommentieren
let g:ycm_key_list_select_completion=['<c-j>']
let g:ycm_key_list_previous_completion=['<c-s-j>']

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

if filereadable('/usr/local/bin/python3')
	let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
	let g:ycm_path_to_python_interpreter = '/usr/local/bin/python3'
else
	let g:ycm_server_python_interpreter = '/usr/bin/python3'
	let g:ycm_path_to_python_interpreter = '/usr/bin/python3'
endif

let g:ycm_python_binary_path = 'python3'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_of_chars_for_completion = 5
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_blacklist = {
	\ 'tagbar' : 1,
	\ 'qf' : 1,
	\ 'notes' : 1,
	\ 'markdown' : 0,
	\ 'unite' : 1,
	\ 'text' : 0,
	\ 'vimwiki' : 1,
	\ 'pandoc' : 1,
	\ 'infolog' : 1,
	\ 'mail' : 1,
	\ 'startify' : 1,
	\ 'tex' : 1
\}

""" Airline
let g:airline_powerline_fonts=1
" der zweite Algorithmus zur Whitespaceerkennung funktioniert wohl besser:
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" zeigt die aktuellen Buffer an:
let g:airline#extensions#tabline#enabled = 1

""" NERDTree
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\.pyc$', '\~$']

""" quick commit mode via git
" Wenn g:git_autocommit_on_save aktiviert ist, dann wird bei jedem
" Schreibvorgang auch ein Commit erzeugt.
let g:git_autocommit_on_save = 0

function! GitQuickcommit()
	if exists('b:git_dir') && g:git_autocommit_on_save
		:silent ! git add %
		:silent ! git commit -q -m "Auto-commit: %" > /dev/null 2>&1
	endif
endfunction

autocmd BufWritePost * call GitQuickcommit()
