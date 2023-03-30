" Fichier : unsetting_c.vim
"
" But : Unsetting pour les fichiers de langage C
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

" Destruction des fonctions
"--------------------------
if ( exists( "*BuildFunctionComment" ) != 0 )
   delfunction BuildFunctionComment
endif
if ( exists( "*BuildFunctionBody" ) != 0 )
   delfunction BuildFunctionBody
endif
if ( exists( "*ComputeFunctionName" ) != 0 )
   delfunction ComputeFunctionName
endif
if ( exists( "*ConvertNumToCommand" ) != 0 )
   delfunction ConvertNumToCommand
endif

"---< Fin de fichier >----------------------------------------------------------

