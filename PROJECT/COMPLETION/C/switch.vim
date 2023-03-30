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

call setline( s:currentLineNum, s:currentLine . " ( <@VARIABLE_NAME@> )" )
call append( s:currentLineNum, s:currentIndent . "} /* End SWITCH <@SWITCH_EXPLAIN@> */" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "break;" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "<@DEFAULT_STATEMENT@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "default:" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "break;" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "<@CASE_STATEMENT@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "case <@CASE_VALUE@>:" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

