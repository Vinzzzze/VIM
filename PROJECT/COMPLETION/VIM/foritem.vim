" Fichier : foritem.vim
"
" But : The loop on the dictionary items
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

call setline( s:currentLineNum, s:currentIndent . "for [ <@ELEMENT_KEY@>, <@ELEMENT_VALUE@> ] in items( <@DICTIONARY_VAR@> )" )
call append( s:currentLineNum, s:currentIndent . "endfor \" End FOR <@COND_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@FOR_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

