if exists("b:current_syntax")
	finish
endif

syn match datum     '^@ .*'
syn match folgerung '^⇒ .*'
syn match todo      '^\[.\] .*'
syn match todo_done '^\[✓\] .*'
syn match todo_del  '^\[✗\] .*'
syn match frage     '\u.*?'
syn region wichtig start=+!!!+ end=+!!!+

highlight datum           ctermfg=9
highlight todo_done       ctermfg=2
highlight todo_del        ctermfg=8
highlight todo            ctermbg=12 ctermfg=7
highlight frage           ctermfg=11
highlight folgerung       ctermfg=12
highlight wichtig         ctermbg=9

let b:current_syntax = "todo"
