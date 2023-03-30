" Fichier : p.vim
"
" But : Build a prefixed macro for the current class
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 29 sept. 2016
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
let s:currentClassName = toupper( expand( "%:t:r" ) )

call setline( s:currentLineNum, s:currentLine . s:currentClassName . "_PREFIXED_<@MACRO_FINAL@>" . s:endLine )

"---< Fin de fichier >----------------------------------------------------------

