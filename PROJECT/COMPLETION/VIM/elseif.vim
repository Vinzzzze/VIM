" Fichier : elseif.vim
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

call setline( s:currentLineNum, s:currentLine . " ( <@COND_VALUE@> )" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@ELSE_STATEMENT@>" )
call append( s:currentLineNum - 1, s:currentIndent . "\" End IF <@COND_EXPLAIN@>" )

"---< Fin de fichier >----------------------------------------------------------

