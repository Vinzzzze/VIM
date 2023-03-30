" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = input( "Releasable manager class : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Releasable manager class comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "vsplit"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, s:className, "releaseManager_cpp", s:comment, s:className . ".cpp", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "releaseManager_hpp", s:comment, s:className . ".hpp", s:repository, s:projectFolder )
endif

