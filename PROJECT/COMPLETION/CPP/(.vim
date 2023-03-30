" Fichier : #.vim
"
" But : Start a constant char
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 02 janv. 2014
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

let s:currentLineNum = line( "." )
let s:currentColNum = col( "." )
let s:currentLine = getline( s:currentLineNum )
call setline( s:currentLineNum, strpart( s:currentLine, 0, s:currentColNum - 1 ) . "VM_CONST_CHAR'<@CHAR@>'" . strpart( s:currentLine, s:currentColNum ) )

"---< Fin de fichier >----------------------------------------------------------

