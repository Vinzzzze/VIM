" Fichier : function.vim
"
" But : Build function description
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 11 févr. 2016
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

let s:currentLineNum = line( "." )
let s:currentLine = getline( s:currentLineNum )
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )

call setline( s:currentLineNum, s:currentIndent . "/**" )
call append( s:currentLineNum, s:currentIndent . "}" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "return <@RET_VALUE@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "{" )
call append( s:currentLineNum, s:currentIndent . "function <@FUNCTION_NAME@>(<@PARAM_DEFINITION@>)" )
call append( s:currentLineNum, s:currentIndent . " */" )
call append( s:currentLineNum, s:currentIndent . " * @return <@RETURN_DESCRIPTION@>" )
call append( s:currentLineNum, s:currentIndent . " *" )
call append( s:currentLineNum, s:currentIndent . " * @param <@PARAM_DESCRIPTION@>" )
call append( s:currentLineNum, s:currentIndent . " *" )
call append( s:currentLineNum, s:currentIndent . " * <@FUNCTION_DESCRIPTION@>" )

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

"---< Fin de fichier >----------------------------------------------------------

