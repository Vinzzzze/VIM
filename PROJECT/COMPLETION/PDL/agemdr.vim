" Fichier : agmd.vim
"
" But : Build the alizes_get_market_data active object.
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

call setline( s:currentLineNum, s:currentName . "_result.entity_kind := \"alizes_get_elementary_market_data_result\";" )
call append( s:currentLineNum, s:currentName . "_result.status := \"OK\";" )
call append( s:currentLineNum, s:currentName . "_result.meta_config_id_list := ();" )
call append( s:currentLineNum, s:currentName . "_result.id_profile_list := (\"referential\");" )
call append( s:currentLineNum, s:currentName . "_result.id_list := (\"<@INSTRUMENT_NAME@>\",<@NEXT@>);" )
call append( s:currentLineNum, s:currentName . "_result.id_instrument_list := (\"<@INSTRUMENT_NAME@>\",<@NEXT@>);" )
call append( s:currentLineNum, s:currentName . "_result.failed_id_profile_list := ();" )
call append( s:currentLineNum, s:currentName . "_result.failed_id_instrument_list := ();" )
call append( s:currentLineNum, s:currentName . "_result.error_list := ();" )
call append( s:currentLineNum, s:currentName . "_result.error_code_list := ();" )

"---< Fin de fichier >----------------------------------------------------------

