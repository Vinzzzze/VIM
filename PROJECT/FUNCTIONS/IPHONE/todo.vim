" Fichier : todo.vim
"
" But : D�finition des settings des fichiers de syntaxe todo
"
" Auteur : Vini "Cool Coyote"
" Date : 10 Sep 2013
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

" Mapping sur les gestion de t�ches
"----------------------------------
nmap <buffer> <CR> :call TD_OpenFileTask( expand( "<cWORD>" ) )<CR>
nmap <buffer> � :only<CR>:tabonly<CR>
nmap <buffer> <C-J> :tabnew<CR>:Explore<CR>
nmap <buffer> � :tabnew<CR>:tjump 

"---< Fin de fichier >----------------------------------------------------------

