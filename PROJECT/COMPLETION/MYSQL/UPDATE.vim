" Fichier : UPDATE.vim
"
" But : How the UPDATE command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 11 d�c. 2013
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

call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@CONDITION_STATEMENT@>;" )
call append( s:currentLineNum, s:currentIndent . "WHERE" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@COLUMN_SET@>" )
call append( s:currentLineNum, s:currentIndent . "SET" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@TABLE_LIST@>" )

"---< Fin de fichier >----------------------------------------------------------

