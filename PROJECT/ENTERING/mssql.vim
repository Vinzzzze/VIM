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

" Pour la cr�ation des d�but et fin de bloc
"------------------------------------------
imap <buffer> <C-M-{> BEGIN<cr>END -- <esc>O<tab>
" Le mapping pour savoir qui est ou n'est pas connect�
"-----------------------------------------------------
nmap <buffer> <F6> :call WhoIsConnected( "DEV" )<CR>
nmap <buffer> <S-F6> :call WhoIsConnected( "UAT" )<CR>
nmap <buffer> <C-F6> :call ChooseEnvironnement( "WhoIsConnected" )<CR>

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

" Define the command to use
"--------------------------
if ( exists( "g:SQLCommand" ) == 0 )
   let g:SQLCommand = "C:\\Progra~1\\MICROS~2\\100\\Tools\\Binn\\osql.exe -n -w 8192 -S"
endif

if ( exists( "g:SQLOptionExecFile" ) == 0 )
   let g:SQLOptionExecFile = " -i"
endif

if ( exists( "g:SQLTrustedLogin" ) == 0 )
   let g:SQLTrustedLogin = " -E "
endif

call VM_ProjectExecuteEnteringFile( "db_base" )

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

"---< Fin de fichier >----------------------------------------------------------

