" Fichier : do.vim
"
" But : How the do ... while command can be completed
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 déc. 2013
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

call setline( s:currentLineNum, s:currentLine . " {" )
call append( s:currentLineNum, s:currentIndent . " } while (<@COND_STATEMENT@>);" )
call append( s:currentLineNum, s:currentIndent . g:JAVA_projectIndentation . "<@WHILE_STATEMENT@>" )

"---< Fin de fichier >----------------------------------------------------------

