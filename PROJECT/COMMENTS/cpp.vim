" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom de la fonction à créer : " )
echo "\n"
let s:currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"
let s:currentTypeReturned = input( "Type retourné par la fonction : " )
echo "\n"

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

" Check si le fichier est un fichier de classes
"----------------------------------------------
let s:numLine = line( "." )
let s:isFunction = search( "^//---< Functions >-\\+$" )

if ( s:goForAction == "Y" )
   " Cherche si la fonction à créer est inline ou non
   "-------------------------------------------------
   let s:voidFunction = 0
   
   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let s:voidFunction = 1
   endif

   " Il n'y a pas d'element name
   "----------------------------
   let s:elementName = ""

   if ( s:isFunction == 0 )
      " Je récupère le nom du fichier qui correspond au nom de l'élément courant
      "-------------------------------------------------------------------------
      let s:elementName = expand( "%:t:r" ) . "::"
   endif

   " Build the header
   "-----------------
   call BuildFunctionBody( line( "." ), s:currentTypeReturned, s:currentFunctionName, s:elementName, s:currentLibelleName, s:voidFunction )
endif

