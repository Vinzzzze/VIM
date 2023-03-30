" Fichier : setting_plsql.vim
"
" But : Définition des settings des fichiers de syntaxe PL/SQL.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
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

" Mapping de définition de variable
"----------------------------------
if ( exists( "g:VM_terminalUsage" ) != 0 )
   imap › <Esc><Down><S-CR><Esc>F<.<S-CR>
else " End IF we are running on a terminal
   imap <S-Esc> <Esc><Down><S-CR><Esc>F<.<S-CR>
endif " End IF we are running on a graphical terminal


" Define the command to use
"--------------------------
if ( exists( "g:POSTGRE_SQLCommand" ) != 0 )
   " Definition de la base
   "----------------------
   let g:VIM_SQLSERVER_DEV = "doom -p 5533"
   let g:VIM_SQLBASE_DEV = "Configuration"
   let g:VIM_SQLLOGIN_DEV = "kameleon_dbo"
   let g:VIM_SQLPWD_DEV = ""

   let g:SQLCommand = g:POSTGRE_SQLCommand
   let g:SQLOptionExecFile = " -f"
   let g:SQLTrustedLogin = " -w "
endif

call VM_ProjectExecuteEnteringFile( "db_base" )

"---< Fin de fichier >----------------------------------------------------------

