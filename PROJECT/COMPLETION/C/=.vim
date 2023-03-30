" Fichier : =.vim
"
" But : Build an array definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 27 avr. 2014
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

call append( s:currentLineNum, s:currentIndent . "};" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@ARRAY_VALUE@>" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

