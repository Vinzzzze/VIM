" Fichier : EXISTS.vim
"
" But : How the EXISTS command had to be completed.
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

call append( s:currentLineNum, s:currentIndent . ")" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . g:SQL_projectIndentation . "<@CONDITION_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "WHERE" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . g:SQL_projectIndentation . "<@TABLE_LIST@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "FROM" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . g:SQL_projectIndentation . "1" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "SELECT" )
call append( s:currentLineNum, s:currentIndent . "(" )

"---< Fin de fichier >----------------------------------------------------------

