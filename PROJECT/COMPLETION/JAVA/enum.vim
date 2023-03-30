" Fichier : enum.vim
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
call append( s:currentLineNum, s:currentIndent . "}," )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@ENUM_DEFINITION@>" )
call append( s:currentLineNum, s:currentIndent . "<@ENUM_NAME@>(<@ENUM_PARAMETERS@>) {" )
call append( s:currentLineNum, s:currentIndent . " */" )
call append( s:currentLineNum, s:currentIndent . " * <@ENUM_COMMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

