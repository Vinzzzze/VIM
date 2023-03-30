" Fichier : setting_sql.vim
"
" But : Setting pour les fichiers de Transact-SQL.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Ajout de la fonction de choix de l'environnement SQL d'exécution. Modification
"    du mapping en conséquence.
"    Ajout de la fonction d'élimination d'un evironnement particulier. Modification
"    du mapping en conséquence
"--------------------------
" Modify : VM - 29 Oct 2001
"    Ajout du mapping des touches pour éviter l'utilisation des accents.
"--------------------------
" Modify : VM - 23 May 2002
"    Ajout du server WEB, élimination du comptage des lignes lors de l'exécution de la commande isql
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

" Pour la création des début et fin de bloc
"------------------------------------------
imap <buffer> <C-M-{> BEGIN<cr>END -- <esc>O<tab>
" Le mapping pour savoir qui est ou n'est pas connecté
"-----------------------------------------------------
nmap <buffer> <F6> :call WhoIsConnected( "DEV" )<CR>
nmap <buffer> <S-F6> :call WhoIsConnected( "UAT" )<CR>
nmap <buffer> <C-F6> :call ChooseEnvironnement( "WhoIsConnected" )<CR>

if ( exists( "*WhoIsConnected" ) == 0 )

" Fonction : WhoIsConnected
"
" But : Liste les personnes connectées
"
" Parametres :
"    environnement - environnement d'exécution ( DEV ou PROD, ou autre... )
"                    ce paramètre complète les variables VIM_SQLxxx_
"                    pour récupérer l'environnement sur lequel on veut compiler
"-------------------------------------------------------------------------------
function WhoIsConnected( environnement )
   " Pour éviter la destruction malencontreuse de la fonction alors qu'elle est en cours d'utilisation
   "--------------------------------------------------------------------------------------------------
   let g:useWhoIsConnected = 0
   " Récupération du début de l'ordre d'exécution
   "---------------------------------------------
   let orderCmd = GetConnexionInfo( a:environnement )
   if ( orderCmd != "0" )
      " Le fabrication de la commande s'est bien déroulée
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
imap <buffer> é e
vmap <buffer> é e
omap <buffer> é e
imap <buffer> è e
omap <buffer> è e
vmap <buffer> è e
imap <buffer> ç c
omap <buffer> ç c
vmap <buffer> ç c
imap <buffer> à a
omap <buffer> à a
vmap <buffer> à a
imap <buffer> ä a
omap <buffer> ä a
vmap <buffer> ä a
imap <buffer> â a
omap <buffer> â a
vmap <buffer> â a
imap <buffer> ë e
omap <buffer> ë e
vmap <buffer> ë e
imap <buffer> ê e
omap <buffer> ê e
vmap <buffer> ê e
imap <buffer> ï i
omap <buffer> ï i
vmap <buffer> ï i
imap <buffer> î i
omap <buffer> î i
vmap <buffer> î i
imap <buffer> ü u
omap <buffer> ü u
vmap <buffer> ü u
imap <buffer> û u
omap <buffer> û u
vmap <buffer> û u
imap <buffer> ö o
omap <buffer> ö o
vmap <buffer> ö o
imap <buffer> ô o
omap <buffer> ô o
vmap <buffer> ô o
imap <buffer> ù u
omap <buffer> ù u
vmap <buffer> ù u

"---< Fin de fichier >----------------------------------------------------------

