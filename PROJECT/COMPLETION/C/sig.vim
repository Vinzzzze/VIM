" Fichier : sig.vim
"
" But : Expand the signature value
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
let s:currentClassName = toupper( expand( "%:t:r" ) )

call setline( s:currentLineNum, "#define " . s:currentClassName . "_SIGNATURE " . rand() . "<@CONTINUE@>" )

"---< Fin de fichier >----------------------------------------------------------

