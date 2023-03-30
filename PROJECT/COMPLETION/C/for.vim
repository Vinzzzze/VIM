" Fichier : for.vim
"
" But : How the for command can be completed
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 déc. 2013
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
let s:forIndent = substitute( s:currentLine, ".", " ", "g" )

call setline( s:currentLineNum, s:currentLine . " ( <@INIT_STATEMENT@>;" )
call append( s:currentLineNum, s:currentIndent . "} /* End FOR <@FOR_EXPLAIN@> */" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@FOR_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "{" )
call append( s:currentLineNum, s:forIndent . "   <@FINAL_STATEMENT@> )" )
call append( s:currentLineNum, s:forIndent . "   <@COND_STATEMENT@>;" )

"---< Fin de fichier >----------------------------------------------------------

