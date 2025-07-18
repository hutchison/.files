runtime bundle/pathogen/autoload/pathogen.vim

" To disable a plugin, add it's bundle name to the following list
let g:pathogen_disabled = []

if !has('python3')
	call add(g:pathogen_disabled, 'ultisnips')
endif

execute pathogen#infect()

" Syntaxhighlighting muss schon sein:
syntax enable
" Nutze die NFA Engine und nicht die old engine:
set regexpengine=2
" Zeit, die vergehen darf, bevor das Syntaxhighlighting abgebrochen wird:
" (z.B. weil's zu lange dauert)
set redrawtime=200
" versteckte Buffer bleiben erhalten:
set hidden
" This option has the effect of making Vim either more Vi-compatible, or make Vim behave in a more useful way:
set nocompatible
" enable detection, plugins and indenting in one step:
filetype plugin indent on

set nocursorline
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
colorscheme slate
set cursorline
set cursorlineopt=number

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

" zum Tag springen:
" hilfreich für help-files
nnoremap <leader>t <C-]>

" map <F5> to make:
nnoremap <leader>m :make<CR>

"schaltet hlsearch aus
noremap <silent> <return> :nohlsearch<Bar>:echo<CR>

" buffer movement:
nnoremap <space> :bnext<cr>
nnoremap <backspace> :bprevious<cr>

" schalte paste-Modus um:
nnoremap <F3> :set invpaste<cr>

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
inoremap ª [
inoremap <C-v> ]
inoremap º ]
inoremap <C-d> {
inoremap <C-f> }
inoremap <Right> →
inoremap <Left> ←
inoremap <Up> ↑
inoremap <Down> ↓

""" Snippets
" Wo wird nach Snippets gesucht?
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]
" Was müssen wir drücken, damit Snippets ausgelöst werden?
" Default ist <TAB>
let g:UltiSnipsExpandTrigger="<TAB>"
" Zum nächsten Snippet:
let g:UltiSnipsJumpForwardTrigger="<TAB>"
" Zum vorherigen Snippet:
let g:UltiSnipsJumpBackwardTrigger="<C-p>"
" Alle Snippets anzeigen:
let g:UltiSnipsListSnippets="<C-t>"

""" Airline
let g:airline_powerline_fonts = 1
" der zweite Algorithmus zur Whitespaceerkennung funktioniert wohl besser:
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" zeigt die aktuellen Buffer an:
let g:airline#extensions#tabline#enabled = 1

""" NERDTree
let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['\.pyc$', '\~$']

""" CtrlP
let g:ctrlp_custom_ignore = {
	\ 'file': '\v\.(pyc)$',
	\ 'dir': '\v[\/][v]env$',
\ }

""" ack.vim
" cf. https://www.freecodecamp.org/news/how-to-search-project-wide-vim-ripgrep-ack/
" Use ripgrep for searching
" Options include:
" --vimgrep -> Needed to parse the rg response properly for ack.vim
" --type-not sql -> Avoid huge sql file dumps as it slows down the search
" --smart-case -> Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1
" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1
" Use this option to highlight the searched term.
let g:ackhighlight = 1
" Use this option to automagically open the file with 'j' or 'k'.
let g:ackpreview = 1
" Maps <leader>s so we're ready to type the search keyword
nnoremap <leader>s :Ack<Space>
" Navigate quickfix list with ease
nnoremap <silent> <C-e> :cnext<CR>
nnoremap <silent> <C-f> :cprevious<CR>

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
