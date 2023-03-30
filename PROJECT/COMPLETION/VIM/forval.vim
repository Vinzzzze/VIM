" Fichier : forval.vim
"
" But : The loop on the dictionary values
"
" Auteur : VM - vincent.menager@bnpparibas.com
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

call setline( s:currentLineNum, s:currentIndent . "for <@ELEMENT_VALUE@> in values( <@DICTIONARY_VAR@> )" )
call append( s:currentLineNum, s:currentIndent . "endfor \" End FOR <@COND_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@FOR_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

