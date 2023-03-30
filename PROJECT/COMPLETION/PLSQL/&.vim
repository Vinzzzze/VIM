" Fichier : #.vim
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

call inputsave()
let s:columnName = input( "Column name : " )
let s:columnComment = input( "Column comment : " )
call inputrestore()

let s:currentLineNum = line( "." )
let s:currentLine = getline( s:currentLineNum )
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )

call setline( s:currentLineNum, s:currentIndent . "\"" . s:columnName . "\"	<@COLUMN_TYPE@>		NOT NULL," )
call append( line( "$" ) - 3, "COMMENT ON COLUMN \"" . expand( "%:p:h:t" ) . "\".\"" . expand( "%:t:r" ) . "\".\"" . s:columnName . "\" IS '" . s:columnComment . "';" )

"---< Fin de fichier >----------------------------------------------------------

