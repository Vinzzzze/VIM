" Fichier : cmain.vim
"
" But : create the main files for a C application.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 29 juin 2014
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

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "File comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", "main", "c_mn", s:comment, "main.c", ".", s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", "main", "h_mn", s:comment, "main.h", ".", s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

