" Vim syntax file
" Language:	TSL
" Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2002 Jul 15

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword	tslTodo		contained TODO FIXME XXX
syn cluster	tslCommentGroup	contains=tslTodo
syn region	tslCommentL	start="//" end="$" contains=@tslCommentGroup
syn match	tslTrace	display "^\s*#trace\>"
syn match	tslStore	display "^\s*#store\>"
syn keyword tslConditional if
syn keyword tslSeparator , )
syn region	tslString	start=+L\="+ skip=+\\\\\|\\"+ end=+"+
syn match	tslFunction	display "\<[a-zA-Z_][a-zA-Z0-9_]\+("
syn match	tslAssignement	display "\<[a-zA-Z_][a-zA-Z0-9_]\+\s*=\s*"

highlight tslCommentL	guifg=gray
hi def link tslTodo		Todo
hi def link tslTrace Include
highlight tslStore guifg=yellow
hi def link tslConditional Operator
hi def link tslSeparator Operator
hi def link tslString String
hi def link tslFunction Statement
highlight tslAssignement guifg=white

let b:current_syntax = "tsl"

" vim: ts=8
