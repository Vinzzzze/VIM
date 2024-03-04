" Fichier : VM_fixed_length_column_internal.vim
"
" But : Entering in the column list of a fixed length file
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 14 Jan 2020
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

set nomodified

setlocal winfixwidth
setlocal cursorline
setlocal nomodifiable
setlocal readonly

mapclear

let g:VM_searchedText = ""
let g:VM_searchedIntro = ""

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> § :close<CR>
   nmap <buffer> Â§ :close<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
endif " End IF we are using a gui version

call VM_AutoSearchMapping()

nmap <buffer> <CR> :call VM_FixedLengthActionExec()<CR>

"---< Fin de fichier >----------------------------------------------------------

