" Fichier : default.vim
"
" But : Expand the comment definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 déc. 2013
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
let s:commentText = substitute( s:currentLine, "^[ 	]*/\\*", "", "" )

if ( s:currentIndent . "/*" . s:commentText == s:currentLine )
   let s:replacementComment = substitute( strpart( s:commentText, 0, strlen( s:commentText ) - 2 ), ".", "-", "g" )

   call append( s:currentLineNum, s:currentIndent . "<@FOLLOWING_STATEMENT@>" )
   call append( s:currentLineNum, s:currentIndent . "/*" . s:replacementComment . "*/" )
else
   let s:currentColNum = col( "." )
   let s:endLine = strpart( s:currentLine, s:currentColNum )
   let s:currentLine = strpart( s:currentLine, 0, s:currentColNum )
   let s:currentClassName = expand( "%:t:r" )

   call setline( s:currentLineNum, s:currentLine . s:currentClassName . "<@MACRO_FINAL@>" . s:endLine )
endif

"---< Fin de fichier >----------------------------------------------------------

