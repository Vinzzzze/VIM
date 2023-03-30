" Fichier : FOR.vim
"
" But : How the FOR command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 10 juil. 2014
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

call setline( s:currentLineNum, s:currentLine . " <@VARIABLE@> IN" )
call append( s:currentLineNum, s:currentIndent . "END LOOP; -- End FOR <@CONDITION_TEXT@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "RETURN NEXT <@VARIABLE@>;" )
call append( s:currentLineNum, s:currentIndent . "LOOP" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "SELECT<@SELECT_BLOCK@>" )

"---< Fin de fichier >----------------------------------------------------------

