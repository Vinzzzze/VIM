" Fichier : VM_buffers_internal.vim
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

syn keyword statusActive active
syn keyword statusHidden hidden
syn keyword statusModified updated

syn match statusReadOnly "\[RO\]"
syn match interfaceFile "\<int_[A-Za-z0-9]\+"
syn match baseFile "\<base_[A-Za-z0-9]\+"
syn match ignoredTest "[A-Za-z0-9_]\+ITest\.java"

if ( !exists( "did_VM_buffers_internal_syntax_inits" ) )
   let did_VM_buffers_internal_syntax_inits = 1

   hi link statusActive          PreProc
   hi link statusHidden          Comment
   hi link ignoredTest           Comment
   hi link statusModified        ToDo
   hi link statusReadOnly        Error
   hi link interfaceFile         Comment
   hi link baseFile              Special

endif

let b:current_syntax = "VM_buffers_internal"

"---< Fin de fichier >----------------------------------------------------------

