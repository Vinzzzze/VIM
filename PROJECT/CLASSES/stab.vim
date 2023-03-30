" Récupère le nom du fichier
"---------------------------
let s:tableName = input( "Table : " )
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
let s:comment = input( "Table comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "split"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   call VM_ProjectBuildFile( s:commandUsed, s:tableName, "TAB", s:comment, "dbo." . s:tableName . ".TAB", s:repository, "" )
endif

