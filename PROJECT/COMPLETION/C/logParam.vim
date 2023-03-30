" Fichier : logParam.vim
"
" But : The completion to build the log parameters
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 02 mai 2018
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

call setline( s:currentLineNum, s:currentIndent . "BASE_LOGGER_CODE_VALUE_PARAM_<@TYPE@>," )
call append( s:currentLineNum, s:currentIndent . "logParam<@PARAM@>," )
call append( s:currentLineNum, s:currentIndent . "<@VALUE@>," )
call append( s:currentLineNum, s:currentIndent . "<@VALUE_DESCRIPTION@>," )

"---< Fin de fichier >----------------------------------------------------------

