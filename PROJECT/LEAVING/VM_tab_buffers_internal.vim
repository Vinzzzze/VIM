" Fichier : VM_tab_buffers_internal.vim
"
" But : Quitting the tab buffer definition
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 10 Mar 2017
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

" Destruction de la variable
"---------------------------
if ( exists( "g:VM_searchedText" ) != 0 )
   unlet g:VM_searchedText
endif
if ( exists( "g:VM_searchedIntro" ) != 0 )
   unlet g:VM_searchedIntro
endif

"---< Fin de fichier >----------------------------------------------------------

