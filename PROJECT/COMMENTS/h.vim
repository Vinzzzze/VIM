" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom de la fonction à créer : " )
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
let s:goForAction = input( "Créer une fonction ou un type ou annuler ( T/F/A ) : " )

let s:introType = ""
if ( s:goForAction == "T" )
   let s:introType = "typedef "
   let s:goForAction = "F"
endif " End IF we want to add a function type

if ( s:goForAction == "F" )
   " Cherche si la fonction à créer est inline ou non
   "-------------------------------------------------
   let s:voidFunction = 0
   
   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let s:voidFunction = 1
   endif

   " Call the function used to build the header
   "-------------------------------------------
   let s:numLine = BuildFunctionComment( line( "." ), s:currentFunctionName, s:currentLibelleName, s:voidFunction )
   call append( s:numLine, s:introType . s:currentTypeReturned . " " . ComputeFunctionName( s:currentFunctionName ) . "();" )

   if ( s:introType == "" )
      call COpenAlternate( "split", "c" )

      " Save the modified status
      "-------------------------
      let s:saveAlternate = &modified

      " Move to the line to use for the creation of the function
      "---------------------------------------------------------
      $
      ?^}

      " Build the header
      "-----------------
      call BuildFunctionBody( line( "." ), s:currentTypeReturned, s:currentFunctionName, s:currentLibelleName, s:voidFunction )

      " Close the file opened
      "----------------------
      if ( s:saveAlternate == 0 )
         write
      endif
   endif " End IF a function is defined in h and c files, not a type

   quit
endif
