" Fichier : db_base.vim
"
" But : Default setting for the database action.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 30 avr. 2014
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

" Destruction des fonctions
"--------------------------
if ( ( exists( "*CleanEnvironnement" ) != 0 )&&( exists( "useCleanEnvironnement" ) == 0 ) )
   delfunction CleanEnvironnement
endif
if ( ( exists( "*ChooseEnvironnement" ) != 0 )&&( exists( "useChooseEnvironnement" ) == 0 ) )
   delfunction ChooseEnvironnement
endif
if ( ( exists( "*CompileSQLSelection" ) != 0 )&&( exists( "useCompileSQLSelection" ) == 0 ) )
   delfunction CompileSQLSelection
endif
if ( ( exists( "*ExecuteSQLCommand" ) != 0 )&&( exists( "useExecuteSQLCommand" ) == 0 ) )
   delfunction ExecuteSQLCommand
endif
if ( ( exists( "*CompileSQLFile" ) != 0 )&&( exists( "useCompileSQLFile" ) == 0 ) )
   delfunction CompileSQLFile
endif
if ( ( exists( "*GetConnexionInfo" ) != 0 )&&( exists( "useGetConnexionInfo" ) == 0 ) )
   delfunction GetConnexionInfo
endif
if ( exists( "g:SQLOptionServer" ) != 0 )
   unlet g:SQLOptionServer
endif
if ( exists( "g:SQLOptionBase" ) != 0 )
   unlet g:SQLOptionBase
endif
if ( exists( "g:SQLOptionPassword" ) != 0 )
   unlet g:SQLOptionPassword
endif
if ( exists( "g:SQLOptionLogin" ) != 0 )
   unlet g:SQLOptionLogin
endif


"---< Fin de fichier >----------------------------------------------------------

