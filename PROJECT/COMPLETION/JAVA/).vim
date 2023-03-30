" Fichier : §.vim
"
" But : Expand the commmand definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 déc. 2013
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

call setline( s:currentLineNum, s:currentIndent . "/**" )
call append( s:currentLineNum, s:currentIndent . " */" )
call append( s:currentLineNum, s:currentIndent . " * <@COMMENT_TEXT@>" )

"---< Fin de fichier >----------------------------------------------------------

