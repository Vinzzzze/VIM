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
let s:commentText = substitute( s:currentLine, "^[ 	]*//", "", "" )

if ( s:currentIndent . "//" . s:commentText == s:currentLine )
   let s:replacementComment = substitute( s:commentText, ".", "-", "g" )

   call append( s:currentLineNum, s:currentIndent . "<@FOLLOWING_STATEMENT@>" )
   call append( s:currentLineNum, s:currentIndent . "//" . s:replacementComment )
endif

"---< Fin de fichier >----------------------------------------------------------

