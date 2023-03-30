" Fichier : np.vim
"
" But : How the network_pricing is created.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 17 oct. 2014
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

call setline( s:currentLineNum, s:currentName . ".entity_kind := \"network_pricing\";" )
call append( s:currentLineNum, s:currentName . ".result := \"" . s:currentName . "_result\";" )
call append( s:currentLineNum, s:currentName . ".comment := \"[<@APPLICATION@>][Manual test][" . substitute( $USER_NAME, "\"", "\"\"", "g" ) . "]<@COMMENT@>\";" )
call append( s:currentLineNum, s:currentName . ".server_port := <@PORT_NUMBER@>;" )
call append( s:currentLineNum, s:currentName . ".server_host := \"<@SERVER_NAME@>.equities.net.intra\";" )
call append( s:currentLineNum, s:currentName . ".exec_name := \"<@ACTIVE_OBJECT@>\";" )

"---< Fin de fichier >----------------------------------------------------------

