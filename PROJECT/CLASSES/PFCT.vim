" Fichier : PFCT.vim
"
" But : Define a Postgres function or procedure.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 28 juin 2014
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
let s:procedureName = input( "Procedure : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
for s:currentProject in VM_GetFolders( s:projectFolder )
   echo " " . s:currentProject . "\n"
endfor
let s:schema = input( "\nSchema : " )
echo "\n"

let s:modele = "PPRC"

if ( input( "Result-Set returned ( Y/N ) ? " ) == "Y" )
   let s:modele = "PLST"
endif

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Procedure comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "split"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, s:procedureName, s:modele, s:comment, s:procedureName . ".PFCT", s:schema, s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

