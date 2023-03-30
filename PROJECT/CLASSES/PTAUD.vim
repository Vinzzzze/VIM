" Fichier : PTAUD.vim
"
" But : The command to create an audit table.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 16 juil. 2014
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
let s:tableName = input( "Table : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Table comment : " )
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
   call VM_ProjectBuildFile( s:commandUsed, s:tableName, "PTAUD", s:comment, s:tableName . ".PTAB", "Audit", s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

