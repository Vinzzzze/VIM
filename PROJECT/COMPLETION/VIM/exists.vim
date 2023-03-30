" Fichier : exists.vim
"
" But : How the exists function is completed
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 17 Jan 2018
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
let s:currentLine = getline( s:currentLineNum )
let s:currentColNum = col( "." )
let s:endLine = strpart( s:currentLine, s:currentColNum )
let s:currentLine = strpart( s:currentLine, 0, s:currentColNum )
let s:startLine = s:currentLine

call setline( s:currentLineNum, s:currentLine . "( \"<@VALUE_TEST@>\" ) <@COND_TEST@>= 0" . s:endLine )

"---< Fin de fichier >----------------------------------------------------------

