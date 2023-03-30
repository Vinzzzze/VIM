" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = input( "Exception : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Exception comment : " )
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
   call VM_ProjectBuildFile( s:commandUsed, s:className, "excp_cpp", s:comment, "excp_" . s:className . ".cpp", "EXCEPTION", s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "excp_hpp", s:comment, "excp_" . s:className . ".hpp", "EXCEPTION", s:projectFolder )
endif

