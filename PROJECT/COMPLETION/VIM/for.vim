" Fichier : for.vim
"
" But : Expand the for instruction
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 18 Jan 2018
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

call setline( s:currentLineNum, s:currentLine . " <@ELEMENT_VAR@> in <@LIST_VAR@>" )
call append( s:currentLineNum, s:currentIndent . "endfor \" End FOR <@COND_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@FOR_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

