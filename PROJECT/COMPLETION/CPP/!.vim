" Fichier : !.vim
"
" But : Build an attribute comment
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 d�c. 2013
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

call setline( s:currentLineNum, s:currentIndent . "/** <@ATTRIBUTE_DESCRIPTION@>" )
call append( s:currentLineNum, s:currentIndent . "<@ATTRIBUTE_CODE@>" )
call append( s:currentLineNum, s:currentIndent . "*/" )

"---< Fin de fichier >----------------------------------------------------------

