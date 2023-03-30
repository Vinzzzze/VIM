" Fichier : asmd.vim
"
" But : Build the alizes_set_market_data active object.
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
let s:currentName = substitute( s:currentLine, "\\..*", "", "" )

call setline( s:currentLineNum, s:currentName . "_result.entity_kind := \"alizes_set_market_data_result\";" )
call append( s:currentLineNum, s:currentName . "_result.status := \"OK\";<@CONTINUE@>" )

"---< Fin de fichier >----------------------------------------------------------

