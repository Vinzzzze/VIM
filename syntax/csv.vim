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

syn match csvSeparator ","
syn match csvFrenchSeparator ";"

syn region csvQuotedColumn start=+"+ skip=+""+ end=+"+

hi link csvSeparator Error
hi link csvQuotedColumn String
hi csvFrenchSeparator guifg=Red guibg=Yellow

let b:current_syntax = "csv"

" vim: ts=8
