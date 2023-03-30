" Fichier : INDEX.vim
"
" But : How the CREATE INDEX command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 17 juin 2014
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
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )

call setline( s:currentLineNum, s:currentIndent . "INDEX `" . expand( "%:t:r" ) . "_<@INDEX_NAME@>` USING HASH" )
call append( s:currentLineNum, s:currentIndent . ")" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "`<@COLUMN_NAME@>`" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "`<@COLUMN_NAME@>`," )
call append( s:currentLineNum, s:currentIndent . "(" )

"---< Fin de fichier >----------------------------------------------------------

