" Fichier : case.vim
"
" But : How the case command had to be completed.
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

call setline( s:currentLineNum, s:currentLine . " <@CASE_VALUE@>:" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "break;" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@CASE_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

