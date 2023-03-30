" Fichier : pdl.vim
"
" But : Quitting the PDL file type
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
if ( exists( "*PDLConvertFile" ) != 0 )
   delfunction PDLConvertFile
endif
if ( exists( "*PDLBuildExec" ) != 0 )
   delfunction PDLBuildExec
endif
if ( exists( "*PDLSortFile" ) != 0 )
   delfunction PDLSortFile
endif
if ( exists( "*PDLFoldLevel" ) != 0 )
   delfunction PDLFoldLevel
endif
if ( exists( "*PDLFoldText" ) != 0 )
   delfunction PDLFoldText
endif

" Restore the case option
"------------------------
call VM_RestoreIgnoreCase()

"---< Fin de fichier >----------------------------------------------------------

