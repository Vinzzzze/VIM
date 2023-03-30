" Fichier : setting_sql.vim
"
" But : Setting pour les fichiers de Transact-SQL.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Ajout de la fonction de choix de l'environnement SQL d'ex�cution. Modification
"    du mapping en cons�quence.
"    Ajout de la fonction d'�limination d'un evironnement particulier. Modification
"    du mapping en cons�quence
"--------------------------
" Modify : VM - 29 Oct 2001
"    Ajout du mapping des touches pour �viter l'utilisation des accents.
"--------------------------
" Modify : VM - 23 May 2002
"    Ajout du server WEB, �limination du comptage des lignes lors de l'ex�cution de la commande isql
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

" Red�finition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=8
setlocal tabstop=8
" Pour la cr�ation des d�but et fin de bloc
"------------------------------------------
imap <buffer> <C-M-{> BEGIN<cr>END -- <esc>O<tab>
" Le mapping des touches pour la compile en dev et en prod
"---------------------------------------------------------
nmap <buffer> <F9> :call CompileSQLFile( "DEVCI" )<CR>
nmap <buffer> <S-F9> :call CompileSQLFile( "UATCI" )<CR>
nmap <buffer> <C-F9> :call ChooseEnvironnement( "CompileSQLFile" )<CR>
" Le mapping pour savoir qui est ou n'est pas connect�
"-----------------------------------------------------
nmap <buffer> <F6> :call WhoIsConnected( "DEVCI" )<CR>
nmap <buffer> <S-F6> :call WhoIsConnected( "UATCI" )<CR>
nmap <buffer> <C-F6> :call ChooseEnvironnement( "WhoIsConnected" )<CR>
" Le mapping pour visualiser le fichier de r�sultat
"--------------------------------------------------
execute "nmap <buffer> <F5> :if ( &modified != 0 )<CR>write<CR>endif<CR>:edit! " . g:VM_projectDirShell . "/sqlCommandResult.res<CR>G"
" Pour executer la s�lection
"---------------------------
execute "vmap <buffer> <CR> y:if ( &modified != 0 )<CR>write<CR>endif<CR>:edit! " . g:VM_projectDirShell . "/sqlTempExecute.sql<CR>Go<ESC>p<Up>:1, delete<CR>:call CompileSQLSelection( \"DEVCI\" )<CR>"
execute "vmap <buffer> <S-CR> y:if ( &modified != 0 )<CR>write<CR>endif<CR>:edit! " . g:VM_projectDirShell . "/sqlTempExecute.sql<CR>Go<ESC>p<Up>:1, delete<CR>:call CompileSQLSelection( \"UATCI\" )<CR>"
execute "vmap <buffer> <C-CR> y:if ( &modified != 0 )<CR>write<CR>endif<CR>:edit! " . g:VM_projectDirShell . "/sqlTempExecute.sql<CR>Go<ESC>p<Up>:1, delete<CR>:call ChooseEnvironnement( \"CompileSQLSelection\" )<CR>"
" Pour nettoyer un environnement sp�cifique
"------------------------------------------
nmap <buffer> <S-F8> :call CleanEnvironnement()<CR>
" Variables de gestion de base de donn�es
"----------------------------------------
let VIM_SQLSERVER_DEV = "EQDS1DSQL002\\EXOFRDI1"
let VIM_SQLBASE_DEV = "ExocetStrategies"
let VIM_SQLLOGIN_DEV = "TRUSTED"
let VIM_SQLSERVER_INT = "EQDS1DSQL002\\EXOFRXI1"
let VIM_SQLBASE_INT = "ExocetStrategies"
let VIM_SQLLOGIN_INT = "TRUSTED"
let VIM_SQLSERVER_REC = "EQDS1DSQL002\\EXOFRUI2"
let VIM_SQLBASE_REC = "ExocetStrategies"
let VIM_SQLLOGIN_REC = "TRUSTED"
let VIM_SQLSERVER_UAT = "EQDS1DSQL002\\EXOFRUI1"
let VIM_SQLBASE_UAT = "ExocetStrategies"
let VIM_SQLLOGIN_UAT = "TRUSTED"
let VIM_SQLSERVER_PRD = "GCLSQL001EXO.gaia.net.intra\\EXOFRPI1"
let VIM_SQLBASE_PRD = "ExocetStrategies"
let VIM_SQLLOGIN_PRD = "TRUSTED"
let VIM_SQLSERVER_DEVdbo = "EQDS1DSQL002\\EXOFRDI1"
let VIM_SQLBASE_DEVdbo = "ExocetStrategies"
let VIM_SQLLOGIN_DEVdbo = "Exocet"
let VIM_SQLSERVER_INTdbo = "EQDS1DSQL002\\EXOFRXI1"
let VIM_SQLBASE_INTdbo = "ExocetStrategies"
let VIM_SQLLOGIN_INTdbo = "Exocet"
let VIM_SQLSERVER_RECdbo = "EQDS1DSQL002\\EXOFRUI2"
let VIM_SQLBASE_RECdbo = "ExocetStrategies"
let VIM_SQLLOGIN_RECdbo = "Exocet"
let VIM_SQLSERVER_UATdbo = "EQDS1DSQL002\\EXOFRUI1"
let VIM_SQLBASE_UATdbo = "ExocetStrategies"
let VIM_SQLLOGIN_UATdbo = "Exocet"
let VIM_SQLSERVER_PRDdbo = "GCLSQL001EXO.gaia.net.intra\\EXOFRPI1"
let VIM_SQLBASE_PRDdbo = "ExocetStrategies"
let VIM_SQLLOGIN_PRDdbo = "Exocet"
let VIM_SQLSERVER_DEVweb = "EQDS1DSQL002\\EXOFRDI1"
let VIM_SQLBASE_DEVweb = "ExocetStrategies"
let VIM_SQLLOGIN_DEVweb = "WebExocet"
let VIM_SQLSERVER_INTweb = "EQDS1DSQL002\\EXOFRXI1"
let VIM_SQLBASE_INTweb = "ExocetStrategies"
let VIM_SQLLOGIN_INTweb = "WebExocet"
let VIM_SQLSERVER_RECweb = "EQDS1DSQL002\\EXOFRUI2"
let VIM_SQLBASE_RECweb = "ExocetStrategies"
let VIM_SQLLOGIN_RECweb = "WebExocet"
let VIM_SQLSERVER_UATweb = "EQDS1DSQL002\\EXOFRUI1"
let VIM_SQLBASE_UATweb = "ExocetStrategies"
let VIM_SQLLOGIN_UATweb = "WebExocet"
let VIM_SQLSERVER_PRDweb = "GCLSQL001EXO.gaia.net.intra\\EXOFRPI1"
let VIM_SQLBASE_PRDweb = "ExocetStrategies"
let VIM_SQLLOGIN_PRDweb = "WebExocet"
let VIM_SQLSERVER_DEVexe = "EQDS1DSQL002\\EXOFRDI1"
let VIM_SQLBASE_DEVexe = "ExocetStrategies"
let VIM_SQLLOGIN_DEVexe = "ExecExocet"
let VIM_SQLSERVER_INTexe = "EQDS1DSQL002\\EXOFRXI1"
let VIM_SQLBASE_INTexe = "ExocetStrategies"
let VIM_SQLLOGIN_INTexe = "ExecExocet"
let VIM_SQLSERVER_RECexe = "EQDS1DSQL002\\EXOFRUI2"
let VIM_SQLBASE_RECexe = "ExocetStrategies"
let VIM_SQLLOGIN_RECexe = "ExecExocet"
let VIM_SQLSERVER_UATexe = "EQDS1DSQL002\\EXOFRUI1"
let VIM_SQLBASE_UATexe = "ExocetStrategies"
let VIM_SQLLOGIN_UATexe = "ExecExocet"
let VIM_SQLSERVER_PRDexe = "GCLSQL001EXO.gaia.net.intra\\EXOFRPI1"
let VIM_SQLBASE_PRDexe = "ExocetStrategies"
let VIM_SQLLOGIN_PRDexe = "ExecExocet"
let VIM_SQLSERVER_DEVCI = "par-dbdmzt01.equities.net.intra,1442"
let VIM_SQLBASE_DEVCI = "DAS2"
let VIM_SQLLOGIN_DEVCI = "DAS_admin"
let VIM_SQLPWD_DEVCI = "Kali_D3s"
let VIM_SQLSERVER_UATCI = "par-dbdmzt01.equities.net.intra,1442"
let VIM_SQLBASE_UATCI = "DAS"
let VIM_SQLLOGIN_UATCI = "DAS_admin"
let VIM_SQLPWD_UATCI = "Kali_D3s"
let VIM_SQLSERVER_PRDCI = "zclsql001bab.equities.net.intra,1441"
let VIM_SQLBASE_PRDCI = "DAS"
let VIM_SQLLOGIN_PRDCI = "DAS_admin"
let VIM_SQLPWD_PRDCI = "Kali_D3s"

if ( exists( "*CleanEnvironnement" ) == 0 )

" Fonction : CleanEnvironnement
"
" But : D�truit les variables d'un environnement d'ex�cution, avec la permission
"       de l'utilisateur.
"
" Buffer : 
"    Texte SQL courant
"-------------------------------------------------------------------------------
function CleanEnvironnement()
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useCleanEnvironnement = 0
   " Choix de l'environnement d'ex�cution � d�truire
   "------------------------------------------------
   let envDelete = input( "Environnement � d�truire : " )
   echo "\n"
   if ( envDelete != "" )
      " Pour v�rifier qu'on �tait bien cens� d�truire quelquechose
      "-----------------------------------------------------------
      let envExists = 0
      " Destruction du mot de passe
      "----------------------------
      if ( exists( "g:VIM_SQLPWD_" . envDelete ) != 0 )
         " Signale l'existance de l'environnement courant
         "-----------------------------------------------
         let envExists = 1
         " Confirme la destruction du mot de passe
         "----------------------------------------
         if ( input( "Destruction du mot de passe ( Y/N ) : " ) == "Y" )
            execute "unlet g:VIM_SQLPWD_" . envDelete
         endif
         echo "\n"
      endif
      " Destruction de la base de connexion par d�faut
      "-----------------------------------------------
      if ( exists( "g:VIM_SQLBASE_" . envDelete ) != 0 )
         " Signale l'existance de l'environnement courant
         "-----------------------------------------------
         let envExists = 1
         " Confirme la destruction du nom de la base
         "----------------------------------------
         if ( input( "Destruction du nom de la base ( Y/N ) : " ) == "Y" )
            execute "unlet g:VIM_SQLBASE_" . envDelete
         endif
         echo "\n"
      endif
      " Destruction du nom de connexion
      "--------------------------------
      if ( exists( "g:VIM_SQLLOGIN_" . envDelete ) != 0 )
         " Signale l'existance de l'environnement courant
         "-----------------------------------------------
         let envExists = 1
         " Confirme la destruction du nom de connexion
         "--------------------------------------------
         if ( input( "Destruction du nom de connexion ( Y/N ) : " ) == "Y" )
            execute "unlet g:VIM_SQLLOGIN_" . envDelete
         endif
         echo "\n"
      endif
      " Destruction du nom du serveur � utiliser
      "-----------------------------------------
      if ( exists( "g:VIM_SQLSERVER_" . envDelete ) != 0 )
         " Signale l'existance de l'environnement courant
         "-----------------------------------------------
         let envExists = 1
         " Confirme la destruction du serveur � utiliser
         "----------------------------------------------
         if ( input( "Destruction du serveur � utiliser ( Y/N ) : " ) == "Y" )
            execute "unlet g:VIM_SQLSERVER_" . envDelete
         endif
         echo "\n"
      endif
      " V�rification de l'environnement utilis�
      "----------------------------------------
      if ( envExists == 0 )
         echo "L'environnement s�lectionn� n'existe pas !!!\n"
      endif
   endif
   unlet g:useCleanEnvironnement
endfunction

endif

if ( exists( "*ChooseEnvironnement" ) == 0 )

" Fonction : ChooseEnvironnement
"
" But : Choisi l'environnement d'ex�cution de l'ordre SQL courant
"
" Buffer : 
"    Texte SQL courant.
" Parametres :
"    fctToCall - fonction � appeler apr�s avoir s�lectionn� l'environnement d'ex�cution
"-------------------------------------------------------------------------------
function ChooseEnvironnement( fctToCall )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useChooseEnvironnement = 0
   " Choix de l'environnement d'ex�cution � utiliser
   "------------------------------------------------
   let envExec = input( "Environnement � utiliser : " )
   echo "\n"
   if ( envExec != "" )
      " Lancement de l'ex�cution qui va bien
      "-------------------------------------
      execute "call " . a:fctToCall . "( \"" . envExec . "\" )"
   endif
   unlet g:useChooseEnvironnement
endfunction

endif

" Fonctions d'ex�cutions de commandes
"------------------------------------
if ( exists( "*CompileSQLSelection" ) == 0 )

" Fonction : CompileSQLSelection
"
" But : Execute la s�lection plac�e dans le fichier temporaire courant.
"
" Buffer : 
"    # - Buffer d'origine de la commande a ex�cuter
" Parametres :
"    environnement - environnement d'ex�cution ( DEV ou PROD, ou autre... )
"                    ce param�tre compl�te les variables VIM_SQLxxx_
"                    pour r�cup�rer l'environnement sur lequel on veut compiler
"-------------------------------------------------------------------------------
function CompileSQLSelection( environnement )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useCompileSQLSelection = 0
   " Sauvegarde du fichier a ex�cuter
   "---------------------------------
   write!
   " R�cup�ration du d�but de l'ordre d'ex�cution
   "---------------------------------------------
   let orderCmd = GetConnexionInfo( a:environnement )
   if ( orderCmd != "0" )
      " Le fabrication de la commande s'est bien d�roul�e
      "--------------------------------------------------
      let orderCmd = orderCmd . g:SQLOptionExecFile . " \"" . expand( "%:p" ) . "\""
      buffer! #
      call ExecuteSQLCommand( orderCmd, a:environnement )
   else
      echo "Error while inputing the command definition"
   endif
   unlet g:useCompileSQLSelection
endfunction

endif

if ( exists( "*ExecuteSQLCommand" ) == 0 )

" Fonction : ExecuteSQLCommand
"
" But : Ex�cute la commande SQL dans le fichier r�sultat
"
" Parametres :
"    comand - Commnde SQL � ex�cuter
"    environnement - environnement d'ex�cution ( DEV ou PROD, ou autre... )
"                    ce param�tre compl�te les variables VIM_SQLxxx_
"                    pour r�cup�rer l'environnement sur lequel on veut compiler
"-------------------------------------------------------------------------------
function ExecuteSQLCommand( command, environnement )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useExecuteSQLCommand = 0
   " R�cup�ration des param�tres de connexion
   "-----------------------------------------
   execute "let nameSQLServer = g:VIM_SQLSERVER_" . a:environnement
   execute "let nameSQLBase = g:VIM_SQLBASE_" . a:environnement
   execute "let nameSQLLogin = g:VIM_SQLLOGIN_" . a:environnement
   " Je me d�place dans le nouveau fichier pour ex�cuter la commande
   "----------------------------------------------------------------
   execute "edit! " . g:VM_projectDirShell . "/sqlCommandResult.res"
   call append( line( "$" ), "COMMAND (" . nameSQLLogin . "@" . nameSQLServer . " : " . nameSQLBase . ") > " . substitute( a:command, "[^\"]*", "", "" ) )
   call append( line( "$" ), "********************************************************************" )
   call append( line( "$" ), "" )
   $
   call system( a:command )
   substitute /^.*> //e
   " Je suis oblig� de manipuler moi-m�me le fold level sinon, VIM ne s'y retrouve pas...
   "-------------------------------------------------------------------------------------
   let g:globalFoldValue = 0
   " Termine le marquage de la commande
   "-----------------------------------
   call append( line( "$" ), "********************************************************************" )
   call append( line( "$" ), "" )
   $
   write
   unlet g:useExecuteSQLCommand
endfunction

endif

if ( exists( "*WhoIsConnected" ) == 0 )

" Fonction : WhoIsConnected
"
" But : Liste les personnes connect�es
"
" Parametres :
"    environnement - environnement d'ex�cution ( DEV ou PROD, ou autre... )
"                    ce param�tre compl�te les variables VIM_SQLxxx_
"                    pour r�cup�rer l'environnement sur lequel on veut compiler
"-------------------------------------------------------------------------------
function WhoIsConnected( environnement )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useWhoIsConnected = 0
   " R�cup�ration du d�but de l'ordre d'ex�cution
   "---------------------------------------------
   let orderCmd = GetConnexionInfo( a:environnement )
   if ( orderCmd != "0" )
      " Le fabrication de la commande s'est bien d�roul�e
      "--------------------------------------------------
      call ExecuteSQLCommand( orderCmd . " -Q \"exec sp_lock;exec sp_who\"", a:environnement )
   endif
   unlet g:useWhoIsConnected
endfunction

endif

if ( exists( "*CompileSQLFile" ) == 0 )

" Fonction : CompileSQLFile
"
" But : Compile le fichier courant dans l'environnement pass� en param�tre.
"
" Buffer : 
"    courant
" Parametres :
"    environnement - environnement d'ex�cution ( DEV ou PROD, ou autre... )
"                    ce param�tre compl�te les variables VIM_SQLxxx_
"                    pour r�cup�rer l'environnement sur lequel on veut compiler
"-------------------------------------------------------------------------------
function CompileSQLFile( environnement )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useCompileSQLFile = 0
   " Teste de la possibilite de compiler le bon fichier
   "---------------------------------------------------
   if ( &modified != 0 )
      let saveTheFile = input( "Le fichier n'est pas sauver voulez vous le sauver ( Y/N ) : " )
      echo "\n"
      if ( saveTheFile == "Y" )
         write!
      else
         let saveTheFile = input( "ATTENTION : vous allez compiler la derni�re version sauvegard�e du fichier et peut-�tre perdre cette version, continuer ( Y/N ) : " )
         if ( saveTheFile != "Y" )
            unlet g:useCompileSQLFile
            return
         endif
      endif
   endif
   " R�cup�ration du d�but de l'ordre d'ex�cution
   "---------------------------------------------
   let orderCmd = GetConnexionInfo( a:environnement )
   if ( orderCmd != "0" )
      " Le fabrication de la commande s'est bien d�roul�e
      "--------------------------------------------------
      call ExecuteSQLCommand( orderCmd . " -i \"" . expand( "%:p" ) . "\"", a:environnement )
   endif
   unlet g:useCompileSQLFile
endfunction

endif

if ( exists( "*GetConnexionInfo" ) == 0 )

" Fonction : GetConnexionInfo
"
" But : R�cup�re la chaine de carac�tre correspondant � la commande pour
"       l'ex�cution du fichier sur le serveur SQL.
"
" Buffer : 
"    courant
" Parametres :
"    environnement - environnement d'ex�cution ( DEV ou PROD, ou autre... )
"                    ce param�tre compl�te les variables VIM_SQLxxx_
"                    pour r�cup�rer l'environnement sur lequel on veut compiler
" Retour :
"    Chaine de commande � ex�cuter
"-------------------------------------------------------------------------------
function GetConnexionInfo( environnement )
   " Pour �viter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useGetConnexionInfo = 0
   " Initialisation des variables de connexion
   "------------------------------------------
   let varNameSQLServer = "g:VIM_SQLSERVER_" . a:environnement
   let varNameSQLBase = "g:VIM_SQLBASE_" . a:environnement
   let varNameSQLLogin = "g:VIM_SQLLOGIN_" . a:environnement
   let varNameSQLPwd = "g:VIM_SQLPWD_" . a:environnement
   " teste la validit� des variables saisies :
   " le login et le server ne doivent pas �tre vide
   "-----------------------------------------------
   let evryThingOK = exists( varNameSQLServer )
   if ( evryThingOK == 0 )
      " Le server ne peut pas �tre vide
      "--------------------------------
      echo "Le serveur SQL doit �tre renseign�!!\n"
      execute "let " . varNameSQLServer . " = input( \"SQL server : \" )"
      echo "\n"
   else
      " Lis le nom du server SQL que l'on va utiliser
      "----------------------------------------------
      execute "let sqlServer = " . varNameSQLServer
      if ( sqlServer == "" )
         " Le server ne peut pas �tre vide
         "--------------------------------
         echo "Le serveur SQL ne doit pas �tre vide\n"
         execute "let " . varNameSQLServer . " = input( \"SQL server : \" )"
         echo "\n"
      endif
   endif
   " Lis le nom du server SQL que l'on va utiliser
   "----------------------------------------------
   execute "let sqlServer = " . varNameSQLServer
   let evryThingOK = ( sqlServer != "" )
   if ( evryThingOK != 0 )
      let evryThingOK = exists( varNameSQLBase )
      if ( evryThingOK == 0 )
         " Ressaisi le login : il ne doit pas �tre vide
         "---------------------------------------------
         echo "Le login doit �tre renseign�!!\n"
         execute "let " . varNameSQLLogin . " = input( \"SQL login : \" )"
         echo "\n"
      endif
   endif
   " Lis le nom de login saisi
   "--------------------------
   execute "let sqlLogin = " . varNameSQLLogin
   let evryThingOK = ( sqlLogin != "" )
   " C'est tout bon, on peut compiler le fichier courant
   "----------------------------------------------------
   if ( evryThingOK != 0 )
      " Affichage de l'environnement de compilation
      "--------------------------------------------
      echo "Environnement de compilation : " . a:environnement
      echo "--------------------------------------------------"
      echo " Server   : " . sqlServer
      echo " Login    : " . sqlLogin
      " Teste l'existance des deux derni�res variables
      "-----------------------------------------------
      if ( exists( varNameSQLBase ) == 0 )
         execute "let " . varNameSQLBase . " = input( \"Base de d�marrage : \" )"
         echo "\n"
      endif
      " R�cup�ration et affichage des variables
      "----------------------------------------
      execute "let sqlBase = " . varNameSQLBase
      if ( sqlBase == "" )
         echo " Base     : <Defaut>"
      else
         echo " Base     : " . sqlBase
         let sqlBase = " -d " . sqlBase
      endif
      if ( exists( varNameSQLPwd ) == 0 )
         if ( sqlLogin != "TRUSTED" )
            execute "let " . varNameSQLPwd . " = input( \"Mot de passe : \" )"
            echo "\n"
         else
            execute "let " . varNameSQLPwd . " = \"\""
         endif
      endif
      " R�cup�re les valeurs des variables
      "-----------------------------------
      execute "let sqlPwd = " . varNameSQLPwd
      if ( sqlPwd == "" )
         echo " Password : <Aucun>\n"
      else
         echo " Password : *********\n"
         let sqlPwd = " -P \"" . sqlPwd . "\""
      endif
      " Calcul le login exact
      "----------------------
      if ( ( sqlLogin == "TRUSTED" )&&( sqlPwd == "" ) )
         let sqlLogin = " -E "
      else
         let sqlLogin = " -U " . sqlLogin
      endif
      " Ex�cution d'isql pour compiler le fichier
      "------------------------------------------
      let evryThingOK = g:SQLCommand . " " . sqlServer . sqlLogin . sqlBase . sqlPwd
   endif
   unlet g:useGetConnexionInfo
   return evryThingOK
endfunction

endif

" Define the command to use
"--------------------------
if ( exists( "g:SQLCommand" ) == 0 )
   let g:SQLCommand = "echo"
endif

if ( exists( "g:SQLOptionExecFile" ) == 0 )
   let g:SQLOptionExecFile = " -i"
endif

" Mapping pour ne plus utiliser d'accents
"----------------------------------------
imap <buffer> � e
vmap <buffer> � e
omap <buffer> � e
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � c
omap <buffer> � c
vmap <buffer> � c
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � i
omap <buffer> � i
vmap <buffer> � i
imap <buffer> � i
omap <buffer> � i
vmap <buffer> � i
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u
imap <buffer> � o
omap <buffer> � o
vmap <buffer> � o
imap <buffer> � o
omap <buffer> � o
vmap <buffer> � o
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour d�clancher/arr�ter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <C-F6> :setlocal foldmethod=indent<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>:setlocal foldcolumn=0<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldmethod=indent
      setlocal foldenable

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

