" Fichier : desc.vim
"
" But : Build the description in builder initialization code
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 21 févr. 2018
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
let s:objectName = substitute( substitute( strpart( s:currentLine, len( s:currentIndent ) ), " .*", "", "" ), "^[a-z]\+_", "", "" )
let s:objectMacro = toupper( s:objectName )

1
/^#include/

call append( line( "." ), "#include \"DESCRIPTION/desc_" . s:objectName . ".h\"" )

let s:currentLineNum += 1
execute s:currentLineNum

call setline( s:currentLineNum, s:currentIndent . "if ( DESC_" . s:objectMacro . "_DEFAULT == NULL )" )
call append( s:currentLineNum, s:currentIndent . "<@INIT_CODE@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . "currentArrayPosition[ DESC_" . s:objectMacro . "_IDENTIFIER ] = &( DESC_" . s:objectMacro . "_DEFAULT );" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . "} /* End IF the initialisation of class desc_" . s:objectName . " had to be done */" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "DESC_" . s:objectMacro . "_DEFAULT = build_desc_" . s:objectName . "();" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

