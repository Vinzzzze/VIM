" Fichier : enum.vim
"
" But : How the enum command can be completed
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

call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . "};" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@ENUM_VALUES@>" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

