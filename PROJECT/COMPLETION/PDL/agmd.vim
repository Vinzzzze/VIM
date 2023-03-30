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

call setline( s:currentLineNum, s:currentName . ".entity_kind := \"alizes_get_market_data\";" )
call append( s:currentLineNum, s:currentName . ".result := \"" . s:currentName . "_result\";" )
call append( s:currentLineNum, s:currentName . ".case_insensitive_search := \"yes\";" )
call append( s:currentLineNum, s:currentName . ".meta_infos := \"no\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".index_composition := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".bag_composition := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".index_bag_composition := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".etf_composition := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".contract_composition := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".snapshot := \"<@SNAPSHOT@>\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".use_real_time := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".enable_cache := \"yes\";" )
call append( s:currentLineNum, "\-- <@OPTIONAL@> " . s:currentName . ".profile_name := \"CI_dirty_area\";" )
call append( s:currentLineNum, s:currentName . ".model_list := ( \"soho_model\", \"full_compo\" ); -- <@OPTIONAL@>" )
call append( s:currentLineNum, s:currentName . ".model_instrument_type_list := ( \"exchange_rate_instrument\", \"bag_composition_instrument\" ); -- <@OPTIONAL@>" )
call append( s:currentLineNum, s:currentName . ".tracker_id := \"[<@APPLICATION@>][Manual test][" . substitute( $USER_NAME, "\"", "\"\"", "g" ) . "]<@COMMENT@>\";" )
call append( s:currentLineNum, s:currentName . ".version := \"1.0\";" )
call append( s:currentLineNum, s:currentName . ".value_date := \"today\"; -- <@XL_VALUE_DATE@>" )
call append( s:currentLineNum, s:currentName . ".site := \"paris\"; -- <@SITE@> : paris, hongkong, newyork ..." )
call append( s:currentLineNum, s:currentName . ".instrument_list := (\"<@INSTRUMENT_MDS_NAME@>\",<@NEXT_VALUE@>);" )

"---< Fin de fichier >----------------------------------------------------------

