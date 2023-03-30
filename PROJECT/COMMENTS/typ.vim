" Fichier : typ.vim
"
" But : The comment for the type definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 25 janv. 2017
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

" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom du type de la fonction à créer : " )
echo "\n"

if ( s:currentFunctionName == "" )
   finish
endif

let s:currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"
let s:currentTypeReturned = input( "Type retourné par la fonction : " )
echo "\n"

if ( s:currentTypeReturned == "" )
   finish
endif

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

if ( s:goForAction == "Y" )
   " Cherche si la fonction à créer est inline ou non
   "-------------------------------------------------
   let s:voidFunction = 0
   
   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let s:voidFunction = 1
   endif

   " Build the header
   "-----------------
   let s:currentFunctionName = substitute( s:currentFunctionName, "^[fF][cC][tT]", "", "" )
   let s:currentFunctionName = "fct" . toupper( strpart( s:currentFunctionName, 0, 1 ) ) . strpart( s:currentFunctionName, 1 )
   let s:numLine = BuildFunctionComment( line( "." ), s:currentFunctionName, s:currentLibelleName, s:voidFunction )
   call append( s:numLine, "typedef " . s:currentTypeReturned . " (*" . ComputeFunctionName( s:currentFunctionName ) . ")();" )
endif

"---< Fin de fichier >----------------------------------------------------------

