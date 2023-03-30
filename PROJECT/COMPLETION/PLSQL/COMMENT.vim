" Fichier : COMMENT.vim
"
" But : How the INSERT command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 11 déc. 2013
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

call setline( s:currentLineNum, s:currentLine . " ON COLUMN \"" . expand( "%:p:h:t" ) . "\".\"" . expand( "%:t:r" ) . "\".\"<@COLUMN_NAME@>\" IS '<@COMMENT@>';" )

"---< Fin de fichier >----------------------------------------------------------

