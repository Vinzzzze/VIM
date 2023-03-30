" Fichier : if.vim
"
" But : How the if command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 11 d�c. 2013
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

call setline( s:currentLineNum, s:currentLine . "( data_LogOutput::get<@FLAG@>Output()," )
call append( s:currentLineNum, s:currentIndent . "  getSystemCurrentThreadId() );" )
call append( s:currentLineNum, s:currentIndent . "  \"Thread %d : <@PRINT_STRING@>\n\"," )

"---< Fin de fichier >----------------------------------------------------------

