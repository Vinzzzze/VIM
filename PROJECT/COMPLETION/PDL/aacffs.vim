" Fichier : aacffs.vim
"
" But : Build the create family from setup object.
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

call setline( s:currentLineNum, s:currentName . ".entity_kind := \"alizes_adm_create_family_from_setup\";" )
call append( s:currentLineNum, s:currentName . ".meta_infos := \"no\";" )
call append( s:currentLineNum, s:currentName . ".result := \"" . s:currentName . "_result\";" )
call append( s:currentLineNum, s:currentName . ".tracker_id := \"[<@APPLICATION@>][Manual test][" . substitute( $USER_NAME, "\"", "\"\"", "g" ) . "]<@COMMENT@>\";" )
call append( s:currentLineNum, s:currentName . ".version := \"1.0\";" )
call append( s:currentLineNum, s:currentName . ".value_date := \"today\"; -- <@XL_VALUE_DATE@>" )
call append( s:currentLineNum, s:currentName . ".site := \"paris\"; -- <@SITE@> : paris, hongkong, newyork ..." )
call append( s:currentLineNum, s:currentName . ".family_name := \"<@FAMILY_NAME@>\";" )
call append( s:currentLineNum, s:currentName . ".market_data_name := \"<@ENTITY_KIND@>\";" )
call append( s:currentLineNum, s:currentName . ".setup_names := (\"<@ENTITY_KIND@>\");" )
call append( s:currentLineNum, s:currentName . ".ldap_user := \"<@USER_NAME@>\";" )
call append( s:currentLineNum, s:currentName . ".ldap_password := \"<@USER_PASSWORD@>\";" )
call append( s:currentLineNum, s:currentName . ".instrument_list := (\"<@INSTRUMENT_MDS_NAME@>\",<@NEXT_VALUE@>);" )

"---< Fin de fichier >----------------------------------------------------------

