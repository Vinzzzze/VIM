" Fichier : defaultMapping.vim
"
" But : The default mapping when moving to a new file.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 01 May 2023
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

execute "nmap " . nr2char( 167 ) . " :q<CR>"
" Pour la conversion des dates excel
"-----------------------------------
nmap <C-K> :echo "Date : " . VM_ProjectCalculExcelDate( expand( "<cword>" ) )<CR>
" Pour passer en mode explorer
"-----------------------------
nmap <C-J> :Explore<CR>

"---< Fin de fichier >----------------------------------------------------------

