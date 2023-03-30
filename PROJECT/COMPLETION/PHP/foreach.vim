" Fichier : foreach.vim
"
" But : Build the foreach statement
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
let s:forIndent = substitute( s:currentLine, ".", " ", "g" )

call setline( s:currentLineNum, s:currentLine . " ( <@VAR_TO_SCAN@> as <@NAME_USED@> => <@VALUE_USED@> )" )
call append( s:currentLineNum, s:currentIndent . "} // End FOREACH <@FOREACH_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@FOR_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "{" )

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

"---< Fin de fichier >----------------------------------------------------------

