" Fichier : VM_fixed_length_column_internal.vim
"
" But : Quitting the fixed length column list definition
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 15 Jan 2020
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

if ( exists( "g:VM_searchedText" ) != 0 )
   unlet g:VM_searchedText
endif
if ( exists( "g:VM_searchedIntro" ) != 0 )
   unlet g:VM_searchedIntro
endif

"---< Fin de fichier >----------------------------------------------------------

