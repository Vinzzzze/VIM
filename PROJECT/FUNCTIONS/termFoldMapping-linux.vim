" Fichier : termFoldMapping-rxvt-unicode-256color.vim
"
" But : The mapping CPP for the rxvt file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 20 mars 2021
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

if ( exists( "g:VM_debugModeActive" ) == 0 )
   nmap <buffer> <F18> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
   nmap <buffer> <Tab><F6> :setlocal nofoldenable<CR>
endif " End IF the debug mode is not active

"---< Fin de fichier >----------------------------------------------------------

