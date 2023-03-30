" Fichier : if.vim
"
" But : How the if command had to be completed.
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
let s:currentIndent = substitute( s:currentLine, ".", " ", "g" )
let s:returnIndent = substitute( s:currentLine, "[^ 	].*", "", "g" )

call setline( s:currentLineNum, s:currentLine . "( stdout," )
call append( s:currentLineNum, s:returnIndent . "return <@VALUE@>;" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . "  ERROR_INTRO\"<@PRINT_STRING@>\\n\"<@PARAM@> );" )

"---< Fin de fichier >----------------------------------------------------------

