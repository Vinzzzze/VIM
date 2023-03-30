" Recup�re le nom de la classe � cr�er
"-------------------------------------
let s:className = input( "Exception : " )
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le commentaire du fichier
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

   " Construit le fichier d'ent�te de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "excp_hpp", s:comment, "excp_" . s:className . ".hpp", "EXCEPTION", s:projectFolder )
endif

