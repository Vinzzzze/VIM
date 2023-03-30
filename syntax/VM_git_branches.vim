" Fichier : VM_git_branches.vim
"
" But : The syntax for the branches list window
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 14 Aug 2017
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

syn keyword BranchToAbandon ABANDON CLOSED
syn keyword BranchPaused TODO

syn match NonSelectedBranch /^  [^ ]\+/
syn match SelectedBranch /^> [^ ]\+/
syn match CommentBranch /:: .*/ contains=BranchToAbandon,BranchPaused

if ( !exists( "did_VM_git_branches_syntax_inits" ) )
   let did_VM_git_branches_syntax_inits = 1

   hi link SelectedBranch         PreProc
   hi link NonSelectedBranch      Identifier
   hi link CommentBranch          Normal
   hi link BranchToAbandon        Error
   hi link BranchPaused           Todo

endif

let b:current_syntax = "VM_git_branches"

"---< Fin de fichier >----------------------------------------------------------

