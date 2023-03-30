" Fichier : ELSE.vim
"
" But : How the ELSE command had to be completed.
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

call append( s:currentLineNum, s:currentIndent . "END -- End IF <@CONDITION_TEXT@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@CONTITION_CODE@>" )
call append( s:currentLineNum, s:currentIndent . "BEGIN" )

"---< Fin de fichier >----------------------------------------------------------

