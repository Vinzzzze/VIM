" Fichier : c++.vim
"
" But : Build the files to define a C++ class
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 06 août 2014
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

" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = input( "Class : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Class comment : " )
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
   call VM_ProjectBuildFile( s:commandUsed, s:className, "cpp", s:comment, s:className . ".cpp", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "hpp", s:comment, s:className . ".hpp", s:repository, s:projectFolder )

   wincmd =
endif

"---< Fin de fichier >----------------------------------------------------------

