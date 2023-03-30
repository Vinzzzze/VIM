" Fichier : dbmsg.vim
"
" But : Create the files for the database message classe.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 24 juil. 2014
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
let s:className = "msg_" . input( "Message : " )
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le commentaire du fichier
"-----------------------------------
let s:comment = input( "Message comment : " )
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
   call VM_ProjectBuildFile( s:commandUsed, s:className, "msgcpp", s:comment, s:className . ".cpp", "MESSAGE", s:projectFolder )

   " Construit le fichier d'ent�te de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "msghpp", s:comment, s:className . ".hpp", "MESSAGE", s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

