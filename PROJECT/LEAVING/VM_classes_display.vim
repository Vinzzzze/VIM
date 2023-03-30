" Fichier : VM_classes_display.vim
"
" But : Unsetting the function for the classe display buffer
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 05 Jan 2015
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

" Destruction des fonctions
"--------------------------
if ( exists( "*CLASS_ComputeFoldLevel" ) != 0 )
   delfunction CLASS_ComputeFoldLevel
endif

" Destruction de la variable
"---------------------------
if ( exists( "g:VM_searchedText" ) != 0 )
   unlet g:VM_searchedText
endif
if ( exists( "g:VM_searchedIntro" ) != 0 )
   unlet g:VM_searchedIntro
endif

"---< Fin de fichier >----------------------------------------------------------

