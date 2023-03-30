" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = input( "C structure : " )
echo "\n"

if ( s:className == "" )
   finish
endif " End IF there is no class name, just end the current script

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Structure comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", s:className, "c", s:comment, s:className . ".c", s:repository, s:projectFolder )

   " Construit le fichier d'accessors
   "---------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "mac", s:comment, s:className . ".mac", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "h", s:comment, s:className . ".h", s:repository, s:projectFolder )

   " Construit le fichier de type
   "-----------------------------
   call VM_ProjectBuildFile( "split", s:className, "typ", s:comment, s:className . ".typ", s:repository, s:projectFolder )

   " Construit le fichier de structure
   "----------------------------------
   call VM_ProjectBuildFile( "split", s:className, "str", s:comment, s:className . ".str", s:repository, s:projectFolder )

   wincmd =
endif

