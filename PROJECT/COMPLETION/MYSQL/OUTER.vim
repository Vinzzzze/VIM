" Fichier : OUTER.vim
"
" But : How the OUTER command had to be completed.
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

call setline( s:currentLineNum, s:currentLine . " JOIN" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . g:SQL_projectIndentation . "<@CONDITION_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@TABLE_NAME@> <@ALIAS_NAME@> ON" )

"---< Fin de fichier >----------------------------------------------------------

