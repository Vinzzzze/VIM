" Fichier : termCMapping-rxvt-unicode-256color.vim
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
   nmap <buffer> <Esc>[32~ :call CCompleteOpen()<CR>
else
   nmap <buffer> <Esc>[32~ :call COpenAlternate( "vsplit", "" )<CR>
endif

nmap <buffer> <Esc>[19~ :call COpenAlternate( "split", "" )<CR>

"---< Fin de fichier >----------------------------------------------------------

