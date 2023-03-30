" Fichier : expDesc.vim
"
" But : The builder for the project export definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 19 févr. 2018
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

let s:className = "bldr_ExportDescriptions"
let s:comment = "The builder for the object description."

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", s:className, "bldr_ExpDesc_c", s:comment, s:className . ".c", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "bldr_ExpDesc_h", s:comment, s:className . ".h", s:repository, s:projectFolder )

   " Construit le fichier d'accessors
   "---------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "bldr_ExpDesc_mac", s:comment, s:className . ".mac", s:repository, s:projectFolder )

   " Construit le fichier de type
   "-----------------------------
   call VM_ProjectBuildFile( "split", s:className, "bldr_ExpDesc_typ", s:comment, s:className . ".typ", s:repository, s:projectFolder )

   " Construit le fichier de structure
   "----------------------------------
   wincmd h
   call VM_ProjectBuildFile( "split", s:className, "bldr_ExpDesc_str", s:comment, s:className . ".str", s:repository, s:projectFolder )

   " Construit le fichier de reference des identifiants de description d'export
   "---------------------------------------------------------------------------
   1 wincmd w
   call VM_ProjectBuildFile( "split", s:className, "bldr_ExpDesc_allObjects", s:comment, g:VM_allExportObjects, ".", s:projectFolder )

   wincmd =
   echo "Do not forget to specify that the " . g:VM_allExportObjects . " is in the " . s:projectFolder . " library.\nDo not forget to update the g:VM_allExportLibrary project variable to this value.\n"
endif

"---< Fin de fichier >----------------------------------------------------------

