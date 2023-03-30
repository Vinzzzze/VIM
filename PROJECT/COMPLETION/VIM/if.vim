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

call setline( s:currentLineNum, s:currentLine . " ( <@COND_VALUE@> )" )
call append( s:currentLineNum, s:currentIndent . "endif \" End IF <@COND_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@COND_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

