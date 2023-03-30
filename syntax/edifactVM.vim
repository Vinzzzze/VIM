if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Edifact is for uppercase lovers
syn case match

syn keyword edifactMsg contained UNH UNT
syn keyword edifactFile contained UNB UNZ

syn match edifactIdentFirst /^[A-Z]\+\>/ contains=edifactMsg,edifactFile
syn match edifactIdentifier /\[A-Z]\+\>/ contains=edifactMsg,edifactFile
syn match edifactTag /\[A-Z0-9]\+\>/ contains=edifactMsg,edifactFile

syn match edifactNumber /\<[0-9]\+\>/
syn match edifactDate /\<[0-9]\+\(\/\|-\)[0-9]\+\(\/\|-\)[0_9]\+\>/
syn match edifactTime /\<[0-9]\+:[0-9]\+:[0_9]\+\>/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_asm_syntax_inits")
  if version < 508
    let did_edifact_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  " Uncolored segment is an error, but we have a c
  "HiLink edifactSegment     edifactError
  HiLink edifactMsg         MoreMsg
  HiLink edifactFile        Special
  HiLink edifactIdentFirst  ErrorMsg
  HiLink edifactIdentifier  ErrorMsg
  HiLink edifactTag         PreProc
  HiLink edifactNumber      Statement
  HiLink edifactDate        Special
  HiLink edifactTime        Special
  delcommand HiLink
endif

let b:current_syntax = "edifact"

" vim:ts=8:sts=4:sw=2:
