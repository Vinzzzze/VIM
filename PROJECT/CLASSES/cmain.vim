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
   let s:commandUsed = "vsplit"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, "main", "cmain", s:comment, "main.cpp", ".", s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", "main", "hmain", s:comment, "main.hpp", ".", s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

