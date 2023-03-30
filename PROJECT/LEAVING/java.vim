" Fichier : java.vim
"
" But : Unsetting pour les fichiers de langage Java
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
if ( exists( "*CreateGetSet" ) != 0 )
   delfunction CreateGetSet
endif
if ( exists( "*CreateGet" ) != 0 )
   delfunction CreateGet
endif
if ( exists( "*IndentLine" ) == 0 )
   delfunction IndentLine
endif
if ( exists( "*IndenteFunction" ) == 0 )
   delfunction IndenteFunction
endif

"---< Fin de fichier >----------------------------------------------------------

