" Fichier : ,.vim
"
" But : Build an attribute comment
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 déc. 2013
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
let s:currentColNum = col( "." )
let s:endLine = strpart( s:currentLine, s:currentColNum )
let s:currentLine = strpart( s:currentLine, 0, s:currentColNum )
let s:startLine = s:currentLine

while ( s:currentLine != substitute( s:currentLine, "([^()]*)", "", "" ) )
   let s:currentLine = substitute( s:currentLine, "([^()]*)", "\#@#&#@#", "" )
   let s:currentLine = substitute( s:currentLine, "\#@#(.*", "", "" ) . substitute( substitute( substitute( s:currentLine, "\.*#@#(", "(", "" ), ")#@#.*", ")", "" ), ".", " ", "g" ) . substitute( s:currentLine, "\.*)#@#", "", "" )
endwhile

let s:currentIndent = substitute( substitute( s:currentLine, "([^(]*$", "( ", "" ), ".", " ", "g" )

call setline( s:currentLineNum, s:startLine )
call append( s:currentLineNum, s:currentIndent . "<@PARAM@>" . s:endLine )

"---< Fin de fichier >----------------------------------------------------------

