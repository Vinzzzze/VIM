" Fichier : setting_aspvbs.vim
"
" But : Setting pour les fichiers ASP.
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

" Définition spéciale pour les réalisation sous windaube
"-------------------------------------------------------
if ( g:VIM_REP_SEPARATOR == "\\" )
   " Définition des sauvegardes ASP : 
   "    ..._FILENAME : Chaine à trouver dans le nom complet du fichier d'origine
   "    ..._DESTREP : Chaine de remplacement dans le nom du fichier d'origine
   "----------------------------------------------------------------------------
   let VIM_IIS_FILENAME = "^.*\\<ASP\\>"
   let VIM_IIS_DESTREP = "C:/Inetpub/wwwroot/Exocet"
endif
" Pour la création de fonctions
"------------------------------
nmap <buffer> <F6> :write!<CR>
nmap <buffer> <S-F6> :write!<CR>:echo "Fichier de publication : " . substitute( expand( "%:p" ), VIM_IIS_FILENAME, VIM_IIS_DESTREP, "" ) . "\n"<CR>:execute "write! " . substitute( expand( "%:p" ), VIM_IIS_FILENAME, VIM_IIS_DESTREP, "" )<CR><CR>
" Redéfinition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4

"---< Fin de fichier >----------------------------------------------------------

