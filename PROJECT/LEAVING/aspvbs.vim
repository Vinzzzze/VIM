" Fichier : unsetting_aspvbs.vim
"
" But : Annulation des variables et fonctions déclarées lors de l'arrivé dans le
"       fichier ASP
"
" Auteur : Vini "Cool Coyote" - coolcoyote@club-internet.fr
" Date : 19/09/2001
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

" Annulation des variables crées
"-------------------------------
if ( exists( "VIM_IIS_FILENAME" ) != 0 )
   unlet VIM_IIS_FILENAME
endif
if ( exists( "VIM_IIS_DESTREP" ) != 0 )
   unlet VIM_IIS_DESTREP
endif

"---< Fin de fichier >----------------------------------------------------------

