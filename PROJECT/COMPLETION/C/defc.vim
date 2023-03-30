" Fichier : defc.vim
"
" But : Expand the complete macro definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 08 mars 2018
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

call inputsave()
let s:macroName = toupper( input( "Macro name : " ) )
call inputrestore()

let s:currentLineNum = line( "." )
let s:currentLine = getline( s:currentLineNum )
let s:currentClassName = toupper( expand( "%:t:r" ) )

call setline( s:currentLineNum, strpart( s:currentLine, 0, len( s:currentLine ) - 1 ) . "ine " . s:currentClassName . "_" . s:macroName . "( current ) " . s:currentClassName . "_PREFIXED_" . s:macroName . "( std, current )" )
call append( s:currentLineNum, strpart( s:currentLine, 0, len( s:currentLine ) - 1 ) . "ine " . s:currentClassName . "_PREFIXED_" . s:macroName . "( prefixe, current<@PARAMS@> ) \\" )

"---< Fin de fichier >----------------------------------------------------------

