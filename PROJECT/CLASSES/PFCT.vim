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

" Recup�re le nom de la classe � cr�er
"-------------------------------------
let s:procedureName = input( "Procedure : " )
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le r�pertoire o� devra �tre cr�� ce nouveau fichier
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

" R�cup�re le commentaire du fichier
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

