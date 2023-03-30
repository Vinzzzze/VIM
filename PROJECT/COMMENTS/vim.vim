" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let currentFunctionName = input( "Nom de la fonction à créer : " )
echo "\n"
let currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

" Check si le fichier est un fichier de classes
"----------------------------------------------
let numLine = line( "." )

if ( goForAction == "Y" )
   call append( numLine, "" )
   let numLine = numLine + 1
   call append( numLine, "if ( exists( \"*" . currentFunctionName . "\" ) == 0 )" )
   let numLine = numLine + 1
   call append( numLine, "" )
   let numLine = numLine + 1
   call append( numLine, "\" Fonction : " . currentFunctionName )
   let numLine = numLine + 1
   call append( numLine, "\"" )
   let numLine =  VM_PrintLimitedLengthLine( "\" But : ", "\"       ", numLine + 1, currentLibelleName, 72 )
   call append( numLine, "\"" )
   let numLine = numLine + 1
   call append( numLine, "\" Buffer : " )
   let numLine = numLine + 1
   call append( numLine, "\"" )
   let numLine = numLine + 1
   call append( numLine, "\" Parametres :" )
   let numLine = numLine + 1
   call append( numLine, "\"" )
   let numLine = numLine + 1
   call append( numLine, "\" Marks :" )
   let numLine = numLine + 1
   call append( numLine, "\"" )
   let numLine = numLine + 1
   call append( numLine, "\" Retour :" )
   let numLine = numLine + 1
   call append( numLine, "\"" )
   let numLine = numLine + 1
   call append( numLine, "\"-------------------------------------------------------------------------------" )
   let numLine = numLine + 1
   call append( numLine, "function " . currentFunctionName . "()" )
   let numLine = numLine + 1
   call append( numLine, "endfunction" )
   let numLine = numLine + 1
   call append( numLine, "" )
   let numLine = numLine + 1
   call append( numLine, "endif" )
endif

