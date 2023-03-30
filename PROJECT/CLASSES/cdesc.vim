" Fichier : cdesc.vim
"
" But : 
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 18 nov. 2017
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
"
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

      for [ reference, objectName ] in items( s:includes )
         if ( ( reference == objectName )&&( search( "\\<" . objectName . "_IDENTIFIER\\>", "w" ) != 0 ) )
            let s:includes[ reference ] = substitute( substitute( getline( "." ), " \\+/\\* \\+", "", "" ), " \\+\\*/ \\+.*", "", "" )
         endif
      endfor

      quit
   endif
endfunction

endif

if ( exists( "*VM_AddInclude" ) == 0 )

" Fonction : VM_AddInclude
"
" But : Add the specified class to the include list
"
" Parametres :
"    classInclude - The class name to be included
" Retour :
"    The class name to be used
"-------------------------------------------------------------------------------
function VM_AddInclude( classInclude )
   let descClass = substitute( a:classInclude, "[a-z]\\+_", "desc_", "" )

   if ( strpart( descClass, 0, 5 ) == "desc_" )
      let upperDesc = toupper( descClass )

      let s:includes[ upperDesc ] = descClass

      let descClass = upperDesc
   else
      let descClass = substitute( toupper( a:classInclude ), "[A-Z]\\+_", "DESC_", "" )

      if ( exists( "s:includes." . descClass ) == 0 )
         let s:includes[ descClass ] = descClass
      endif
   endif

   return descClass
endfunction

endif

if ( exists( "*VM_BuildIncludeList" ) == 0 )

" Fonction : VM_BuildIncludeList
"
" But : Build the include files to be added to the include list
"
" Parameters :
"    baseIncludes - the base includes text
" Retour :
"    The include list
"-------------------------------------------------------------------------------
function VM_BuildIncludeList( baseIncludes )
   let includeList = ""

   for currentInclude in values( a:baseIncludes )
      let includeList .= "#include \"" . currentInclude . ".h\"\n"
   endfor " End FOR all the object include

   for className in values( s:includes )
      let includeList .= "#include \"" . s:repository . "/" . className . ".h\"\n"
   endfor

   return includeList
endfunction

endif

if ( exists( "*VM_FindStructuredFile" ) == 0 )

" Fonction : VM_FindStructuredFile
"
" But : Find the structured file corresponding to the searched type
"
" Parametres :
"     typeName - The searched type
" Retour :
"     The file where the type can be found
"-------------------------------------------------------------------------------
function VM_FindStructuredFile( typeName )
   let commandName = printf( g:VM_classSearchCommand, a:typeName )

   return substitute( system( commandName ), ":.*", "", "" )
endfunction

endif

if ( exists( "*VM_GetFolderInclude" ) == 0 )

" Fonction : VM_GetFolderInclude
"
" But : Extract the include folder name from the complete folder path.
"
" Parametres :
"     completePath - the complete path to the file to inlude
" Retour :
"     the include path to be used
"-------------------------------------------------------------------------------
function VM_GetFolderInclude( completePath )
   let currentPathTest = a:completePath
   let includePath = ""

   while ( ( currentPathTest > "" )&&( filereadable( currentPathTest . "/" . g:VM_projectDefinitionFilename ) == 0 ) )
      let newPathTest = substitute( currentPathTest, "/[^/]*$", "", "" )
      let includePath = substitute( currentPathTest, ".*/", "", "" ) . "/" . includePath

      if ( newPathTest == currentPathTest )
         let currentPathTest = ""
      else " End IF there is no more folder to test
         let currentPathTest = newPathTest
      endif " End IF move to the next folder to test
   endwhile

   return includePath
endfunction

endif

if ( exists( "*VM_BuildAttributeOffset" ) == 0 )

" Fonction : VM_BuildAttributeOffset
"
" But : Build the offset attribute string.
"
" Retour :
"     The offset's attribute string
"-------------------------------------------------------------------------------
function VM_BuildAttributeOffset()
   return VM_BuildNamedAttributeOffset( s:attributeName )
endfunction

endif

if ( exists( "*VM_BuildNamedAttributeOffset" ) == 0 )

" Fonction : VM_BuildNamedAttributeOffset
"
" But : Build the offset for a named attribute
"
" Parametres :
"     namedAttribute - The name of the attribute for which we want the offset
" Retour :
"     The offset's named attribute
"-------------------------------------------------------------------------------
function VM_BuildNamedAttributeOffset( namedAttribute )
   return "( (char*)\\&( " . toupper( s:usedObject ) . "_PREFIXED_GET" . toupper( a:namedAttribute ) . "( std" . s:currentPrefixe . s:currentPrefixeObject . ", ( (" . s:associatedObject . "*)NULL ) ) ) - (char*)NULL )"
endfunction

endif

if ( exists( "*VM_BuildConflationSwitch" ) == 0 )

" Fonction : VM_BuildConflationSwitch
"
" But : Build the text to add for the conflation switch macro definition.
"
" Parametres :
"    type - The type of the current conflation index
"-------------------------------------------------------------------------------
function VM_BuildConflationSwitch( type )
   let s:conflationSwitch .= "      case " . toupper( s:associatedObject ) . "_CONFLATION_INDEX" . toupper( s:currentPrefixe ) . toupper( s:currentPrefixeObject ) . "_" . toupper( s:attributeName ) . ": \\\n\\\n"
   let s:conflationSwitch .= "         BASE_CONFLATIONOBJECT_CONFLATEDVALUEUPDATE( object, \\\n"
   let s:conflationSwitch .= "                                                     " . toupper( s:associatedObject ) . ", \\\n"
   let s:conflationSwitch .= "                                                     " . toupper( s:usedObject ) . ", \\\n"
   let s:conflationSwitch .= "                                                     " . toupper( s:attributeName ) . ", \\\n"
   let s:conflationSwitch .= "                                                     BASE_CONFLATIONOBJECT_DEFAULT_TYPE, \\\n"
   let s:conflationSwitch .= "                                                     std" . s:currentPrefixe . s:currentPrefixeObject . ", \\\n"
   let s:conflationSwitch .= "                                                     *(" . a:type . "*)value ); \\\n"
   let s:conflationSwitch .= "         break; \\\n\\\n"
endfunction

endif

if ( exists( "*VM_BuildConflationOffset" ) == 0 )

" Fonction : VM_BuildConflationOffset
"
" But : Build the string to ba added to the conflation offset definition.
"
" Parametres :
"    type - The type of the current conflation index
"-------------------------------------------------------------------------------
function VM_BuildConflationOffset( type )
   call VM_BuildConflationSwitch( a:type )

   return VM_BuildAttributeOffset()
endfunction

endif

if ( exists( "*VM_ComputeTypeObject" ) == 0 )

" Fonction : VM_ComputeTypeObject
"
" But : Compute the real object type to use.
"
" Parametres :
"    type - the type of the object
" Retour :
"    The object type to be used
"-------------------------------------------------------------------------------
function VM_ComputeTypeObject( type )
   let retValue = "BASE_OBJECTDESCRIPTION_TYPE_OBJECT"

   if ( substitute( a:type, "^\\<data_DateTime\\>", "", "" ) != a:type )
      let retValue = "BASE_OBJECTDESCRIPTION_TYPE_DATETIME_OBJECT"
   endif " End IF the current type is a datetime object

   return retValue
endfunction

endif

if ( exists( "*VM_CheckIgnoredType" ) == 0 )

" Fonction : VM_CheckIgnoredType
"
" But : Check if the current type had to be ignored or not
"
" Parametres :
"    type - The type to be tested
"    upper - 0 if the test is done normaly, another value to test upper cased values
" Retour :
"    0 when the current type should not be ignored, another value otherwise
"-------------------------------------------------------------------------------
function VM_CheckIgnoredType( type, upper )
   let retValue = 0

   if ( ( a:upper == 0 )&&( substitute( a:type, "^int_", "", "" ) != a:type ) )
      return 1
   " End IF we are on a pointer to an interface
   elseif ( ( a:upper != 0 )&&( substitute( a:type, "^INT_", "", "" ) != a:type ) )
      return 1
   " End IF we are on an interface definition
   else
      for currentExcluded in g:VM_classListToIgnore
         if ( ( a:upper == 0 )&&( currentExcluded == a:type ) )
            return 1
         " End IF the exact case of the current excluded type match with the current type
         elseif ( ( a:upper != 0 )&&( toupper( currentExcluded ) == a:type ) )
            return 1
         endif " End IF the upper case of the current excluded type match with the current type
      endfor " End FOR all the excluded types
   endif " End IF the current type is not an interface

   return 0
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Initialize la liste des classe à ignorer
"-----------------------------------------
if ( exists( "g:VM_classListToIgnore" ) == 0 )
   let g:VM_classListToIgnore = [ "base_Command", "typeAttribute_data_ObjectDescription", "heap_Allocator", "heap_Vector", "base_DynamicObjectDefinition" ]
endif " End IF the class list is not known

" Recupere la definition de la classe associée
"---------------------------------------------
let s:associatedObject = expand( "%:t:r" )
let s:associatedFolder = expand( "%:h:t" )
let s:projectFolder = expand( "%:h:h" )

" Recupère le nom de la classe à créer
"-------------------------------------
let s:className = substitute( s:associatedObject, "[^_]*_", "desc_", "" )
echo "\n"

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:className, s:projectFolder )
let s:extentionClass = ""

while ( VM_ProjectTestFileExists( s:className . s:extentionClass . ".c", s:repository, s:projectFolder ) != 0 )
   let s:extentionClass = input( "File " . s:className . s:extentionClass . ".c already extists, give an other class name update : " )

   if ( s:extentionClass == "" )
      finish
   endif
endwhile

let s:className .= s:extentionClass
let s:currentLines = [ "" ] + readfile( expand( "%" ) )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = "Decription of " . substitute( s:currentLines[ 5 ], "^ \\+\\* \\+", "", "" )

let s:currentPrefixe = ""
let s:offsetValues = ""
let s:typeValues = ""
let s:bufferDeclare = ""
let s:bufferInitDeclare = {}
let s:bufferInit = ""
let s:bufferName = "NULL"
let s:bufferOffset = "0"
let s:bufferSize = ""
let s:indexesList = ""
let s:namesList = ""
let s:baseIncludes = {}
let s:includes = {}
let s:ownConflation = 0
let s:conflationIndex = ""
let s:conflationOffset = ""
let s:conflationPosition = "0"
let s:conflationSize = "0"
let s:conflationIndexName = "NULL"
let s:conflationIndexDeclaration = ""
let s:conflationSwitch = ""
let s:objectListAdded = []
let s:usedObject = s:associatedObject
let s:currentPrefixeObject = ""
let s:conflationType = ""
let s:factoryInit = "NULL"
let s:searchFactory = 1
let s:typeValue = input( "Type description ( PUBLIC | RT | SNAPSHOT | BASE | BOOK | COMPLETE ) : " )
let s:currentDateTime = ""

if ( s:associatedObject == "data_DateTime" )
   let s:currentDateTime = "DATETIME_"
endif " End IF we are exporting the datetime definition

while ( ( s:usedObject > "" )||( len( s:objectListAdded ) > 0 ) )
   if ( len( s:objectListAdded ) > 0 )
      let s:searchFactory = 0
      let s:ancestorDefinition = remove( s:objectListAdded, 0 )
      let s:filename = VM_FindStructuredFile( s:ancestorDefinition.type )
      let s:currentPrefixeObject = s:ancestorDefinition.realPrefixe
      let s:currentPrefixe = s:ancestorDefinition.prefixe

      if ( s:ancestorDefinition.type == "DATA_DATETIME" )
         let s:currentDateTime = "DATETIME_"
      endif " End IF we are on a datetime object

      if ( s:filename == "" )
         let s:usedObject = s:ancestorDefinition.associated
         let s:currentType = s:ancestorDefinition.type

         let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
         let s:conflationOffset .= "   (offset_data_ObjectDescription)( (char*)( " . toupper( s:usedObject ) . "_PREFIXED_CONVERT_TO_" . toupper( s:currentType ) . toupper( s:currentPrefixeObject ) . "( " . s:ancestorDefinition.prefixe . ", ( (" . s:className . "*)NULL ) ) ) - (char*)NULL ), \\\n"
         let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = "initObject"
         let s:bufferInit .= "   initObject = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
         let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initObject,\n"
         let s:bufferInit .= "                                            (offset_data_ObjectDescription)( (char*)( " . toupper( s:usedObject ) . "_PREFIXED_CONVERT_TO_" . toupper( s:currentType ) . toupper( s:currentPrefixeObject ) . "( " . s:ancestorDefinition.prefixe . ", ( (" . s:className . "*)NULL ) ) ) - (char*)NULL ) );\n"
         let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
         let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
         let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( initObject,\n"
         let s:bufferInit .= "                                                \\&( " . VM_AddInclude( s:currentType ) . "_DEFAULT ) );\n"
         let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
         let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_OBJECT,\n"

         continue
      endif " End IF the filename cannot be found

      let s:currentLines = [ "" ] + readfile( s:filename )
      let s:usedObject = substitute( substitute( s:filename, ".*/", "", "" ), "\\..*", "", "" )
      let s:folderFilename = substitute( s:filename, "/[^/]*$", "", "" )
      let s:folderInclude = VM_GetFolderInclude( s:folderFilename )

      let s:baseIncludes[ s:folderInclude . s:usedObject ] = s:folderInclude . s:usedObject
   endif " End IF there is an object to read

   let s:lineNumber = 15
   let s:lastLine = len( s:currentLines ) - 1
   let s:defineFound = 0

   while ( ( s:defineFound == 0 )&&( s:lineNumber <= s:lastLine ) )
      let s:currentLine = s:currentLines[ s:lineNumber ]
      let s:defineFound = ( s:currentLine != substitute( s:currentLine, "^#define ", "", "" ) )

      if ( s:searchFactory > 0 )
         let s:factoryLine = substitute( s:currentLine, "^.* Factory : ", "", "" )

         if ( s:factoryLine != s:currentLine )
            let s:factoryInit = s:factoryLine
         endif " End IF the factory had been found
      endif " End IF the factory initialitation had to be searched

      let s:lineNumber += 1
   endwhile

   while ( ( s:currentLine > "" )&&( s:lineNumber <= s:lastLine ) )
      let s:currentLine = s:currentLines[ s:lineNumber ]

      if ( ( s:currentLine != substitute( s:currentLine, "^   [A-Za-z]", "", "" ) )&&( s:currentLine == substitute( s:currentLine, "_no-export[; \\\\]*$", "", "" ) ) )
         let s:currentType = substitute( substitute( substitute( s:currentLine, "^   ", "", "" ), " \\+prefixe.*", "", "" ), "\\(_TYPED\\|\\)_HSTR(.*", "", "" )

         if ( s:currentType == "BASE_CONFLATIONOBJECT" )
            let s:ownConflation = 1
            let s:attributeName = substitute( substitute( substitute( s:currentLine, " ", "", "g" ), "\\(prefixe\\|\\)\\(,\\|)\\).*", "", "" ), "\\(_TYPED\\|\\)_HSTR(\\(prefixe##\\|\\)", "", "" )
            let s:conflationPosition = "( (char*)( " . toupper( s:usedObject ) . "_PREFIXED_CONVERT_TO_" . toupper( s:attributeName ) . "( std" . s:currentPrefixe . s:currentPrefixeObject . ", ( (" . s:associatedObject . "*)NULL ) ) ) - (char*)NULL )"
         elseif ( VM_CheckIgnoredType( s:currentType, 1 ) == 0 )
            let s:pointerType = substitute( s:currentType, "[^\\*]*", "", "" )
            let s:currentArray = substitute( s:currentLine, "[^\\[]*[", "[", "" )
            let s:currentObject = ( ( s:currentLine != substitute( s:currentLine, "_HSTR(.*", "", "" ) )&&( s:currentLine == substitute( s:currentLine, "\\<" . toupper( s:usedObject ) . "_", "", "" ) ) )

            if ( s:currentObject == 0 )
               let s:attributeName = substitute( substitute( s:currentLine, "\.*##_", "", "" ), "[^A-Za-z_\\-]*$", "", "" )
               let s:attributeName = substitute( s:attributeName, "\\[.*", "", "" )

               if ( s:attributeName == "arrayConflation" )
                  let s:lineNumber += 1

                  continue
               endif " End IF the attribute is the conflation value's array

               if ( s:currentType != "typeAttribute_data_ObjectDescription" )
                  let s:indexesList .= "   " . toupper( s:className ) . "_INDEX" . toupper( s:currentPrefixe ) . toupper( s:currentPrefixeObject ) . "_" . toupper( s:attributeName ) . ",\n"
                  let s:namesList .= "   \"" . substitute( s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName, "^_", "", "" ) . "\",\n"
                  let s:conflationIndex .= "   " . toupper( s:associatedObject ) . "_CONFLATION_INDEX" . toupper( s:currentPrefixe ) . toupper( s:currentPrefixeObject ) . "_" . toupper( s:attributeName ) . ",\n"
               endif
            else
               let s:attributeName = substitute( substitute( substitute( s:currentLine, " ", "", "g" ), "\\(prefixe\\|\\)\\(,\\|)\\).*", "", "" ), "\\(_TYPED\\|\\)_HSTR(\\(prefixe##\\|\\)", "", "" )
            endif

            if ( s:currentObject != 0 )
               let s:tempCurrentPrefixe = s:currentPrefixe . s:currentPrefixeObject
               let s:tempCurrentPrefixeObject = substitute( s:currentLine, ".*##", "", "" )

               if ( s:tempCurrentPrefixeObject == s:currentLine )
                  let s:tempCurrentPrefixeObject = ""
               else
                  let s:tempCurrentPrefixeObject = substitute( s:tempCurrentPrefixeObject, "\\(,\\| \\).*", "", "" )
               endif

               let s:ancestorDefinition = { "prefixe": s:tempCurrentPrefixe, "realPrefixe": s:tempCurrentPrefixeObject, "type": s:currentType, "associated": s:usedObject }
               call add( s:objectListAdded, s:ancestorDefinition )
            elseif ( s:currentType == "char" )
               if ( s:currentArray != s:currentLine )
                  let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"
                  let s:bufferInitDeclare[ "stringLimited_data_ObjectDescription" ] = "initStringLimited"
                  let s:bufferInit .= "   initStringLimited = (stringLimited_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initStringLimited,\n"
                  let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initStringLimited,\n"
                  let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_LIMITED_SETSIZE( initStringLimited,\n"
                  let s:bufferInit .= "                                                  " . substitute( substitute( s:currentArray, "\\[ *", "", "" ), " *\\].*", "", "" ) . " );\n"
                  let s:bufferOffset .= " + sizeof( stringLimited_data_ObjectDescription )"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_STRING_LIMITED,\n"
               else
                  let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "char" ) . ", \\\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_BYTE,\n"
               endif
            elseif ( s:currentType == "uchar" )
               if ( s:currentArray != s:currentLine )
                  let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"
                  let s:bufferInitDeclare[ "stringLimited_data_ObjectDescription" ] = "initStringLimited"
                  let s:bufferInit .= "   initStringLimited = (stringLimited_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initStringLimited,\n"
                  let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initStringLimited,\n"
                  let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_LIMITED_SETSIZE( initStringLimited,\n"
                  let s:bufferInit .= "                                                  " . substitute( substitute( s:currentArray, "\\[ *", "", "" ), " *\\].*", "", "" ) . " );\n"
                  let s:bufferOffset .= " + sizeof( stringLimited_data_ObjectDescription )"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_STRING_LIMITED,\n"
               else
                  let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uchar" ) . ", \\\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UBYTE,\n"
               endif
            elseif ( s:currentArray != s:currentLine )
               if ( s:currentType != "typeAttribute_data_ObjectDescription" )
                  let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_VECTOR,\n"
                  let s:bufferInitDeclare[ "vector_data_ObjectDescription" ] = "initVector"
                  let s:currentType = substitute( s:currentType, "\\*.*", "", "" )

                  let s:currentArray = substitute( s:currentArray, "\\][^\\]]*$", "]", "" )

                  while ( s:currentArray > "" )
                     let s:nbElements = substitute( substitute( s:currentArray, " *\\].*$", "", "" ), " *\\[ *", "", "" )
                     let s:currentArray = substitute( s:currentArray, "[^\\]]*] *", "", "" )

                     let s:bufferInit .= "   initVector = (vector_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                     let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETNBELEMENTS( initVector,\n"
                     let s:bufferInit .= "                                                " . s:nbElements . " );\n"
                     let s:bufferOffset .= " + sizeof( vector_data_ObjectDescription )"

                     if ( s:currentArray == "" )
                        if ( s:currentType == "char" )
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                           let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"

                           if ( s:pointerType > "" )
                              let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                              let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_STRING );\n"

                              let s:bufferInitDeclare[ "string_data_ObjectDescription" ] = "initString"
                              let s:bufferInit .= "   initString = (string_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initString,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initString,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                              let s:bufferOffset .= " + sizeof( string_data_ObjectDescription )"
                           else
                              let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                              let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_BYTE );\n"
                           endif
                        elseif ( s:currentType == "uchar" )
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                           let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"

                           if ( s:pointerType > "" )
                              let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                              let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_STRING );\n"

                              let s:bufferInitDeclare[ "string_data_ObjectDescription" ] = "initString"
                              let s:bufferInit .= "   initString = (string_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initString,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initString,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                              let s:bufferOffset .= " + sizeof( string_data_ObjectDescription )"
                           else
                              let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                              let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                              let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_UBYTE );\n"
                           endif
                        elseif ( s:currentType == "short" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_SHORT );\n"
                        elseif ( s:currentType == "ushort" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_USHORT );\n"
                        elseif ( s:currentType == "int32" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_INT32 );\n"
                        elseif ( s:currentType == "uint32" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_UINT32 );\n"
                        elseif ( s:currentType == "int64" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_INT64 );\n"
                        elseif ( s:currentType == "uint64" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_UINT64 );\n"
                        elseif ( s:currentType == "double" )
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_" . s:currentDateTime . "DOUBLE );\n"
                        elseif ( s:currentType == "allValues_data_ObjectDescription" )
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_ALLVALUES );\n"

                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"

                              let s:currentType = substitute( s:currentType, "\\*.*", "", "" )
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInitDeclare[ "all_data_ObjectDescription" ] = "initVariable"
                           let s:bufferInit .= "   initVariable = (all_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_ALL_SETOFFSETVALUE( initVariable,\n"
                           let s:bufferInit .= "                                              (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_ALL_SETOFFSETTYPE( initVariable,\n"
                           let s:bufferInit .= "                                             (offset_data_ObjectDescription)" . VM_BuildNamedAttributeOffset( substitute( s:attributeName, "value", "type", "" ) ) . " );\n"

                           let s:bufferOffset .= " + sizeof( all_data_ObjectDescription )"
                        else
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          " . VM_ComputeTypeObject( s:currentType ) . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                           let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:isDynamic = 0

                           if ( s:pointerType > "" )
                              let s:dynamicLine = substitute( s:currentLines[ s:lineNumber - 2 ], ".* Dynamic : ", "", "" )
                              let s:isDynamic = ( s:dynamicLine != s:currentLines[ s:lineNumber - 2 ] )

                              if ( s:isDynamic != 0 )
                                 let s:bufferInitDeclare[ "dynamicObject_data_ObjectDescription" ] = "initObject"
                                 let s:bufferInit .= "   initObject = (dynamicObject_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                                 let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_DYNAMICOBJECT_SETDYNOBJECTDESC( initObject,\n"
                                 let s:bufferInit .= "                                                          (data_DynamicObject*)(" . s:dynamicLine . ") );\n"
                                 let s:bufferOffset .= " + sizeof( dynamicObject_data_ObjectDescription )"
                              else " End IF we are using a dynamic object definition
                                 let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = "initObject"
                                 let s:bufferInit .= "   initObject = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                                 let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( initObject,\n"
                                 let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                                 let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                              endif " End IF we are using a defined object

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = "initObject"
                              let s:bufferInit .= "   initObject = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( initObject,\n"
                              let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                              let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                           endif

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initObject,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                        endif
                     else
                        let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                        let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                        let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                        let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                        let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                        let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_VECTOR );\n"
                     endif
                  endwhile
               endif " End IF the current type is attribute type definition value
            elseif ( s:currentType == "char*" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "char*" ) . ", \\\n"

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
               let s:bufferInitDeclare[ "string_data_ObjectDescription" ] = "initString"
               let s:bufferInit .= "   initString = (string_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initString,\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initString,\n"
               let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
               let s:bufferOffset .= " + sizeof( string_data_ObjectDescription )"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_STRING,\n"
            elseif ( s:currentType == "uchar*" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uchar*" ) . ", \\\n"

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
               let s:bufferInitDeclare[ "string_data_ObjectDescription" ] = "initString"
               let s:bufferInit .= "   initString = (string_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initString,\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initString,\n"
               let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
               let s:bufferOffset .= " + sizeof( string_data_ObjectDescription )"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_STRING,\n"
            elseif ( s:currentType == "short" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "short" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_SHORT,\n"
            elseif ( s:currentType == "ushort" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "ushort" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_USHORT,\n"
            elseif ( s:currentType == "int32" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "int32" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_INT32,\n"
            elseif ( s:currentType == "uint32" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uint32" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UINT32,\n"
            elseif ( s:currentType == "int64" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "int64" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_INT64,\n"
            elseif ( s:currentType == "uint64" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uint64" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UINT64,\n"
            elseif ( s:currentType == "double" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "double" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_" . s:currentDateTime . "DOUBLE,\n"
            elseif ( s:currentType == substitute( s:currentType, "\\*.*", "", "" ) )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( s:currentType ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_<@SPECIFIC_TYPE " . s:currentType . "@>,\n"
            elseif ( s:currentType == "allValues_data_ObjectDescription" )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( s:currentType ) . ", \\\n"

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
               let s:bufferInitDeclare[ "all_data_ObjectDescription" ] = "initVariable"
               let s:bufferInit .= "   initVariable = (all_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_ALL_SETOFFSETVALUE( initVariable,\n"
               let s:bufferInit .= "                                              (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_ALL_SETOFFSETTYPE( initVariable,\n"
               let s:bufferInit .= "                                             (offset_data_ObjectDescription)" . VM_BuildNamedAttributeOffset( substitute( s:attributeName, "value", "type", "" ) ) . " );\n"
               let s:bufferOffset .= " + sizeof( all_data_ObjectDescription )"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_ALLVALUES,\n"
            elseif ( VM_CheckIgnoredType( s:currentType, 0 ) == 0 )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( s:currentType ) . ", \\\n"

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"

               let s:dynamicLine = substitute( s:currentLines[ s:lineNumber - 2 ], ".* Dynamic : ", "", "" )
               let s:isDynamic = ( s:dynamicLine != s:currentLines[ s:lineNumber - 2 ] )

               if ( s:isDynamic != 0 )
                  let s:bufferInitDeclare[ "dynamicObject_data_ObjectDescription" ] = "initObject"
                  let s:bufferInit .= "   initObject = (dynamicObject_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_DYNAMICOBJECT_SETDYNOBJECTDESC( initObject,\n"
                  let s:bufferInit .= "                                                          (data_DynamicObject*)(" . s:dynamicLine . ") );\n"
                  let s:bufferOffset .= " + sizeof( dynamicObject_data_ObjectDescription )"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_DYNAMICOBJECT,\n"
               else " End IF the object is a dynamic one
                  let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = "initObject"
                  let s:bufferInit .= "   initObject = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( initObject,\n"
                  let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                  let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                  let s:typeValues .= "   " . VM_ComputeTypeObject( s:currentType ) . ",\n"
               endif " End IF the object is a standand one

               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initObject,\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
               let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
            endif
         endif
      endif

      let s:lineNumber += 1
   endwhile

   let s:usedObject = ""
   let s:currentDateTime = ""
endwhile " End WHILE all the files had been gotten

if ( s:bufferInit > "" )
   let s:bufferInitFirst = ""
   let s:bufferInitSeparator = ""

   for [typeName, varName] in items( s:bufferInitDeclare )
      let s:bufferInitFirst .= s:bufferInitSeparator . "register " . typeName . "* " . varName . ";\n"
      let s:bufferInitSeparator = "   "
   endfor

   let s:bufferInit = s:bufferInitFirst . "\n" . s:bufferInit . "   "

   let s:bufferName = "buffer_" . s:className
   let s:bufferDeclare = "/**\n * The buffer where the specific definitions are stored\n*/\nstatic char " . s:bufferName . "[ " . toupper( s:className ) . "_SPECIFIC_BUFFER_SIZE ];\n\n"
   let s:bufferSize = "#define " . toupper( s:className ) . "_SPECIFIC_BUFFER_SIZE  ( " . s:bufferOffset . " )\n\n"
endif

if ( s:typeValues > "" )
   let s:lenCRLF = len( "\n" ) + 1
   let s:typeValues = strpart( s:typeValues, 0, len( s:typeValues ) - s:lenCRLF )
   let s:offsetValues = strpart( s:offsetValues, 0, len( s:offsetValues ) - s:lenCRLF )
   let s:namesList = strpart( s:namesList, 0, len( s:namesList ) - s:lenCRLF )
   let s:conflationOffset = strpart( s:conflationOffset, 0, len( s:conflationOffset ) - ( s:lenCRLF + 2 ) )

   if ( s:ownConflation != 0 )
      let s:conflationSize = toupper( s:associatedObject ) . "_CONFLATION_INDEX_LAST"
      let s:conflationIndexName = "conflation_" . s:className
      let s:conflationIndexDeclaration = "\n/**\n * The conflation index of the attributes\n*/\nstatic index_data_ObjectDescription " . s:conflationIndexName . "[] =\n{\n"
      let s:conflationIndexDeclaration .= strpart( s:conflationIndex, 0, len( s:conflationIndex ) - s:lenCRLF ) . "\n};\n"
      let s:conflationSwitch = "   switch ( index ) \\\n   { \\\n" . s:conflationSwitch . "      default: \\\n\\\n         defaultAction \\\n\\\n         break; \\\n   } /* End SWITCH on the conflated index */"
      let s:conflationType = "DATA_RIGHTDEFINITION_CONFLATION_VALUE | "
   endif
endif

call VM_AddDescGlobal( s:className )

let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_TYPE" ] = substitute( s:associatedObject, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_FOLDER" ] = substitute( s:associatedFolder, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_INCLUDE" ] = substitute( VM_BuildIncludeList( s:baseIncludes ), "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_OFFSET_VALUE_LIST" ] = substitute( s:offsetValues, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_TYPE_VALUE_LIST" ] = substitute( s:typeValues, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_NAME_VALUE_LIST" ] = substitute( s:namesList, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_DECLARE" ] = substitute( s:bufferDeclare, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_INIT" ] = substitute( s:bufferInit, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_NAME" ] = substitute( s:bufferName, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_SIZE" ] = substitute( s:bufferSize, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_INDEX_LIST" ] = substitute( s:indexesList, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_INDEX_LIST" ] = substitute( s:conflationIndex, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_OFFSET_LIST" ] = substitute( s:conflationOffset, "\\\n", "\\\\", "g" )
let g:VM_additionnalValues[ "CONFLATION_POSITION" ] = substitute( s:conflationPosition, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_SIZE" ] = substitute( s:conflationSize, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_INDEX_NAME" ] = substitute( s:conflationIndexName, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_INDEX_DECLARATION" ] = substitute( s:conflationIndexDeclaration, "\n", "", "g" )
let g:VM_additionnalValues[ "CONFLATION_SWITCH_FUNCTION" ] = substitute( s:conflationSwitch, "\\\n", "\\\\", "g" )
let g:VM_additionnalValues[ "CONFLATION_TYPE" ] = s:conflationType
let g:VM_additionnalValues[ "VALUE_TYPE" ] = toupper( s:typeValue )
let g:VM_additionnalValues[ "FACTORY_INIT" ] = s:factoryInit

tabnew

" Construit le fichier de corps de class
"---------------------------------------
call VM_ProjectBuildFile( "edit", s:className, "c_desc", s:comment, s:className . ".c", s:repository, s:projectFolder )

if ( search( "^#include <stddef.h>$", "w" ) > 0 )
   +2
   ,/^$/-1 sort
   write
endif

" Construit le fichier d'accessors
"---------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "mac_desc", s:comment, s:className . ".mac", s:repository, s:projectFolder )

" Construit le fichier d'entête de class
"---------------------------------------
call VM_ProjectBuildFile( "vsplit", s:className, "h_desc", s:comment, s:className . ".h", s:repository, s:projectFolder )

" Construit le fichier de type
"-----------------------------
call VM_ProjectBuildFile( "split", s:className, "typ_desc", s:comment, s:className . ".typ", s:repository, s:projectFolder )

" Construit le fichier de structure
"----------------------------------
call VM_ProjectBuildFile( "split", s:className, "str_desc", s:comment, s:className . ".str", s:repository, s:projectFolder )

" Construit le fichier de conflation
"-----------------------------------
if ( s:ownConflation != 0 )
   wincmd h
   call VM_ProjectBuildFile( "split", s:associatedObject, "conf_desc", substitute( s:comment, "Description", "Conflation definitions", "" ), s:associatedObject . ".cflt", s:associatedFolder, s:projectFolder )
   wincmd l
endif

wincmd =

delfunction VM_CheckIgnoredType
delfunction VM_ComputeTypeObject
delfunction VM_BuildConflationOffset
delfunction VM_BuildConflationSwitch
delfunction VM_BuildAttributeOffset
delfunction VM_GetFolderInclude
delfunction VM_FindStructuredFile
delfunction VM_BuildIncludeList
delfunction VM_AddInclude

if ( s:deleteFunctionAddDesc != 0 )
   delfunction VM_AddDescGlobal
endif

"---< Fin de fichier >----------------------------------------------------------

