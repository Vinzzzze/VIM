" Recup�re le nom de la classe � cr�er
"-------------------------------------
let s:className = input( "Pool : " )
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le commentaire du fichier
"-----------------------------------
let s:comment = input( "Pool comment : " )
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
   call VM_ProjectBuildFile( s:commandUsed, s:className, "pool_cpp", s:comment, "pool_" . s:className . ".cpp", "POOL", s:projectFolder )

   " Construit le fichier d'ent�te de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "pool_hpp", s:comment, "pool_" . s:className . ".hpp", "POOL", s:projectFolder )
endif

