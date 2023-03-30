" Vim syntax file
" Language:	Velocity templates
" Maintainer:	Antonio Terceiro <terceiro@im.ufba.br>
" Last Change:	2003 Jan 22

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version < 600
  source $VIMRUNTIME/syntax/html.vim
else
  runtime! syntax/html.vim
endif

syn keyword	velocityTodo	contained TODO FIXME XXX

" the both reference types support the silent mode: $!variableName

syn match velocityIdentifier "[a-zA-Z][a-zA-Z_\-0-9]*" contained

" changed on suggestion from Philippe Paravicini <philippe.paravicini@datalex.com>
" syn region velocityReference         start=/\$/    skip=/(\s*\|\s*,\s*\|\s*)/   end=/\s\|$/  contains=velocityIdentifier,velocityString,velocityNumber
syn region velocityReference         start=/\$/    skip=/([^)])/                end=/\s\|$/  contains=velocityIdentifier,velocityString,velocityNumber

syn region velocitySilentReference   start=/\$\!/  skip=/(\s*\|\s*,\s*\|\s*)/   end=/\s\|$/   contains=velocityIdentifier,velocityString,velocityNumber

syn region velocityFormalReference   start=/\${/      end=/}/          contains=velocityIdentifier,velocityString,velocityNumber
syn region velocitySilentFormalReference   start=/\$\!{/      end=/}/  contains=velocityIdentifier,velocityString,velocityNumber

" keywords:
syn keyword velocityKeyWord contained set if else elseif end foreach include parse stop macro

" literals (numbers and strings):
syn match velocityNumber "[0-9][0-9]*\(\.[0-9][0-9]*\)\?" contained
syn region velocityString	contained start=+"+ skip=+\\\\\|\\"+ end=+"+ oneline

" highlighting the inicial sharp (#) of each directive:
syn match velocityInitialSharp "#" contained

syn match velocityDirective "^\s*#[^#].*" contains=velocityString,velocityReference,velocityFormalReference,velocityKeyWord,velocityNumber,velocityInitialSharp,velocityLineComment,velocityMultilineComment

" velocity comments:
syn region	velocityMultilineComment start=/#\*/ end=/\*#/ contains=velocityTodo
syn match	velocityLineComment	"##.*$" contains=velocityTodo


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_velocity_syntax_inits")

  highlight velocityLineComment              guifg=gray guibg=black
  highlight velocityMultilineComment         guifg=gray guibg=black
  hi def link velocityTodo                   Todo
  highlight velocityKeyWord                  guifg=white guibg=black
  highlight velocityReference                guifg=red guibg=black
  highlight velocitySilentReference          guifg=red guibg=black
  highlight velocityFormalReference          guifg=red guibg=black
  highlight velocitySilentFormalReference    guifg=red guibg=black
  highlight velocityIdentifier               guifg=Yellow guibg=black
  hi def link velocityNumber                 Number
  hi def link velocityString	               String
  highlight velocityInitialSharp             guifg=white guibg=black
endif

let b:current_syntax = "velocity"

" vim: ts=8 sw=2
