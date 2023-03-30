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

" Recup�re le nom de la classe � cr�er
"-------------------------------------
let s:tableName = input( "Table : " )
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le commentaire du fichier
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

