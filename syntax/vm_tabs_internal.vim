" Fichier : VM_tabs_internal.vim
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

syn match TabNumber "N°[0-9]\+"
syn match NumberFiles "\d\+"

syn region AllTabs start="^ALL" end="$" contains=NumberFiles

if ( !exists( "did_VM_tabs_internal_syntax_inits" ) )
   let did_VM_tabs_internal_syntax_inits = 1

   hi link TabNumber     PreProc

   highlight AllTabs guifg=white guibg=black gui=bold
   highlight NumberFiles guifg=Yellow guibg=black
endif

let b:current_syntax = "VM_tabs_internal"

"---< Fin de fichier >----------------------------------------------------------

