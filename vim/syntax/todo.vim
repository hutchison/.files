if exists("b:current_syntax")
	finish
endif

syn match datum	'^@ .*'
syn match folgerung	'^⇒ .*'
syn match todo	'^\[.\] .*'
syn match frage	'\u.*?'

highlight def link datum	Statement
highlight def link todo		Todo
highlight def link frage	String
highlight def link folgerung	PreProc

let b:current_syntax = "todo"
