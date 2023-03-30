" Fichier : c++node.vim
"
" But : Build the files to define a formula node.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 06 ao�t 2015
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
let s:className = input( "Node name ( xxx_blahblah, Node will be added at the end ) : " ) . "Node"
echo "\n"

" R�cup�re le projet ( base du folder de cr�ation du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" R�cup�re le r�pertoire o� devra �tre cr�� ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Extention du template
"----------------------
let s:templateExt = input( "Template extention ( NoParam, ... ) : " )
echo "\n"

" R�cup�re le commentaire du fichier
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

   " Get the file introduction
   "--------------------------
   let s:fileIntro = VM_ExtractFileIntro( s:className )
   let g:VM_additionnalValues[ "BASEFILENAME" ] = substitute( strpart( s:className, len( s:fileIntro ) + 1 ), "Node$", "", "" )
   let g:VM_additionnalValues[ "BASEMACRO" ] = toupper( strpart( substitute( g:VM_additionnalValues[ "BASEFILENAME" ], "[A-Z]", "\_&", "g" ), 1 ) )
   let g:VM_additionnalValues[ "NODEFILENAME" ] = s:className
   let g:VM_additionnalValues[ "NODEFOLDER" ] = s:repository

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, s:className, "Node" . s:fileIntro . s:templateExt . "_cpp", s:comment, s:className . ".cpp", s:repository, s:projectFolder )

   " Construit le fichier d'ent�te de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "Node" . s:fileIntro . s:templateExt . "_hpp", s:comment, s:className . ".hpp", s:repository, s:projectFolder )

   " ICI ON AJOUTE LA FACTORY
   "-------------------------
   let s:className = VM_ReplaceFileIntro( s:className, "fact" )

   " R�cup�re le r�pertoire o� devra �tre cr�� la factory
   "-----------------------------------------------------
   let s:repository = VM_SelectFolder( s:className, s:projectFolder )

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "NodeFact" . s:fileIntro . s:templateExt . "_cpp", s:comment, s:className . ".cpp", s:repository, s:projectFolder )

   " Construit le fichier d'ent�te de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "NodeFact" . s:fileIntro . s:templateExt . "_hpp", s:comment, s:className . ".hpp", s:repository, s:projectFolder )

   wincmd =
endif

"---< Fin de fichier >----------------------------------------------------------

