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

call setline( s:currentLineNum, s:currentName . ".entity_kind := \"alizes_set_market_data\";" )
call append( s:currentLineNum, s:currentName . ".result := \"" . s:currentName . "_result\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".snapshot := \"<@SNAPSHOT@>\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".setup := \"clean_market_data\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".profile_name := \"CI_dirty_area\";" )
call append( s:currentLineNum, s:currentName . ".tracker_id := \"[<@APPLICATION@>][Manual test][" . substitute( $USER_NAME, "\"", "\"\"", "g" ) . "]<@COMMENT@>\";" )
call append( s:currentLineNum, s:currentName . ".version := \"1.0\";" )
call append( s:currentLineNum, s:currentName . ".value_date := \"today\"; -- <@XL_VALUE_DATE@>" )
call append( s:currentLineNum, s:currentName . ".site := \"paris\"; -- <@SITE@> : paris, hongkong, newyork ..." )
call append( s:currentLineNum, s:currentName . ".ldap_user := \"<@USER_NAME@>\";" )
call append( s:currentLineNum, s:currentName . ".ldap_password := \"<@USER_PASSWORD@>\";" )
call append( s:currentLineNum, s:currentName . ".market_data_name := \"<@INSTRUMENT_ENTITY_KIND@>\";" )
call append( s:currentLineNum, s:currentName . ".main_pdl_object := \"<@INSTRUMENT_MDS_NAME@>\";" )
call append( s:currentLineNum, s:currentName . ".instrument_code := \"<@INSTRUMENT_MDS_NAME@>\";" )

"---< Fin de fichier >----------------------------------------------------------

