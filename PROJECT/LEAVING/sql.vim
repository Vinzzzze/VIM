" Fichier : unsetting_sql.vim
"
" But : Unsetting pour les fichiers de Transact-SQL.
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

" Destruction des variables de gestion de base de données
"--------------------------------------------------------
if ( exists( "VIM_SQLSERVER_DEV" ) != 0 )
   unlet VIM_SQLSERVER_DEV
endif
if ( exists( "VIM_SQLBASE_DEV" ) != 0 )
   unlet VIM_SQLBASE_DEV
endif
if ( exists( "VIM_SQLLOGIN_DEV" ) != 0 )
   unlet VIM_SQLLOGIN_DEV
endif
if ( exists( "VIM_SQLSERVER_PROD" ) != 0 )
   unlet VIM_SQLSERVER_PROD
endif
if ( exists( "VIM_SQLBASE_PROD" ) != 0 )
   unlet VIM_SQLBASE_PROD
endif
if ( exists( "VIM_SQLLOGIN_PROD" ) != 0 )
   unlet VIM_SQLLOGIN_PROD
endif
if ( exists( "VIM_SQLSERVER_WEB" ) != 0 )
   unlet VIM_SQLSERVER_WEB
endif
if ( exists( "VIM_SQLBASE_WEB" ) != 0 )
   unlet VIM_SQLBASE_WEB
endif
if ( exists( "VIM_SQLLOGIN_WEB" ) != 0 )
   unlet VIM_SQLLOGIN_WEB
endif
if ( exists( "VIM_SQLSERVER_TEST" ) != 0 )
   unlet VIM_SQLSERVER_TEST
endif
if ( exists( "VIM_SQLBASE_TEST" ) != 0 )
   unlet VIM_SQLBASE_TEST
endif
if ( exists( "VIM_SQLLOGIN_TEST" ) != 0 )
   unlet VIM_SQLLOGIN_TEST
endif
if ( exists( "VIM_SQLSERVER_PREPROD" ) != 0 )
   unlet VIM_SQLSERVER_PREPROD
endif
if ( exists( "VIM_SQLBASE_PREPROD" ) != 0 )
   unlet VIM_SQLBASE_PREPROD
endif
if ( exists( "VIM_SQLLOGIN_PREPROD" ) != 0 )
   unlet VIM_SQLLOGIN_PREPROD
endif
if ( exists( "VIM_SQLSERVER_TOK" ) != 0 )
   unlet VIM_SQLSERVER_TOK
endif
if ( exists( "VIM_SQLBASE_TOK" ) != 0 )
   unlet VIM_SQLBASE_TOK
endif
if ( exists( "VIM_SQLLOGIN_TOK" ) != 0 )
   unlet VIM_SQLLOGIN_TOK
endif
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
if ( ( exists( "*WhoIsConnected" ) != 0 )&&( exists( "useWhoIsConnected" ) == 0 ) )
   delfunction WhoIsConnected
endif
if ( ( exists( "*CompileSQLFile" ) != 0 )&&( exists( "useCompileSQLFile" ) == 0 ) )
   delfunction CompileSQLFile
endif
if ( ( exists( "*GetConnexionInfo" ) != 0 )&&( exists( "useGetConnexionInfo" ) == 0 ) )
   delfunction GetConnexionInfo
endif

"---< Fin de fichier >----------------------------------------------------------

