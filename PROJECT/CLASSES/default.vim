" R�cup�re le nom du fichier
"---------------------------
let s:filename = input( "Filename : " )
echo "\n"

if ( s:filename == "" )
   finish
endif

" R�cup�re le r�pertoire o� devra �tre cr�� ce nouveau fichier
"-------------------------------------------------------------
let s:repository = input( "Repository (" . expand( "%:h" ) . ") : " )
echo "\n"
if ( s:repository == "" )
   let s:repository = expand( "%:p:h" )
endif

" R�cup�re le commentaire du fichier
"-----------------------------------
let s:comment = input( "File comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   " Calcul du nom du fichier de reference
   "--------------------------------------
   let s:modelName = substitute( s:filename, "\.*\\.", "", "" )

   if ( s:modelName == "" )
      let s:modelName = expand( "%:t" )
   endif

   " Je calcule le nom de l'�l�ment
   "-------------------------------
   let s:elementName = substitute( substitute( s:filename, "^dbo\\.", "", "" ), "\\.[^\\.]*$", "", "" )

   call VM_ProjectBuildFile( "split", s:elementName, s:modelName, s:comment, s:filename, s:repository, "" )
endif

