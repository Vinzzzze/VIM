" Fichier : debug.vim
"
" But : Syntax definition for the debug output file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 nov. 2016
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn match	dbgNumber		display "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match	dbgNumber		display "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match   dbgFile        display contained "\./[\.A-Za-z0-9/_]\+"

syn match   dbgPrompt      "^(gdb)"
syn match   dbgPrompt      "^\d\+"
syn match   dbgPromptStack "^#\d\+"

syn keyword dbgBreak       break
syn keyword dbgPrint       print display
syn keyword dbgExec        next step continue run
syn keyword dbgDisplay     list bt

syn region  dbgFilePosition   start=+at + end=+$+ contains=dbgFile

highlight dbgNumber guifg=white guibg=black gui=bold
highlight dbgPrompt guifg=red guibg=black
highlight dbgFile guifg=#ff80ff guibg=black gui=italic
highlight dbgFilePosition guifg=#ff80ff guibg=black gui=italic
highlight dbgBreak guifg=Orange guibg=black
highlight dbgPrint guifg=yellow guibg=black
highlight dbgExec guifg=cyan guibg=black
highlight dbgDisplay guifg=grey60 guibg=black
highlight dbgPromptStack guifg=#ffa0a0 guibg=black gui=bold

"---< Fin de fichier >----------------------------------------------------------

