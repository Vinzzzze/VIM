" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = input( "Command name : " )
echo "\n"

if ( s:className == "" )
   finish
endif " End IF there is no class name, just end the current script

let s:vectorCommand = ""

if ( input( "Vector command ( Y/N, default is N ) : " ) == "Y" )
   let s:vectorCommand = "v"
endif " End IF the command is a vector command

let s:factoryName = "fact_" . substitute( s:className, "^cmd_", "", "" )
let s:descriptionName = "desc_" . substitute( s:className, "^cmd_", "", "" )
let s:className = "cmd_" . substitute( s:className, "^cmd_", "", "" )

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Command comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   let g:VM_additionnalValues[ "ELEMENT_DESC_MACRO" ] = toupper( s:descriptionName )
   let g:VM_additionnalValues[ "ELEMENT_FACTORY_NAME" ] = s:factoryName
   let g:VM_additionnalValues[ "ELEMENT_DEFAULTBUF_NAME" ] = "defaultBuf_[@ELEMENT_@++@NAME@]"

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", s:className, "c_" . s:vectorCommand . "cmd", s:comment, s:className . ".c", s:repository, s:projectFolder )

   " Construit le fichier d'accessors
   "---------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "mac_" . s:vectorCommand . "cmd", s:comment, s:className . ".mac", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "h_" . s:vectorCommand . "cmd", s:comment, s:className . ".h", s:repository, s:projectFolder )

   " Construit le fichier de type
   "-----------------------------
   call VM_ProjectBuildFile( "split", s:className, "typ_" . s:vectorCommand . "cmd", s:comment, s:className . ".typ", s:repository, s:projectFolder )

   wincmd =
endif

