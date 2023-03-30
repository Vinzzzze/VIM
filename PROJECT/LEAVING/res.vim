" Fichier : unsetting_res.vim
"
" But : Annulation des settings d'un fichier de résultat de l'exécution SQL.
"
" Auteur : Vini "Cool Coyote" - coolcoyote@club-internet.fr
" Date : 11/09/2001
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

" Unset the global variable
"--------------------------
if ( exists( "globalFoldValue" ) != 0 )
   unlet globalFoldValue
endif

" Destruction des fonctions
"--------------------------
if ( exists( "*CompileSQLSelection" ) != 0 )
   delfunction CompileSQLSelection
endif
if ( exists( "*ExecuteSQLCommand" ) != 0 )
   delfunction ExecuteSQLCommand
endif
if ( exists( "*WhoIsConnected" ) != 0 )
   delfunction WhoIsConnected
endif
if ( exists( "*CompileSQLFile" ) != 0 )
   delfunction CompileSQLFile
endif
if ( exists( "*GetConnexionInfo" ) != 0 )
   delfunction GetConnexionInfo
endif
if ( exists( "*ResultFoldLevel" ) != 0 )
   delfunction ResultFoldLevel
endif

"---< Fin de fichier >----------------------------------------------------------

