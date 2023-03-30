" Fichier : switch.vim
"
" But : How the switch command had to be completed.
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

call setline( s:currentLineNum, s:currentLine . " (<@VARIABLE_NAME@>) {" )
call append( s:currentLineNum, s:currentIndent . "}" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "break;" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@DEFAULT_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "default:" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "break;" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@CASE_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "case <@CASE_VALUE@>:" )

"---< Fin de fichier >----------------------------------------------------------

