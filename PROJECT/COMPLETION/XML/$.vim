" Fichier : $.vim
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
let s:currentLine = strpart( s:currentLine, 0, s:currentColNum - 1 ) . strpart( s:currentLine, s:currentColNum )
call setline( s:currentLineNum, s:currentLine )
let s:isEndOfObject = ( substitute( s:currentLine, "/>", "", "" ) != s:currentLine )

while ( ( s:currentLineNum > 0 )&&( substitute( s:currentLine, "^[ 	]*<", "", "" ) == s:currentLine ) )
   let s:currentLineNum = s:currentLineNum - 1
   let s:currentLine = getline( s:currentLineNum )
endwhile

if ( s:currentLineNum > 0 )
   " The initial word had been found
   "--------------------------------
   let s:currentIndent = substitute( s:currentLine, "<.*", "", "" )
   " Determine if we are on a start or an end of the object
   "-------------------------------------------------------
   if ( ( s:isEndOfObject == 0 )&&( substitute( s:currentLine, "</", "", "" ) == s:currentLine ) )
      " Keep the object name to close
      "------------------------------
      let s:xmlObjectName = substitute( substitute( s:currentLine, "^[ 	]*<[ 	]*", "", "" ), "\\W.*", "", "" )
      " Create the end of the object name
      "----------------------------------
      call append( s:lineWhereAppend, s:currentIndent . "</" . s:xmlObjectName . ">" )
      call append( s:lineWhereAppend, s:currentIndent . g:XML_projectIndentation . "<<@OBJECT_NAME@><@ATTRIBUTE_DESRIPTION@>>" )
   else
      call append( s:lineWhereAppend, s:currentIndent . "<<@OBJECT_NAME@><@ATTRIBUTE_DESRIPTION@>>" )
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

