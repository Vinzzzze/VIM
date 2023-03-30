" Fichier : termCMapping-xterm.vim
"
" But : The mapping C for the rxvt file.
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

if ( expand( "%:e" ) == "c" )
   nmap <buffer> <S-F8> :call CCompleteOpen()<CR>
else
   nmap <buffer> <S-F8> :call COpenAlternate( "vsplit", "" )<CR>
endif

nmap <buffer> <C-F8> :call COpenAlternate( "split", "" )<CR>
nmap <buffer> <M-F8> :call COpenAlternate( "edit", "" )<CR>

"---< Fin de fichier >----------------------------------------------------------

