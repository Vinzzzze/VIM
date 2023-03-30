" Fichier : unsetting_php.vim
"
" But : Unsetting pour les fichiers de langage php
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Elimination de la fonction de choix de l'environnement d'ex�cution
"    Elimination de la fonction de l'�limination d'un environnement d'ex�cution
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
if ( exists( "*PhpFoldLevel" ) != 0 )
   delfunction PhpFoldLevel
endif
if ( exists( "*PhpFoldText" ) != 0 )
   delfunction PhpFoldText
endif

"---< Fin de fichier >----------------------------------------------------------

