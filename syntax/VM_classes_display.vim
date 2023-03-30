" Fichier : VM_classes_display.vim
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

syn match Categorie " [A-Za-z_\-0-9]\+"
syn match SubCategorie " [A-Za-z_\-0-9]\+ : [()A-Za-z_\-0-9 ]\+"
syn match InternalCategorie "# .\+"
syn match Language "> .*"
syn match Class "Class .*"
syn match Enum "Enum .*"
syn match File "File .*"

syn region Location start="(" end=")"
syn region EnumValue start="{" end="}"

if ( !exists( "did_VM_classes_display_syntax_inits" ) )
   let did_VM_classes_display_syntax_inits = 1

   hi link Language     PreProc

   highlight Categorie guifg=White guibg=black gui=bold
   highlight SubCategorie guifg=Grey80 guibg=black
   highlight InternalCategorie guifg=Grey60 guibg=black gui=italic
   highlight Class guifg=Yellow guibg=black
   highlight Enum guifg=Orange guibg=black
   highlight File guifg=Cyan guibg=black
   highlight EnumValue guifg=red guibg=black gui=italic
   highlight Location guifg=Green guibg=black gui=italic
endif

let b:current_syntax = "VM_classes_display"

"---< Fin de fichier >----------------------------------------------------------

