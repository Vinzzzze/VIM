" Fichier : else.vim
"
" But : How the else command can be completed
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 déc. 2013
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

call setline( s:currentLineNum, s:currentLine . " (<@EXCEPTION_TYPE@>) {" )
call append( s:currentLineNum, s:currentIndent . "}" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@EXCEPTION_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

