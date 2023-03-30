" Récupère le nom du fichier
"---------------------------
let s:storedProcedure = input( "Stored procedure : " )
echo "\n"

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = input( "Repository (" . expand( "%:h" ) . ") : " )
echo "\n"
if ( s:repository == "" )
   let s:repository = expand( "%:p:h" )
endif

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Procedure comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "split"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   call VM_ProjectBuildFile( s:commandUsed, s:storedProcedure, "PRC", s:comment, "dbo." . s:storedProcedure . ".PRC", s:repository, "" )
endif

