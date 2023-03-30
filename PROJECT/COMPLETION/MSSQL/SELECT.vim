" Fichier : SELECT.vim
"
" But : How the SELECT command had to be completed.
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
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )

call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@CONDITION_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "WHERE" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@TABLE_LIST@>" )
call append( s:currentLineNum, s:currentIndent . "FROM" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@COLUMN_LIST@>" )

"---< Fin de fichier >----------------------------------------------------------

