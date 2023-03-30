" Fichier : .vim
"
" But : The commands executed when entering in an empty file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 26 oct. 2016
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

if ( filereadable( ".empty_entering" ) != 0 )
   source .empty_entering
endif

"---< Fin de fichier >----------------------------------------------------------

