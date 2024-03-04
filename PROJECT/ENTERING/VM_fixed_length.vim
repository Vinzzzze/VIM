" Fichier : VM_fixed_length.vim
"
" But : The fixed length buffer entering
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

setlocal cursorcolumn

nmap <buffer> <F2> :call VM_OpenColumnWindow( "" )<CR>
nmap <buffer> <F3> :call VM_OpenColumnWindow( "search" )<CR>
nmap <buffer> <S-F2> :call VM_FixedLengthLastUsedColumn()<CR>
nmap <buffer> <S-F3> :call VM_FixedLengthGotoColStart()<CR>ma:call VM_FixedLengthGotoColEnd()<CR><C-V>`a
nmap <buffer> <S-Left> :call VM_FixedLengthPreviousColumn()<CR>
nmap <buffer> <S-Right> :call VM_FixedLengthNextColumn()<CR>

"---< Fin de fichier >----------------------------------------------------------

