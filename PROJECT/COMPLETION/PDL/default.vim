" Fichier : default.vim
"
" But : Build the begining of an unknown entity_kind object
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

let s:currentLineNum = line( "." )
let s:currentLine = getline( s:currentLineNum )

if ( substitute( s:currentLine, "\\.[A-Za-z_]\\+", "", "" ) != s:currentLine )
   let s:objectName = substitute( s:currentLine, "\\..*", "", "" )
   let s:entityKind = substitute( s:currentLine, "\.*\\.", "", "" )

   call setline( s:currentLineNum, s:objectName . ".entity_kind := \"" . s:entityKind . "\";" )
   call append( s:currentLineNum, s:objectName . ".<@ATTRIBUTE_NAME@> := <@VALUE@>;<@NEXT@>" )
elseif ( substitute( s:currentLine, "^[^ 	:=,;]\\+\\(\\|\\.\\)$", "", "" ) != s:currentLine )
   let s:objectName = substitute( s:currentLine, "\\.$", "", "" )

   if ( s:objectName == s:currentLine )
      call setline( s:currentLineNum, s:objectName . " := <@VALUE@>;<@NEXT@>" )
   else
      call setline( s:currentLineNum, s:objectName . ".entity_kind := \"<@ENTITY_KIND@>\";<@NEXT@>" )
   endif
else
   call setline( s:currentLineNum, s:currentLine . "<@UNKNOWN_COMPLETION@>" )
endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

"---< Fin de fichier >----------------------------------------------------------

