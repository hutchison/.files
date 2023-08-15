if exists("b:current_syntax")
	finish
endif

syn match person    '+\I\+'        containedin=ALL
syn match datum     '^@ .*'
syn match todo      '^\[.\] .*'
syn match todo_done '^\[✓\] .*'
syn match todo_del  '^\[✗\] .*'
syn match todo_fwrd '^\[>\] .*'
syn match todo_kanboard '^\[K\] .*'
syn match todo_ticketit '^\[T\] .*'
syn match frage     '\I.*?'
syn match header1   '^# .*'
syn match folgerung '⇒ .*'
syn region wichtig start=+!!!+ end=+!!!+

highlight person          ctermfg=200
highlight datum           ctermfg=9
highlight todo_done       ctermfg=2
highlight todo_del        ctermfg=8
highlight todo_fwrd       ctermfg=208
highlight todo_kanboard   ctermfg=201
highlight todo_ticketit   ctermfg=202
highlight todo            ctermbg=4 ctermfg=7
highlight frage           ctermfg=11
highlight folgerung       ctermfg=4
highlight wichtig         ctermbg=9
highlight header1         ctermbg=28

let b:current_syntax = "todo"
