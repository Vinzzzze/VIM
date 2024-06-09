" Fichier : vdesc.vim
"
" But : Initialize the vector description file creation
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 21 mai 2023
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

let s:deleteFunctionAddDesc = 0

if ( exists( "*VM_AddDescGlobal" ) == 0 )

let s:deleteFunctionAddDesc = 1

" Fonction : VM_AddDescGlobal
"
" But : The function called for adding the description to the global file
"
" Parametres :
"    classAdd - The description class to add to the export file
"-------------------------------------------------------------------------------
function VM_AddDescGlobal( classAdd )
   let execUpdate = 1

   if ( VM_OpenProjectFileDescription( g:VM_allExportObjects, "split" ) == "" )
      if ( filereadable( g:VM_allExportLibrary . "/" . g:VM_allExportObjects ) != 0 )
         execute "split " . g:VM_allExportLibrary . "/" . g:VM_allExportObjects
      else
         let fileToLoad = input( "Get the all objects export file location : " )

         if ( fileToLoad == "" )
            let execUpdate = 0
         elseif ( filereadable( fileToLoad ) != 0 )
            execute "split " . fileToLoad
         elseif ( filereadable( fileToLoad . "/" . g:VM_allExportObjects ) != 0 )
            execute "split " . fileToLoad . "/" . g:VM_allExportObjects
         else
            let execUpdate = 0
         endif
      endif
   endif

   if ( execUpdate != 0 )
      if ( search( "\\<" . a:classAdd . "\\>", "wn" ) == 0 )
         call append( line( "$" ) - 1, g:VM_projectIndentation . "/* " . a:classAdd . " */ " . toupper( a:classAdd ) . "_IDENTIFIER," )

         write
      endif

      quit
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Recupère le nom de le type à vectoriser
"----------------------------------------
let s:inputType = input( "Vectorised type : " )
echo "\n"

if ( s:inputType == "" )
   finish
endif " End IF there is no class name, just end the current script

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

let s:pointerLen = len( substitute( s:inputType, "[^*]*", "", "" ) )
let s:vectorizedType = strpart( s:inputType, 0, len( s:inputType ) - s:pointerLen )

" Define the basic types list
"----------------------------
let s:basicSignedType = [ "char", "short", "int32", "int64", "float", "double" ]
let s:basicUnsignedType = [ "uchar", "ushort", "uint32", "uint64" ]

if ( s:vectorizedType == "char" && s:pointerLen > 0 )
   let s:partialType = "String"
   let s:includeName = ""
   let s:macroIdentifier = "0"
   let s:usedType = "STRING"
" End IF we are building the vector for a string
elseif ( index( s:basicSignedType, s:vectorizedType ) >= 0 )
   let s:partialType = toupper( strpart( s:vectorizedType, 0, 1 ) ) . strpart( s:vectorizedType, 1 )
   let s:includeName = ""
   let s:macroIdentifier = "0"
   let s:usedType = toupper( s:vectorizedType )
" End IF we wamt a vector for a signed type
elseif ( index( s:basicUnsignedType, s:vectorizedType ) >= 0 )
   let s:partialType = toupper( strpart( s:vectorizedType, 0, 2 ) ) . strpart( s:vectorizedType, 2 )
   let s:includeName = ""
   let s:macroIdentifier = "0"
   let s:usedType = toupper( s:vectorizedType )
else " End IF we want a vector for a unsigned type
   let s:repository = VM_SelectFolder( s:vectorizedType, s:projectFolder )

   if ( s:repository != "" )
      let s:repository .= "/"
   endif " End IF the repository of the class had been found

   let s:includeName = "#include \"" . s:repository . s:vectorizedType . ".typ\"\n\n"
   let s:partialType = substitute( s:vectorizedType, "[^_]*_", "", "" )
   let s:macroIdentifier = "DESC_" . toupper( s:partialType ) . "_IDENTIFIER"
   let s:usedType = "OBJECT"
endif " End IF we want a vector for the specified class

let s:allocatedUsage = "SUBOBJECT"

if ( s:pointerLen > 0 )
   let s:allocatedUsage = "POINTER_ALLOCATE"
   let s:vectorizedType .= "*"
endif " End IF we are using pointers to the object

" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = "desc_Vector" . s:partialType

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )

if ( VM_ProjectTestFileExists( s:className . ".c", s:repository, s:projectFolder ) != 0 )
   echo "File " . s:className . ".c already extists, creation cancelled.\n"

   finish
endif

let g:VM_additionnalValues[ "ASSOCIATED_INCLUDE" ] = substitute( s:includeName, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_ASSOCIATED_TYPE" ] = s:vectorizedType
let g:VM_additionnalValues[ "ELEMENT_ASSOCIATED_MACRO" ] = s:macroIdentifier
let g:VM_additionnalValues[ "ELEMENT_USED_TYPE" ] = s:usedType
let g:VM_additionnalValues[ "ELEMENT_ASSOCIATED_ALLOCATED" ] = s:allocatedUsage

if ( expand( "%" ) != "" )
   tabnew
endif

let s:comment = "The export for the vector that holds the " . s:vectorizedType . " element."

" Construit le fichier de corps de class
"---------------------------------------
call VM_ProjectBuildFile( "edit", s:className, "vc_desc", s:comment, s:className . ".c", s:repository, s:projectFolder )

if ( search( "^#include <stddef.h>$", "w" ) > 0 )
   +2
   ,/^$/-1 sort
   write
endif

" Construit le fichier d'accessors
"---------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "vmac_desc", s:comment, s:className . ".mac", s:repository, s:projectFolder )

" Construit le fichier d'entête de class
"---------------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "vh_desc", s:comment, s:className . ".h", s:repository, s:projectFolder )

" Construit le fichier de type
"-----------------------------
call VM_ProjectBuildFile( "split", s:className, "vtyp_desc", s:comment, s:className . ".typ", s:repository, s:projectFolder )

wincmd =

call VM_AddDescGlobal( s:className )

if ( s:deleteFunctionAddDesc != 0 )
   delfunction VM_AddDescGlobal
endif

"---< Fin de fichier >----------------------------------------------------------

