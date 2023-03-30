" Fichier : VM_tab_buffers_internal.vim
"
" But : The syntax for the buffer list window.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 24 sept. 2014
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

syn keyword LanguageSingle java mac
syn keyword LanguageMultiple cpp hpp c h inc 
syn keyword LanguageScript php py js html htm vim str typ
syn keyword LanguageSQL PRC TAB sql
syn keyword Definitions yml json ini xml pdl
syn keyword TextFile txt log

syn match ProjectFile "[A-Za-z_\-]*todo[A-Za-z_\-]*"

syn match specialBuffer "\[[^ 	]\+"
syn match fileSeparator contained "\/"

syn region fileLocation start="((" end="))" contains=fileSeparator,ProjectFile

if ( !exists( "did_VM_tab_buffers_internal_syntax_inits" ) )
   let did_VM_tab_buffers_internal_syntax_inits = 1

   hi link LanguageSingle     PreProc
   hi link LanguageMultiple   WarningMsg
   hi link LanguageSQL        ToDo
   hi link fileSeparator      Special

   highlight ProjectFile guifg=white guibg=black gui=bold
   highlight Definitions guifg=Red guibg=black
   highlight TextFile guifg=Green guibg=black gui=italic
   highlight LanguageScript guifg=Yellow guibg=black gui=italic
   highlight specialBuffer  guifg=Grey30 guibg=black gui=italic
   highlight fileLocation   guifg=Grey guibg=black gui=italic
endif

let b:current_syntax = "VM_tab_buffers_internal"

"---< Fin de fichier >----------------------------------------------------------

