" Fichier : ;.vim
"
" But : Continue the definition of the current PDL object
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
let s:lineWhereAppend = s:currentLineNum
let s:objectName = substitute( s:currentLine, "\\(\\.[^\":= ]\\+\\|\\)[	 ]*:=.*", "", "" )

while ( s:objectName == s:currentLine && s:currentLineNum > 0 )
   let s:currentLineNum -= 1
   let s:currentLine = getline( s:currentLineNum )
   let s:objectName = substitute( s:currentLine, "\\(\\.[^\":= ]\\+\\|\\)[	 ]*:=.*", "", "" )
endwhile

if ( substitute( s:currentLine, "[	 ]*:=.*", "", "" ) != s:objectName )
   call append( s:lineWhereAppend, s:objectName . ".<@ATTRIBUTE_NAME@> := <@VALUE@>;<@NEXT@>" )
else
   call append( s:lineWhereAppend, "<@OBJECT_NAME@> := <@VALUE@>;<@NEXT@>" )
endif

"---< Fin de fichier >----------------------------------------------------------

