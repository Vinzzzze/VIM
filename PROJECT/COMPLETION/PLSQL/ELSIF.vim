" Fichier : ELSIF.vim
"
" But : How the elsif command is deployed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 13 juil. 2014
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

call setline( s:currentLineNum, s:currentLine . " ( <@CONDITION_STATEMENT@> )	-- End IF <@CONDITION_TEXT@>" )
call append( s:currentLineNum, s:currentIndent . g:SQL_projectIndentation . "<@CONTITION_CODE@>" )
call append( s:currentLineNum, s:currentIndent . "THEN" )

"---< Fin de fichier >----------------------------------------------------------

