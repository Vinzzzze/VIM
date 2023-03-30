" Fichier : ,.vim
"
" But : Continue the declaration on the next line
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
let s:currentLine = strpart( s:currentLine, 0, s:currentColNum - 1 )
let s:startLine = s:currentLine

let s:currentIndent = substitute( substitute( s:currentLine, "\\w\\+[ ^I]*=[^=]*$", "", "" ), ".", " ", "g" )

call setline( s:currentLineNum, s:startLine )
call append( s:currentLineNum, s:currentIndent . "<@PARAM@>=<@VALUE@>" . s:endLine )

"---< Fin de fichier >----------------------------------------------------------

