" Fichier : mysql.vim
"
" But : The mySQL entering command.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 03 févr. 2015
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

" C'est plus joli les fichiers au format unix
"--------------------------------------------
setlocal fileformat=unix
setlocal fileencoding=utf-8
setlocal encoding=utf-8
" Definition de la base
"----------------------
let g:VIM_SQLSERVER_DEV = "localhost"
let g:VIM_SQLBASE_DEV = ""
let g:VIM_SQLLOGIN_DEV = "coolcoyote"
let g:VIM_SQLPWD_DEV = "lpzq650!"

" Mapping de définition de variable
"----------------------------------
imap <S-Esc> <Esc><Down><S-CR><Esc>F<.<S-CR>

" Define the command to use
"--------------------------
let g:SQLCommand = g:MYSQL_SQLCommand
let g:SQLOptionExecFile = " <"
let g:SQLTrustedLogin = " --password=lpzq650!"
let g:SQLOptionServer = "-h "
let g:SQLOptionPassword = "--password="
let g:SQLOptionLogin = "-u "

call VM_ProjectExecuteEnteringFile( "db_base" )

"---< Fin de fichier >----------------------------------------------------------

