" Fichier : aacffsr.vim
"
" But : Build the result of the alizes create family from setup definition.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 13 Apr 2015
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

call setline( s:currentLineNum, s:currentName . "_result.entity_kind := \"alizes_adm_create_family_from_setup_result\";" )
call append( s:currentLineNum, s:currentName . "_result.status := \"OK\";<@CONTINUE@>" )
call append( s:currentLineNum, s:currentName . "_result.error_list := ();" )
call append( s:currentLineNum, s:currentName . "_result.error_code_list := ();" )

"---< Fin de fichier >----------------------------------------------------------

