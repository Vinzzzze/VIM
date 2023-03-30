" Fichier : php.vim
"
" But : VIM systax extention for folding.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 10 janv. 2016
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

if exists("php_parent_error_open")
  syn region  phpComment  start="/\*" end="\*/" contained contains=phpTodo fold
else
  syn region  phpComment  start="/\*" end="\*/" contained contains=phpTodo extend fold
endif

"---< Fin de fichier >----------------------------------------------------------

