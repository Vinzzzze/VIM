" Fichier : ,.vim
"
" But : Handle the , to continue the vector definition
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
let s:currentColNum = col( "." )
let s:endLine = strpart( s:currentLine, s:currentColNum )
let s:currentLine = strpart( s:currentLine, 0, s:currentColNum )
let s:startLine = substitute( s:currentLine, "[^\"]\\+[	 ]*:=[	 ]*([	 ]*", "", "" )

if ( substitute( s:startLine, "[^\",]\\+,[	 ]*[^\",]\\+,[	 ]*[^\",]\\+,[	 ]*[^\",]\\+,[	 ]*[^\",]\\+,", "", "" ) == "" )
   call setline( s:currentLineNum, s:currentLine . " -- 5" )
   call append( s:currentLineNum, "<@NUMBER@>,<@NEXT_VALUE@>" . s:endLine )
elseif ( substitute( s:startLine, "\\(\"[^\"]*\"\\)\\+,[	 ]*\\(\"[^\"]*\"\\)\\+,[	 ]*\\(\"[^\"]*\"\\)\\+,[	 ]*\\(\"[^\"]*\"\\)\\+,[	 ]*\\(\"[^\"]*\"\\)\\+,", "", "" ) == "" )
   call setline( s:currentLineNum, s:currentLine . " -- 5" )
   call append( s:currentLineNum, "\"<@TEXT@>\",<@NEXT_VALUE@>" . s:endLine )
elseif ( substitute( s:startLine, "\\(\"[^\"]*\"\\)\\+,", "", "" ) != s:startLine )
   call setline( s:currentLineNum, s:currentLine . " \"<@TEXT@>\",<@NEXT_VALUE@>" . s:endLine )
else
   call setline( s:currentLineNum, s:currentLine . " <@NUMBER@>,<@NEXT_VALUE@>" . s:endLine )
endif

"---< Fin de fichier >----------------------------------------------------------

