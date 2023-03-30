" Fichier : conflated.vim
"
" But : The conflated builder class definition.
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

" Recupère le nom de la classe à créer
"-------------------------------------
if ( expand( "%" ) == "" )
   let s:className = input( "C structure to conflated : " )
   echo "\n"

   " Récupère le projet ( base du folder de création du fchier )
   "------------------------------------------------------------
   let s:projectFolder = VM_ChooseProject()

   " Récupère le répertoire où devra être créé ce nouveau fichier
   "-------------------------------------------------------------
   let s:repository = VM_SelectFolder( s:className, s:projectFolder )

   if ( VM_ProjectTestFileExists( s:className . ".str", s:repository, s:projectFolder ) == 0 )
      echo "There is no existing class " . s:className . " in the project.\n"
   endif " End IF the class definition file does not exists

   if ( input( "Valide ( Y/N ) ? " ) != "Y" )
      finish
   endif
else " End IF there is no filename to use to guess the class to conflate
   let s:className = expand( "%:t:r" )
   let s:repository = expand( "%:h:t" )
   let s:projectFolder = expand( "%:h:h" )

   if ( exists( "g:VM_classConflatedNew" ) != 0 )
      execute g:VM_classConflatedNew
   endif " End IF a specific operation had to be done
endif " End IF the class to conflate is the current file

if ( s:className == "" )
   finish
endif " End IF there is no class name, just end the current script

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = "The conflated version of the " . s:className . " class."

if ( expand( "%" ) != "" )
   tabnew
endif

" Construit le fichier de corps de class
"---------------------------------------
call VM_ProjectBuildFile( "edit", s:className, "conflated_c", s:comment, s:className . "Conflated.c", s:repository, s:projectFolder )

" Construit le fichier d'accessors
"---------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "conflated_mac", s:comment, s:className . "Conflated.mac", s:repository, s:projectFolder )

" Construit le fichier d'entête de class
"---------------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "conflated_h", s:comment, s:className . "Conflated.h", s:repository, s:projectFolder )

" Construit le fichier de type
"-----------------------------
call VM_ProjectBuildFile( "split", s:className, "conflated_typ", s:comment, s:className . "Conflated.typ", s:repository, s:projectFolder )

" Construit le fichier de structure
"----------------------------------
call VM_ProjectBuildFile( "split", s:className, "conflated_str", s:comment, s:className . "Conflated.str", s:repository, s:projectFolder )

wincmd =

"---< Fin de fichier >----------------------------------------------------------

