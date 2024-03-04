" Fichier : ifvar.vim
"
" But : Build the test on variable existance
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
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
let s:currentLine = substitute( s:currentLine, "^[ 	]\\+", "", ""  )
let s:varName = substitute( s:currentLine," \\+.*", "", "" )

if ( ( s:varName == "" )||( s:varName == s:currentLine ) )
   let s:varName = "<@VARIABLE@>"
endif " End IF the variable is not defined

call setline( s:currentLineNum, s:currentIndent . "if ( exists( \"" . s:varName . "\" ) == 0 )" )
call append( s:currentLineNum, s:currentIndent . "endif" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "let " . s:varName . " = <@VALUE@>" )

"---< Fin de fichier >----------------------------------------------------------

