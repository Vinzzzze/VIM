" Fichier : @.vim
"
" But : Finalize the object definition
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
let s:currentColNum = col( "." )
let s:currentLine = getline( s:currentLineNum )
let s:lineWhereAppend = s:currentLineNum
call setline( s:currentLineNum, strpart( s:currentLine, 0, s:currentColNum - 1 ) . strpart( s:currentLine, s:currentColNum ) )

while ( ( s:currentLineNum > 0 )&&( substitute( s:currentLine, "^[ 	]*<", "", "" ) == s:currentLine ) )
   let s:currentLineNum = s:currentLineNum - 1
   let s:currentLine = getline( s:currentLineNum )
endwhile

if ( s:currentLineNum > 0 )
   " The initial word had been found
   "--------------------------------
   let s:currentIndent = substitute( s:currentLine, "<.*", "", "" )
   " Keep the object name to close
   "------------------------------
   let s:xmlObjectName = substitute( substitute( s:currentLine, "^[ 	]*<[ 	]*", "", "" ), "\\W.*", "", "" )
   " Create the end of the object name
   "----------------------------------
   call setline( s:currentLineNum, getline( s:currentLineNum ) . "<@TEXT_OBJECT@></" . s:xmlObjectName .">" )
endif

"---< Fin de fichier >----------------------------------------------------------

