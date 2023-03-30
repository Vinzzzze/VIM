" Fichier : IN.vim
"
" But : How the IN command had to be completed.
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
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@VALUE_LIST@>" )
call append( s:currentLineNum, s:currentIndent . "(" )

"---< Fin de fichier >----------------------------------------------------------

