" Fichier : (.vim
"
" But : Build the vector values definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 17 Oct 2014
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

call setline( s:currentLineNum, s:currentLine . "<@VALUE@>,<@NEXT@>)" . s:endLine )

"---< Fin de fichier >----------------------------------------------------------

