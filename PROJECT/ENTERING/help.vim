" Fichier : setting_help.vim
"
" But : Définition des settings à utiliser dans les fichiers d'aide
"
" Auteur : Vini "Cool Coyote" - coolcoyote@club-internet.fr
" Date : 25/10/2001
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

" Pour la navigation dans les fichiers d'aide
"--------------------------------------------
nmap <buffer> <F1> <C-]>
nmap <buffer> <S-F1> :pop<CR>
nmap <buffer> <C-F1> :tnext<CR>
" Pour la détermination de l'espacement des fichiers d'aide
"----------------------------------------------------------
setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab

"---< Fin de fichier >----------------------------------------------------------

