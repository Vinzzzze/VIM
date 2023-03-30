" Fichier : unsetting_cpp.vim
"
" But : Unsetting pour les fichiers de langage C++
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Elimination de la fonction de choix de l'environnement d'exécution
"    Elimination de la fonction de l'élimination d'un environnement d'exécution
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
if ( ( exists( "g:CPP_GetSet" ) == 0 )&&( exists( "*CreateGetSet" ) != 0 ) )
   delfunction CreateGetSet
endif
if ( ( exists( "g:CPP_Get" ) == 0 )&&( exists( "*CreateGet" ) != 0 ) )
   delfunction CreateGet
endif
if ( exists( "*CppFoldLevel" ) != 0 )
   delfunction CppFoldLevel
endif
if ( exists( "*CppFoldText" ) != 0 )
   delfunction CppFoldText
endif
if ( exists( "*BuildFunctionComment" ) != 0 )
   delfunction BuildFunctionComment
endif
if ( exists( "*BuildFunctionBody" ) != 0 )
   delfunction BuildFunctionBody
endif

"---< Fin de fichier >----------------------------------------------------------

