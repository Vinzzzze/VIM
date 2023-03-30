" Fichier : unsetting_log.vim
"
" But : Unsetting pour les fichiers de langage log
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
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

"Destruction des variables
"-------------------------
if ( exists( "insidePDLList" ) != 0 )
   unlet insidePDLList
endif
" Destruction des fonctions
"--------------------------
if ( exists( "*LogFoldLevel" ) != 0 )
   delfunction LogFoldLevel
endif
if ( exists( "*LogFoldText" ) != 0 )
   delfunction LogFoldText
endif

"---< Fin de fichier >----------------------------------------------------------

