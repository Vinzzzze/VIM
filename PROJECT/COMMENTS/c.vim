" Je demande le nom de la fonction et le libell� que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom de la fonction � cr�er : " )
echo "\n"

if ( s:currentFunctionName == "" )
   finish
endif

let s:currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"
let s:currentTypeReturned = input( "Type retourn� par la fonction : " )
echo "\n"

if ( s:currentTypeReturned == "" )
   finish
endif

" V�rification de la validit� des op�rations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

if ( s:goForAction == "Y" )
   " Cherche si la fonction � cr�er est inline ou non
   "-------------------------------------------------
   let s:voidFunction = 0
   
   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let s:voidFunction = 1
   endif

   " Build the header
   "-----------------
   call BuildFunctionBody( line( "." ), s:currentTypeReturned, s:currentFunctionName, s:currentLibelleName, s:voidFunction )
endif

