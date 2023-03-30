" Fichier : if.vim
"
" But : How the if command had to be completed.
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

call setline( s:currentLineNum, s:currentLine . "/**" )
call append( s:currentLineNum, s:currentIndent . "}" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@CLASS_DEFINITION@>" )
call append( s:currentLineNum, s:currentIndent . "class <@CLASS_NAME_AND_HERITANCE@> {" )
call append( s:currentLineNum, s:currentIndent . " */" )
call append( s:currentLineNum, s:currentIndent . " * <@CLASS_COMMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

