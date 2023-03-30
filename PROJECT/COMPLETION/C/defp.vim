" Fichier : defp.vim
"
" But : Expand the define value for a prefixed macro.
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
let s:currentClassName = toupper( expand( "%:t:r" ) )

call setline( s:currentLineNum, strpart( s:currentLine, 0, len( s:currentLine ) - 1 ) . "ine " . s:currentClassName . "_PREFIXED_<@MACRO_FINAL@>( prefixe, current<@PARAMS@> ) \\" )

"---< Fin de fichier >----------------------------------------------------------

