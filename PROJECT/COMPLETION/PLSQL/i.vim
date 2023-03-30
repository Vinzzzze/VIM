" Fichier : i.vim
"
" But : Use the integer type
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 21 juin 2014
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
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )
call setline( s:currentLineNum, strpart( s:currentLine, 0, s:currentColNum - 1 ) . "integer" . strpart( s:currentLine, s:currentColNum ) )
call append( s:currentLineNum, s:currentIndent . "&<@COLUMN_DEFINITION@>" )

"---< Fin de fichier >----------------------------------------------------------

