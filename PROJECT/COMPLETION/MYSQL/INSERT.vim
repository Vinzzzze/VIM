" Fichier : INSERT.vim
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
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )

call setline( s:currentLineNum, s:currentLine . " INTO `<@TABLE_SCHEMA@>`.`<@TABLE_NAME@>`" )
call append( s:currentLineNum, s:currentIndent . ")" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "`<@COLUMN_NAME@>`" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "`<@COLUMN_NAME@>`," )
call append( s:currentLineNum, s:currentIndent . "(" )

"---< Fin de fichier >----------------------------------------------------------

