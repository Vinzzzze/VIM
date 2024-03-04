" Fichier : cdesc.vim
"
" But : Initialize the class description
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
         call append( line( "$" ) - 1, "   /* " . a:classAdd . " */ " . toupper( a:classAdd ) . "_IDENTIFIER," )

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

if ( exists( "*VM_BuildIncludeFactory" ) == 0 )

" Fonction : VM_BuildIncludeFactory
"
" But : Build the include file about the factory
"
" Parameters :
"    factoryInclude - the factory include
" Retour :
"    The include code
"-------------------------------------------------------------------------------
function VM_BuildIncludeFactory( factoryInclude )
   let includeCode = ""

   if ( a:factoryInclude > "" )
      let includeCode = "#ifndef FACT_COMMANDREMOTE_USE_EXPORT\n#include \"" . a:factoryInclude . ".h\"\n#else\n#include \"" . a:factoryInclude . "Export.h\"\n#endif\n"
   endif " End IF the factory include is defined

   return includeCode
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
"     nameAttribute - The name of the attribute for which we want the offset
" Retour :
"     The offset's named attribute
"-------------------------------------------------------------------------------
function VM_BuildNamedAttributeOffset( nameAttribute )
   return "( (char*)\\&( " . VM_BuildAttributeAccessor( a:nameAttribute, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", ( (" . s:associatedObject . "*)NULL ) ) ) - (char*)NULL )"
endfunction

endif

if ( exists( "*VM_BuildAddressObject" ) == 0 )

" Fonction : VM_BuildAddressObject
"
" But : Build the offset for a named attribute
"
" Retour :
"     The offset's named attribute
"-------------------------------------------------------------------------------
function VM_BuildAddressObject()
   return "( (char*)( " . VM_BuildAddressAttribute() . "( " . VM_BuildPrefixeAttribute() . ", ( (" . s:associatedObject . "*)NULL ) ) ) - (char*)NULL )"
endfunction

endif

if ( exists( "*VM_BuildAttributeAccessor" ) == 0 )

" Fonction : VM_BuildAttributeAccessor
"
" But : Build the accessor to the attribute
"
" Parametres :
"     nameAttribute - The name of the attribute for which we want the offset
"     typeAccessor - The accessor type ( get or set )
" Retour :
"     The accessor name
"-------------------------------------------------------------------------------
function VM_BuildAttributeAccessor( nameAttribute, typeAccessor )
   return toupper( s:usedObject ) . "_PREFIXED_" . a:typeAccessor . toupper( a:nameAttribute )
endfunction

endif

if ( exists( "*VM_BuildAddressAttribute" ) == 0 )

" Fonction : VM_BuildAddressAttribute
"
" But : Build the name of the attribute address.
"
" Retour :
"     The attribute's offset
"-------------------------------------------------------------------------------
function VM_BuildAddressAttribute()
   return toupper( s:currentType ) . "_PREFIXED_GETADDRFIRSTFIELD"
endfunction

endif

if ( exists( "*VM_BuildPrefixeAttribute" ) == 0 )

" Fonction : VM_BuildPrefixeAttribute
"
" But : Build the prefixe for the attribute.
"
" Retour :
"     The attribute's prefixe
"-------------------------------------------------------------------------------
function VM_BuildPrefixeAttribute()
   return "std" . s:currentPrefixe . s:currentPrefixeObject
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
   if ( ( a:upper == 0 )&&( substitute( a:type, "^int_", "", "" ) != a:type ) )
      return 1
   " End IF we are on a pointer to an interface
   elseif ( ( a:upper == 0 )&&( substitute( a:type, "^fct[A-Z]", "", "" ) != a:type ) )
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

if ( exists( "*VM_BuildEnumName" ) == 0 )

" Fonction : VM_BuildEnumName
"
" But : Build the enum associated to the variable name.
"
" Parametres :
"     baseVariable - string : The variable base name
" Retour :
"     The enum built
"-------------------------------------------------------------------------------
function VM_BuildEnumName( baseVariable )
   return "[@ELEMENT_MACRO@]_PARAM_" . toupper( a:baseVariable )
endfunction

endif

if ( exists( "*VM_BuildVariableName" ) == 0 )

" Fonction : VM_BuildVariableName
"
" But : Build the variable name for usage in the init function.
"
" Parametres :
"     baseVariable - string : The base name for the variable to be created
"     isData - bool : false if the variable to be created is for checking the parameter set, another value for the data variable
" Retour :
"     The variable name
"-------------------------------------------------------------------------------
function VM_BuildVariableName( baseVariable, isData )
   if ( a:isData == 0 )
      return a:baseVariable . "_def"
   endif " End IF we want a definition variable

   return a:baseVariable . "_data"
endfunction

endif

if ( exists( "*VM_BuildInitializationParameter" ) == 0 )

" Fonction : VM_BuildInitializationParameter
"
" But : Build the code used to initialize the specified attribute.
"
" Parametres :
"     currentParam - The parameter for which the initialisation had to be made
"-------------------------------------------------------------------------------
function VM_BuildInitializationParameter( currentParam )
   let initValue = substitute( a:currentParam.noParam, "\\[@ASSOCIATED_OBJECT_MACRO@\\]", toupper( s:associatedObject ), "g" )
   
   if ( initValue == "" && a:currentParam.variable > "" )
      let initValue = VM_BuildVariableName( a:currentParam.variable, 1 )
   endif " End IF there is no initial value and a variable name

   if ( a:currentParam.fctInit == "setter" )
      let s:associatedObjectInit .= "      " . a:currentParam.address . initValue . " );\n"
   " End IF the currnet attribute is initialized with the setter
   elseif ( a:currentParam.fctInit == "string" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register char* destination = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register char* source = " . initValue . ";\n"
      let s:associatedObjectInit .= "         register int32 sizeCopy = ( " . a:currentParam.size . " );\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            BASE_STRINGUTIL_LIMITED_COPY( source,\n"
      let s:associatedObjectInit .= "                                          destination,\n"
      let s:associatedObjectInit .= "                                          sizeCopy );\n\n"
      let s:associatedObjectInit .= "            *destination = 0;\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   " End IF the currnet attribute is initialized with the string
   elseif ( a:currentParam.fctInit == "vector" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register heap_Vector* vectorInit = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register heap_Vector* source = " . initValue . ";\n\n"
      let s:associatedObjectInit .= "         HEAP_VECTOR_INIT( vectorInit,\n"
      let s:associatedObjectInit .= "                           allocatePage_fact_CommandExport,\n"
      let s:associatedObjectInit .= "                           freePages_fact_CommandExport,\n"
      let s:associatedObjectInit .= "                           (heap_PageAllocator*)FACT_COMMANDEXPORT_GETALLOCATOR( factory ),\n"
      let s:associatedObjectInit .= "                           " . a:currentParam.sizeElement . ",\n"
      let s:associatedObjectInit .= "                           ( " . a:currentParam.sizeElement . " >= sizeof( void* ) ),\n"
      let s:associatedObjectInit .= "                           NULL\n"
      let s:associatedObjectInit .= "                           NULL\n"
      let s:associatedObjectInit .= "                           0 );\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            copy_heap_Vector( vectorInit,\n"
      let s:associatedObjectInit .= "                              source );\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   " End IF the currnet attribute is initialized with the vector
   elseif ( a:currentParam.fctInit == "bytes" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register uchar* destination = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register uchar* source = " . initValue . ";\n"
      let s:associatedObjectInit .= "         register int32 sizeCopy = ( " . a:currentParam.size . " );\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            BASE_MEMORY_COPY_MEMORY( source,\n"
      let s:associatedObjectInit .= "                                     destination,\n"
      let s:associatedObjectInit .= "                                     sizeCopy );\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   " End IF the currnet attribute is initialized with the bytes
   elseif ( a:currentParam.fctInit == "array" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " destination = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " source = " . initValue . ";\n"
      let s:associatedObjectInit .= "         register int32 sizeCopy = ( " . a:currentParam.size . " );\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            BASE_MEMORY_COPY_MEMORY( source,\n"
      let s:associatedObjectInit .= "                                     destination,\n"
      let s:associatedObjectInit .= "                                     sizeCopy );\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   " End IF the currnet attribute is initialized with the array
   elseif ( a:currentParam.fctInit == "arrayPointer" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " destination = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " source = " . initValue . ";\n"
      let s:associatedObjectInit .= "         register int32 sizeCopy = ( " . a:currentParam.size . " );\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            BASE_MEMORY_COPY_MEMORY( source,\n"
      let s:associatedObjectInit .= "                                     destination,\n"
      let s:associatedObjectInit .= "                                     sizeCopy );\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   " End IF the currnet attribute is initialized with the array pointer
   elseif ( a:currentParam.fctInit == "arrayElement" )
      let s:associatedObjectInit .= "      {\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " destination = " . a:currentParam.address . ";\n"
      let s:associatedObjectInit .= "         register " . a:currentParam.type . " source = " . initValue . ";\n"
      let s:associatedObjectInit .= "         register int32 sizeElement = " . a:currentParam.sizeElement . ";\n\n"
      let s:associatedObjectInit .= "         if ( " . initValue . " != NULL )\n"
      let s:associatedObjectInit .= "         {\n"
      let s:associatedObjectInit .= "            register int32 nbElement;\n\n"
      let s:associatedObjectInit .= "            for ( nbElement = ( " . a:currentParam.size . " );\n"
      let s:associatedObjectInit .= "                  nbElement-- > 0;\n"
      let s:associatedObjectInit .= "                  ++destination,\n"
      let s:associatedObjectInit .= "                  ++source )\n"
      let s:associatedObjectInit .= "            {\n"
      let s:associatedObjectInit .= "               register char* destinationObject = (char*)destination;\n"
      let s:associatedObjectInit .= "               register char* sourceObject = (char*)source;\n"
      let s:associatedObjectInit .= "               register int32 sizeCopy = sizeElement;\n\n"
      let s:associatedObjectInit .= "               BASE_MEMORY_COPY_MEMORY( sourceObject,\n"
      let s:associatedObjectInit .= "                                        destinationObject,\n"
      let s:associatedObjectInit .= "                                        sizeCopy );\n"
      let s:associatedObjectInit .= "            }\n"
      let s:associatedObjectInit .= "         }\n"
      let s:associatedObjectInit .= "      }\n"
   endif " End IF the current attribute is initialized with the array element
endfunction

endif

if ( exists( "*VM_BuildParamList" ) == 0 )

" Fonction : VM_BuildParamList
"
" But : Build the param list for the variable declaration.
"
" Parametres :
"     paramList - The parameter list dicttionary
" Retour :
"     The string for the command parameter list
"-------------------------------------------------------------------------------
function VM_BuildParamList( paramList )
   for currentParamDef in values( a:paramList )
      if ( currentParamDef.noParam == "" && currentParamDef.variable > "" )
         let s:parameterListDeclaration .= "   register " . currentParamDef.type . " " . VM_BuildVariableName( currentParamDef.variable, 1 )

         if ( currentParamDef.defaultValue == "" )
            let s:parameterListDeclaration .= ";\n   register ushort " . VM_BuildVariableName( currentParamDef.variable, 0 ) . " = false;\n"
         else " End IF there is no default value
            let s:parameterListDeclaration .= " = " . currentParamDef.defaultValue . ";\n"
         endif " End IF the current variable has a default value
      endif " End IF the current param is a param to read

      call VM_BuildInitializationParameter( currentParamDef )
   endfor " End FOR all the param definition
endfunction

endif

if ( exists( "*VM_BuildCaseList" ) == 0 )

" Fonction : VM_BuildCaseList
"
" But : Build the case list with the code initialisation.
"
" Parametres :
"     caseList - The enum list
"     paramList - The parameter list dictionary
"-------------------------------------------------------------------------------
function VM_BuildCaseList( caseList, paramList )
   let assignEnum = " = BASE_COMMANDREMOTE_PARAM_LAST"
   for currentEnum in a:caseList
      let s:enumListDeclaration .= "   " . VM_BuildEnumName( currentEnum ) . assignEnum . ",\n"
      let assignEnum = ""

      let s:parameterListCase .= "         case " . VM_BuildEnumName( currentEnum ) . ":\n\n"
      let currentDefinition = a:paramList[ currentEnum ]

      if ( currentDefinition.defaultValue == "" )
         let s:parameterListCase .= "            " . VM_BuildVariableName( currentDefinition.variable, 0 ) . " = true;\n"
         call add( s:conditionParamList, VM_BuildVariableName( currentDefinition.variable, 0 ) )
      endif " End IF there is no default value

      let s:parameterListCase .= "            " . VM_BuildVariableName( currentDefinition.variable, 1 ) . " = va_arg( params, " . currentDefinition.type . " );\n\n            break;\n"
   endfor " End FOR all the case element
endfunction

endif

if ( exists( "*VM_BuildConditionParam" ) == 0 )

" Fonction : VM_BuildConditionParam
"
" But : Build the condition to check that all the needed parameters had been
"       set.
"
" Parametres :
"     checkedParam - the list of the parameters to be checked
"-------------------------------------------------------------------------------
function VM_BuildConditionParam( checkedParam )
   if ( len( a:checkedParam ) > 0 )
      let separator = ""
      let s:conditionCheck = "   if (  "

      for currentParam in a:checkedParam
         let s:conditionCheck .= separator . "( " . currentParam . " == false )"
         let separator = "\n       ||"
      endfor " End FOR all the params to be checked

      let s:conditionCheck .= "  )\n"
      let s:conditionCheck .= "   {\n"
      let s:conditionCheck .= "      retValue = MISSING_MANDATORY_FACT_COMMANDEXPORT;\n"
      let s:conditionCheck .= "   } /* End IF some mandatory attributes are missing */\n"
      let s:conditionCheck .= "   else\n"
   endif " End IF there are some parameter to check
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Initialize la liste des classe à ignorer
"-----------------------------------------
if ( exists( "g:VM_classListToIgnore" ) == 0 )
   let g:VM_classListToIgnore = [ "base_Command", "typeAttribute_base_ObjectDescription", "heap_Allocator", "base_DynamicObjectDefinition" ]
endif " End IF the class list is not known
if ( exists( "g:VM_baseTypeAdditional" ) == 0 )
   let g:VM_baseTypeAdditional = { "DATA_RIGHTDEFINITION_TYPE_SOURCE": "DATA_RIGHTDEFINITION_TYPE_OBJECTDESCRIPTION_SOURCE", "BASE_CONFLATIONOBJECT_DEFAULT_TYPE": "BASE_CONFLATIONOBJECT_OBJECTDESCRIPTION_DEFAULT_TYPE" }
endif " End IF the class list is not known

" Recupere la definition de la classe associée
"---------------------------------------------
let s:associatedObject = expand( "%:t:r" )
let s:associatedFolder = expand( "%:h:t" )
let s:projectFolder = expand( "%:h:h" )

" Recupère le nom de la classe à créer
"-------------------------------------
let s:baseClassName = substitute( s:associatedObject, "[^_]*_", "desc_", "" )
let s:typeClassName = substitute( s:associatedObject, "_.*", "", "" )

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
let s:repository = VM_SelectFolder( s:baseClassName, s:projectFolder )
let s:extentionClass = ""

while ( ( VM_ProjectTestFileExists( s:baseClassName . s:extentionClass . ".c", s:repository, s:projectFolder ) != 0 )||( s:typeClassName == "cmd" && VM_ProjectTestFileExists( s:baseClassName . "NoId" . s:extentionClass . ".c", s:repository, s:projectFolder ) ) )
   let s:extentionClass = input( "File " . s:baseClassName . s:extentionClass . ".c already extists, give an other class name update : " )

   if ( s:extentionClass == "" )
      finish
   endif
endwhile

let s:className = s:baseClassName . s:extentionClass
let s:currentLines = [ "" ] + readfile( expand( "%" ) )

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = "Decription of " . substitute( s:currentLines[ 5 ], "^ \\+\\* \\+", "", "" )

let s:noParamDefinition = ".* NoParam : "
let s:defaultValueDefinition = ".* Default : "
let s:sizeVectorDefinition = ".* size : "
let s:dynamicValueDefinition = ".* Dynamic : "

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
let s:identifierUsage = "NULL"
let s:factoryInit = "NULL"
let s:dynamicInit = ""
let s:searchFactory = 1
let s:currentDateTime = ""
let s:factoryType = ""
let s:factoryInclude = ""
let s:parameterListDeclaration = ""
let s:parameterListCase = ""
let s:associatedObjectInit = ""
let s:enumListDeclaration = ""
let s:parameterListName = []
let s:parameterListDictionary = {}
let s:conditionCheck = ""
let s:conditionParamList = []

if ( s:typeClassName == "cmd" )
   let s:typeValue = "COMPLETE"
   let s:useIdentifier = "N"
else " End IF we are on a command, set the default values
   let s:typeValue = input( "Type description ( PUBLIC | RT | SNAPSHOT | BASE | BOOK | COMPLETE ) : " )
   let s:useIdentifier = input( "Identifier usage ( default is no ) : " )

   if ( s:useIdentifier == "Y" )
      let s:identifierUsage = toupper( s:baseClassName ) . "IDENTIFIER_DEFAULT"
      let s:baseIncludes[ "DESCRIPTION/" . s:baseClassName ] = "DESCRIPTION/" . s:baseClassName . "Identifier"
   endif " End IF the identifier need to be used

   if ( s:associatedObject == "data_DateTime" )
      let s:currentDateTime = "DATETIME_"
   endif " End IF we are exporting the datetime definition
endif " End IF on a regular export, ask for the values

while ( ( s:usedObject > "" )||( len( s:objectListAdded ) > 0 ) )
   let s:lineNumber = 1

   if ( len( s:objectListAdded ) > 0 )
      let s:searchFactory = 0
      let s:lineNumber = 15
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
      let s:usedObject = substitute( substitute( s:filename, ".*/", "", "" ), "\\(\\|_export\\)\\..*", "", "" )
      let s:folderFilename = substitute( s:filename, "/[^/]*$", "", "" )
      let s:folderInclude = VM_GetFolderInclude( s:folderFilename )

      let s:baseIncludes[ s:folderInclude . s:usedObject ] = s:folderInclude . s:usedObject
   endif " End IF there is an object to read

   let s:lastLine = len( s:currentLines ) - 1
   let s:defineFound = 0

   while ( ( s:defineFound == 0 )&&( s:lineNumber <= s:lastLine ) )
      let s:currentLine = s:currentLines[ s:lineNumber ]
      let s:defineFound = ( s:currentLine != substitute( s:currentLine, "^#define ", "", "" ) )

      if ( s:searchFactory > 0 )
         let s:factoryLine = substitute( s:currentLine, "^.* Factory : ", "", "" )

         if ( s:factoryLine != s:currentLine )
            let s:factoryInit = s:factoryLine
            let s:currentType = substitute( s:factoryInit, "^[a-zA-Z0-9]*_", "", "" )
            let s:factoryType = s:currentType
            let s:factoryInclude = VM_SelectFolder( s:currentType, s:projectFolder ) . "/" . substitute( s:currentType, "*", "", "g" )
            let s:baseIncludes[ toupper( s:factoryType ) ] = s:factoryInclude
         endif " End IF the factory had been found

         let s:dynamicLine = substitute( s:currentLine, "^.* Dynamic Desc : ", "", "" )

         if ( s:dynamicLine != s:currentLine )
            let s:dynamicInit = s:dynamicLine
         endif " End IF the factory had been found
      endif " End IF the factory initialitation had to be searched

      let s:lineNumber += 1
   endwhile

   while ( ( s:currentLine > "" )&&( s:lineNumber <= s:lastLine ) )
      let s:currentLine = s:currentLines[ s:lineNumber ]

      if ( ( s:currentLine != substitute( s:currentLine, "^   [A-Za-z]", "", "" ) )&&( s:currentLine == substitute( s:currentLine, "_noexport[; \\\\]*$", "", "" ) ) )
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

               if ( VM_CheckIgnoredType( s:currentType, 0 ) == 0 )
                  let s:indexesList .= "   " . toupper( s:className ) . "_INDEX" . toupper( s:currentPrefixe ) . toupper( s:currentPrefixeObject ) . "_" . toupper( s:attributeName ) . ",\n"
                  let s:namesList .= "   \"" . substitute( s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName, "^_", "", "" ) . "\",\n"
                  let s:conflationIndex .= "   " . toupper( s:associatedObject ) . "_CONFLATION_INDEX" . toupper( s:currentPrefixe ) . toupper( s:currentPrefixeObject ) . "_" . toupper( s:attributeName ) . ",\n"
               endif
            else
               let s:attributeName = substitute( substitute( substitute( s:currentLine, " ", "", "g" ), "\\(prefixe\\|\\)\\(,\\|)\\).*", "", "" ), "\\(_TYPED\\|\\)_HSTR(\\(prefixe##\\|\\)", "", "" )
            endif

            if ( s:currentType == "HEAP_VECTOR" )
               let s:tempCurrentPrefixeObject = substitute( s:currentLine, ".*##", "", "" )

               if ( s:tempCurrentPrefixeObject == s:currentLine )
                  let s:tempCurrentPrefixeObject = ""
               else
                  let s:tempCurrentPrefixeObject = substitute( s:tempCurrentPrefixeObject, "\\(,\\| \\).*", "", "" )
               endif

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"

               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 4 ], s:defaultValueDefinition, "", "" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 4 ], s:noParamDefinition, "", "" )
               let s:sizeElement = substitute( s:currentLines[ s:lineNumber - 3 ], s:sizeVectorDefinition, "", "" )
               let s:vectorLine = substitute( s:currentLines[ s:lineNumber - 2 ], ".* Vector : ", "", "" )
               let s:baseIncludes[ toupper( s:vectorLine ) ] = VM_SelectFolder( s:vectorLine, s:projectFolder ) . "/" . substitute( s:vectorLine, "*", "", "g" )
               let s:initObject = "initVectorObject" . s:tempCurrentPrefixeObject

               let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = s:initObject
               let s:bufferInit .= "   " . s:initObject . " = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( " . s:initObject . ",\n"
               let s:bufferInit .= "                                                \\&( " . toupper( s:vectorLine ) . "_DEFAULT ) );\n"
               let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
               let s:typeValues .= "   " . VM_ComputeTypeObject( s:currentType ) . ",\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( " . s:initObject . ",\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAddressObject() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( " . s:initObject . ",\n"
               let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 4 ] )
                  let s:variableName = "vector_" . s:usedObject . "_std" . s:currentPrefixe . s:currentPrefixeObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 4 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current vector is a parameter to be taken in account

               let s:parameterListDictionary[ "vector_" . s:usedObject . "_" . s:currentPrefixe . s:currentPrefixeObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : "heap_Vector*", "fctInit" : "vector", "sizeElement" : s:sizeElement, "address" : VM_BuildAddressAttribute() . "( " . VM_BuildPrefixeAttribute() . ", current )" }
            elseif ( s:currentObject != 0 )
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
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               if ( s:currentArray != s:currentLine )
                  let s:sizeArray = substitute( substitute( s:currentArray, "\\[ *", "", "" ), " *\\].*", "", "" )
                  let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : "char*", "fctInit" : "string", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                  let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"
                  let s:bufferInitDeclare[ "stringLimited_data_ObjectDescription" ] = "initStringLimited"
                  let s:bufferInit .= "   initStringLimited = (stringLimited_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initStringLimited,\n"
                  let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initStringLimited,\n"
                  let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_LIMITED_SETSIZE( initStringLimited,\n"
                  let s:bufferInit .= "                                                  " . s:sizeArray . " );\n"
                  let s:bufferOffset .= " + sizeof( stringLimited_data_ObjectDescription )"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_STRING_LIMITED,\n"
               else
                  let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : "char", "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
                  let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "char" ) . ", \\\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_BYTE,\n"
               endif
            elseif ( s:currentType == "uchar" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               if ( s:currentArray != s:currentLine )
                  let s:sizeArray = substitute( substitute( s:currentArray, " *\\].*", "", "" ), "\\[ *", "", "" )
                  let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : "uchar*", "fctInit" : "bytes", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
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
                  let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : "uchar", "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
                  let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
                  let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uchar" ) . ", \\\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UBYTE,\n"
               endif
            elseif ( s:currentArray != s:currentLine )
               if ( s:currentType != "typeAttribute_base_ObjectDescription" )
                  let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_VECTOR,\n"
                  let s:bufferInitDeclare[ "vector_data_ObjectDescription" ] = "initVector"
                  let s:currentType = substitute( s:currentType, "\\*.*", "", "" )

                  let s:sizeArray = substitute( substitute( s:currentArray, " *\\].*", "", "" ), "\\[ *", "", "" )

                  while ( s:currentArray > "" )
                     let s:nbElements = substitute( substitute( s:currentArray, " *\\].*$", "", "" ), " *\\[ *", "", "" )
                     let s:currentArray = substitute( s:currentArray, "[^\\]]*] *", "", "" )

                     let s:bufferInit .= "   initVector = (vector_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                     let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETNBELEMENTS( initVector,\n"
                     let s:bufferInit .= "                                                " . s:nbElements . " );\n"
                     let s:bufferOffset .= " + sizeof( vector_data_ObjectDescription )"

                     if ( s:currentArray == "" )
                        if ( s:currentType == "char" )
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
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
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_" . s:currentDateTime . "DOUBLE );\n"
                        elseif ( s:currentType == "heap_Vector" )
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 3 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 3 ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - 3 ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 3 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          " . VM_ComputeTypeObject( s:currentType ) . " );\n"

                           if ( s:pointerType > "" )
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:vectorType = substitute( s:currentLines[ s:lineNumber - 2 ], ".* Vector : ", "", "" )
                           let s:bufferInit .= "   initObject = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"

                           let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = "initObject"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( initObject,\n"
                           let s:bufferInit .= "                                                \\&( " . s:vectorType . "_DEFAULT ) );\n"
                           let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"

                           if ( s:pointerType > "" )
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initObject,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                           endif

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initObject,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
                        elseif ( s:currentType == "allValues_data_ObjectDescription" )
                           let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )

                           if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                                 let s:defaultValue = ""
                              else " End IF there is no default value to use
                                 let s:noParam = substitute( s:currentLines[ s:lineNumber - 3 ], s:noParamDefinition, "", "" )

                                 if ( s:noParam == s:currentLines[ s:lineNumber - 3 ] )
                                    let s:noParam = ""
                                 endif " End IF the current attribute is a param
                              endif " End IF there is a default value to use
                           else " End IF the current attribute is a param
                              let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 3 ], s:defaultValueDefinition, "", "" )

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - 3 ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is not a param

                           let s:noParamType = substitute( s:noParam, " .*", "", "" )
                           let s:noParamValue = substitute( s:noParam, "[^ ]* ", "", "" )
                           let s:defaultType = substitute( s:defaultValue, " .*", "", "" )
                           let s:defaultValue = substitute( s:defaultValue, "[^ ]* ", "", "" )
                           let s:variableNameType = ""
                           let s:variableNameValue = ""

                           if ( s:noParamType == "" )
                              let s:variableNameType = s:currentPrefixe . s:currentPrefixeObject . "_" . substitute( s:attributeName, "value", "type", "" ) . "_" . s:usedObject
                              call add( s:parameterListName, s:variableNameType )
                           endif " End IF the type is a param

                           if ( s:noParamValue == "" )
                              let s:variableNameValue = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableNameValue )
                           endif " End IF the value is a param

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          BASE_OBJECTDESCRIPTION_TYPE_ALLVALUES );\n"

                           if ( s:pointerType > "" )
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . substitute( s:attributeName, "value", "type", "" ) . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParamType, "variable" : s:variableNameType, "defaultValue" : s:defaultType, "type" : "typeAttribute_base_ObjectDescription*", "fctInit" : "arrayPointer", "address" : VM_BuildAttributeAccessor( substitute( s:attributeName, "value", "type", "" ), "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParamValue, "variable" : s:variableNameValue, "defaultValue" : s:defaultValue, "type" : s:currentType . "*", "fctInit" : "arrayPointer", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . substitute( s:attributeName, "value", "type", "" ) . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParamType, "variable" : s:variableNameType, "defaultValue" : s:defaultType, "type" : "typeAttribute_base_ObjectDescription", "fctInit" : "array", "address" : VM_BuildAttributeAccessor( substitute( s:attributeName, "value", "type", "" ), "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParamValue, "variable" : s:variableNameValue, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "array", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }
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
                           let s:dynamicLine = substitute( s:currentLines[ s:lineNumber - 2 ], s:dynamicValueDefinition, "", "" )
                           let s:isDynamic = ( s:dynamicLine != s:currentLines[ s:lineNumber - 2 ] )
                           let s:paramLine = 2

                           if ( s.isDynamic != 0 )
                              let s:paramLine = 3
                           endif " End IF this is a dynamic definition

                           let s:noParam = substitute( s:currentLines[ s:lineNumber - s:paramLine ], s:noParamDefinition, "", "" )
                           let s:defaultValue = substitute( s:currentLines[ s:lineNumber - s:paramLine ], s:defaultValueDefinition, "", "" )
                           let s:variableName = ""

                           if ( s:noParam == s:currentLines[ s:lineNumber - s:paramLine ] )
                              let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                              call add( s:parameterListName, s:variableName )
                              let s:noParam = ""

                              if ( s:defaultValue == s:currentLines[ s:lineNumber - s:paramLine ] )
                                 let s:defaultValue = ""
                              endif " End IF there is no default value to use
                           endif " End IF the current attribute is a param

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( initVector,\n"
                           let s:bufferInit .= "                                            (offset_data_ObjectDescription)( " . s:bufferOffset . " ) );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_VECTOR_SETTYPE( initVector,\n"
                           let s:bufferInit .= "                                          " . VM_ComputeTypeObject( s:currentType ) . " );\n"
                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( initVector,\n"
                           let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"

                           let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ", \\\n"

                           let s:isDynamic = 0
                           let s:initObject = "initObject"

                           if ( s:pointerType > "" )
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType . "*" . s:pointerType, "fctInit" : "arrayPointer", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }

                              if ( s:isDynamic != 0 )
                                 let s:bufferInitDeclare[ "dynamicObject_data_ObjectDescription" ] = s:initObject
                                 let s:bufferInit .= "   " . s:initObject . " = (dynamicObject_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                                 let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_DYNAMICOBJECT_SETDYNOBJECTDESC( " . s:initObject . ",\n"
                                 let s:bufferInit .= "                                                          (data_DynamicObject*)(" . s:dynamicLine . ") );\n"
                                 let s:bufferOffset .= " + sizeof( dynamicObject_data_ObjectDescription )"
                                 let s:baseIncludes[ toupper( s:currentType ) ] = VM_SelectFolder( s:currentType, s:projectFolder ) . "/" . substitute( s:currentType, "*", "", "g" )
                              else " End IF we are using a dynamic object definition
                                 let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = s:initObject
                                 let s:bufferInit .= "   " . s:initObject . " = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                                 let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( " . s:initObject . ",\n"
                                 let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                                 let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                              endif " End IF we are using a defined object

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( " . s:initObject . ",\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
                           else
                              let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "size" : s:sizeArray, "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "sizeElement" : "sizeof( " . substitute( s:currentType, "\\*", "", "g" ) . " )", "type" : s:currentType . "*", "fctInit" : "arrayElement", "address" : VM_BuildAttributeAccessor( s:attributeName, "GET" ) . "( " . VM_BuildPrefixeAttribute() . ", current )" }

                              let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = s:initObject
                              let s:bufferInit .= "   " . s:initObject . " = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"

                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( " . s:initObject . ",\n"
                              let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_SUBOBJECT );\n"
                              let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( " . s:initObject . ",\n"
                              let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                              let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                           endif

                           let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( " . s:initObject . ",\n"
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

                     let s:sizeArray .= " * " . substitute( substitute( s:currentArray, " *\\].*", "", "" ), "\\[ *", "", "" )
                  endwhile
               endif " End IF the current type is attribute type definition value
            elseif ( s:currentType == "char*" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
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
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
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
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "short" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_SHORT,\n"
            elseif ( s:currentType == "ushort" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "ushort" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_USHORT,\n"
            elseif ( s:currentType == "int32" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "int32" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_INT32,\n"
            elseif ( s:currentType == "uint32" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uint32" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UINT32,\n"
            elseif ( s:currentType == "int64" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "int64" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_INT64,\n"
            elseif ( s:currentType == "uint64" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "uint64" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_UINT64,\n"
            elseif ( s:currentType == "double" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( "double" ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_" . s:currentDateTime . "DOUBLE,\n"
            elseif ( s:currentType == "allValues_data_ObjectDescription" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 2 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 2 ], s:defaultValueDefinition, "", "" )

               if ( s:noParam == s:currentLines[ s:lineNumber - 2 ] )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 2 ] )
                     let s:defaultValue = ""
                  else " End IF there is no default value to use
                     let s:noParam = substitute( s:currentLines[ s:lineNumber - 3 ], s:noParamDefinition, "", "" )

                     if ( s:noParam == s:currentLines[ s:lineNumber - 3 ] )
                        let s:noParam = ""
                     endif " End IF the current attribute is a param
                  endif " End IF there is a default value to use
               else " End IF the current attribute is a param
                  let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 3 ], s:defaultValueDefinition, "", "" )

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 3 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is not a param

               let s:noParamType = substitute( s:noParam, " .*", "", "" )
               let s:noParamValue = substitute( s:noParam, "[^ ]* ", "", "" )
               let s:defaultType = substitute( s:defaultValue, " .*", "", "" )
               let s:defaultValue = substitute( s:defaultValue, "[^ ]* ", "", "" )
               let s:variableNameType = ""
               let s:variableNameValue = ""

               if ( s:noParamType == "" )
                  let s:variableNameType = s:currentPrefixe . s:currentPrefixeObject . "_" . substitute( s:attributeName, "value", "type", "" ) . "_" . s:usedObject
                  call add( s:parameterListName, s:variableNameType )
               endif " End IF the type is a param

               if ( s:noParamValue == "" )
                  let s:variableNameValue = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableNameValue )
               endif " End IF the value is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . substitute( s:attributeName, "value", "type", "" ) . "_" . s:usedObject ] = { "noParam" : s:noParamType, "variable" : s:variableNameType, "defaultValue" : s:defaultType, "type" : "typeAttribute_base_ObjectDescription", "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( substitute( s:attributeName, "value", "type", "" ), "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParamValue, "variable" : s:variableNameValue, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
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
            elseif ( substitute( s:currentType, "\\*\+", "", "" ) == "heap_Vector" )
               let s:noParam = substitute( s:currentLines[ s:lineNumber - 3 ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - 3 ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - 3 ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - 3 ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }
               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"

               let s:vectorLine = substitute( s:currentLines[ s:lineNumber - 2 ], ".* Vector : ", "", "" )
               let s:baseIncludes[ toupper( s:vectorLine ) ] = VM_SelectFolder( s:vectorLine, s:projectFolder ) . "/" . substitute( s:vectorLine, "*", "", "g" )
               let s:initObject = "initVectorObject"

               let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = s:initObject
               let s:bufferInit .= "   " . s:initObject . " = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( " . s:initObject . ",\n"
               let s:bufferInit .= "                                                \\&( " . toupper( s:vectorLine ) . "_DEFAULT ) );\n"
               let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
               let s:typeValues .= "   " . VM_ComputeTypeObject( s:currentType ) . ",\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( " . s:initObject . ",\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( " . s:initObject . ",\n"
               let s:bufferInit .= "                                                    (short)BASE_OBJECTDESCRIPTION_ALLOCATEMODE_POINTER_ALLOCATE );\n"
            elseif ( has_key( g:VM_baseTypeAdditional, s:currentType ) )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( s:currentType ) . ", \\\n"
               let s:offsetValues .= "   (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . ",\n"
               let s:typeValues .= "   " . g:VM_baseTypeAdditional[ s:currentType ] . ",\n"
            elseif ( VM_CheckIgnoredType( s:currentType, 0 ) == 0 )
               let s:conflationOffset .= "   (offset_data_ObjectDescription)" . VM_BuildConflationOffset( s:currentType ) . ", \\\n"

               let s:offsetValues .= "   (offset_data_ObjectDescription)( " . s:bufferOffset . " ),\n"

               let s:dynamicLine = substitute( s:currentLines[ s:lineNumber - 2 ], s:dynamicValueDefinition, "", "" )
               let s:isDynamic = ( s:dynamicLine != s:currentLines[ s:lineNumber - 2 ] )
               let s:initObject = "initObject"
               let s:paramLine = 2

               if ( s.isDynamic != 0 )
                  let s:paramLine = 3
               endif " End IF this is a dynamic definition

               let s:noParam = substitute( s:currentLines[ s:lineNumber - s:paramLine ], s:noParamDefinition, "", "" )
               let s:defaultValue = substitute( s:currentLines[ s:lineNumber - s:paramLine ], s:defaultValueDefinition, "", "" )
               let s:variableName = ""

               if ( s:noParam == s:currentLines[ s:lineNumber - s:paramLine ] )
                  let s:variableName = s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject
                  call add( s:parameterListName, s:variableName )
                  let s:noParam = ""

                  if ( s:defaultValue == s:currentLines[ s:lineNumber - s:paramLine ] )
                     let s:defaultValue = ""
                  endif " End IF there is no default value to use
               endif " End IF the current attribute is a param

               let s:parameterListDictionary[ s:currentPrefixe . s:currentPrefixeObject . "_" . s:attributeName . "_" . s:usedObject ] = { "noParam" : s:noParam, "variable" : s:variableName, "defaultValue" : s:defaultValue, "type" : s:currentType, "fctInit" : "setter", "address" : VM_BuildAttributeAccessor( s:attributeName, "SET" ) . "( " . VM_BuildPrefixeAttribute() . ", current, " }

               if ( s:isDynamic != 0 )
                  let s:initObject .= "Dyn"
                  let s:bufferInitDeclare[ "dynamicObject_data_ObjectDescription" ] = s:initObject
                  let s:bufferInit .= "   " . s:initObject . " = (dynamicObject_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_DYNAMICOBJECT_SETDYNOBJECTDESC( " . s:initObject . ",\n"
                  let s:bufferInit .= "                                                          (data_DynamicObject*)(" . s:dynamicLine . ") );\n"
                  let s:bufferOffset .= " + sizeof( dynamicObject_data_ObjectDescription )"
                  let s:typeValues .= "   BASE_OBJECTDESCRIPTION_TYPE_DYNAMICOBJECT,\n"
                  let s:baseIncludes[ toupper( s:currentType ) ] = VM_SelectFolder( s:currentType, s:projectFolder ) . "/" . substitute( s:currentType, "*", "", "g" )
               else " End IF the object is a dynamic one
                  let s:bufferInitDeclare[ "object_data_ObjectDescription" ] = s:initObject
                  let s:bufferInit .= "   " . s:initObject . " = (object_data_ObjectDescription*)( buffer_" . s:className . " + " . s:bufferOffset . " );\n\n"
                  let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_OBJECT_SETOBJECTDESC( " . s:initObject . ",\n"
                  let s:bufferInit .= "                                                \\&( " . VM_AddInclude( substitute( s:currentType, "\\*.*", "", "" ) ) . "_DEFAULT ) );\n"
                  let s:bufferOffset .= " + sizeof( object_data_ObjectDescription )"
                  let s:typeValues .= "   " . VM_ComputeTypeObject( s:currentType ) . ",\n"
               endif " End IF the object is a standand one

               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETOFFSET( " . s:initObject . ",\n"
               let s:bufferInit .= "                                            (offset_data_ObjectDescription)" . VM_BuildAttributeOffset() . " );\n"
               let s:bufferInit .= "   DATA_OBJECTDESCRIPTION_STRING_SETALLOCATEOBJECT( " . s:initObject . ",\n"
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

if ( s:dynamicInit == "" )
   let s:dynamicInclude = "\n"
   let s:dynamicIncludeExport = "\n"
   let s:dynamicInit = "defaultDescription"
   let s:dynamicDeclare = "static "
else " End IF the dynamic is not defined
   let s:dynamicInclude = "extern [@ELEMENT_NAME@] " . s:dynamicInit . ";\n"
   let s:dynamicIncludeExport = "extern [@ELEMENT_NAME@] " . s:dynamicInit . "_export;\n"
   let s:dynamicDeclare = ""
endif " End IF the dynamic is defined

call VM_AddDescGlobal( s:className )

if ( s:typeClassName == "cmd" && exists( "s:baseIncludes." . toupper( s:factoryType ) ) != 0 )
   unlet s:baseIncludes[ toupper( s:factoryType ) ]
endif " End IF the include had to be removed from the include list

call VM_BuildCaseList( s:parameterListName, s:parameterListDictionary )
call VM_BuildParamList( s:parameterListDictionary )
call VM_BuildConditionParam( s:conditionParamList )

let g:VM_additionnalValues[ "CONDITION_PARAM_CHECK" ] = substitute( s:conditionCheck, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_INCLUDE" ] = substitute( VM_BuildIncludeList( s:baseIncludes ), "\n", "", "g" )
let g:VM_additionnalValues[ "FACTORY_INCLUDE" ] = substitute( VM_BuildIncludeFactory( s:factoryInclude ), "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_OFFSET_VALUE_LIST" ] = substitute( s:offsetValues, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_TYPE_VALUE_LIST" ] = substitute( s:typeValues, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_NAME_VALUE_LIST" ] = substitute( s:namesList, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_DECLARE" ] = substitute( s:bufferDeclare, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_INIT" ] = substitute( s:bufferInit, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_NAME" ] = substitute( s:bufferName, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_BUFFER_SIZE" ] = substitute( s:bufferSize, "\n", "", "g" )
let g:VM_additionnalValues[ "ELEMENT_INDEX_LIST" ] = substitute( substitute( s:indexesList, toupper( s:baseClassName . s:extentionClass ), toupper( s:baseClassName . "NoId" . s:extentionClass ), "g" ), "\n", "", "g" )
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
let g:VM_additionnalValues[ "ELEMENT_IDENTIFIER" ] = s:identifierUsage
let g:VM_additionnalValues[ "DESCRIPTION_DECLARE" ] = s:dynamicDeclare
let g:VM_additionnalValues[ "DESCRIPTION_VARIABLE" ] = s:dynamicInit
let g:VM_additionnalValues[ "DESCRIPTION_DECLARATION" ] = substitute( s:dynamicInclude, "\n", "", "g" )
let g:VM_additionnalValues[ "DESCRIPTION_DECLARATION_EXPORT" ] = substitute( s:dynamicIncludeExport, "\n", "", "g" )
let g:VM_additionnalValues[ "DECLARATION_PARAM_LIST" ] = substitute( s:parameterListDeclaration, "\n", "", "g" )
let g:VM_additionnalValues[ "DECLARATION_ENUM_LIST" ] = substitute( s:enumListDeclaration, "\n", "", "g" )
let g:VM_additionnalValues[ "CASES_PARAM_LIST" ] = substitute( s:parameterListCase, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_INIT" ] = substitute( s:associatedObjectInit, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_MACRO" ] = substitute( toupper( s:associatedObject ), "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_TYPE" ] = substitute( s:associatedObject, "\n", "", "g" )
let g:VM_additionnalValues[ "ASSOCIATED_OBJECT_FOLDER" ] = substitute( s:associatedFolder, "\n", "", "g" )

tabnew

if ( s:typeClassName == "cmd" )
   let s:className = s:baseClassName . "NoId" . s:extentionClass
   call VM_AddDescGlobal( s:className )

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", s:className, "cmdNoId_desc", s:comment, s:className . ".c", s:repository, s:projectFolder )

   " Construit le fichier d'accessors
   "---------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "macmdNoId_desc", s:comment, s:className . ".mac", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "hmdNoId_desc", s:comment, s:className . ".h", s:repository, s:projectFolder )

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

   tabnew

   let s:className = s:baseClassName . s:extentionClass

   " Add the tracker identifier to the definition
   "---------------------------------------------
   let s:indexesList .= "   " . toupper( s:className ) . "_INDEX_TRACKERID,\n"
   let s:offsetValues .= ",\n   (offset_data_ObjectDescription)( (char*)\\&( BASE_COMMANDREMOTE_PREFIXED_GETTRACKERID( std, ( (" . s:associatedObject . "*)NULL ) ) ) - (char*)NULL )"
   let s:typeValues .= ",\n   BASE_OBJECTDESCRIPTION_TYPE_UINT32"
   let s:namesList .= ",\n   \"trackerId\""

   let g:VM_additionnalValues[ "ELEMENT_INDEX_LIST" ] = substitute( s:indexesList, "\n", "", "g" )
   let g:VM_additionnalValues[ "ELEMENT_OFFSET_VALUE_LIST" ] = substitute( s:offsetValues, "\n", "", "g" )
   let g:VM_additionnalValues[ "ELEMENT_TYPE_VALUE_LIST" ] = substitute( s:typeValues, "\n", "", "g" )
   let g:VM_additionnalValues[ "ELEMENT_NAME_VALUE_LIST" ] = substitute( s:namesList, "\n", "", "g" )

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( "edit", s:className, "cmd_desc", s:comment, s:className . ".c", s:repository, s:projectFolder )

   " Construit le fichier d'accessors
   "---------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "macmd_desc", s:comment, s:className . ".mac", s:repository, s:projectFolder )

   " Construit le fichier d'entête de class
   "---------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:className, "hmd_desc", s:comment, s:className . ".h", s:repository, s:projectFolder )

   " Construit le fichier de type
   "-----------------------------
   call VM_ProjectBuildFile( "split", s:className, "typmd_desc", s:comment, s:className . ".typ", s:repository, s:projectFolder )

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

   " Construit les factory pour les deux classes
   "--------------------------------------------
   let s:baseClassName = substitute( s:associatedObject, "[^_]*_", "fact_", "" )
   let s:repository = VM_SelectFolder( s:baseClassName, s:projectFolder )
   let s:comment = "The factory for exporting " . s:comment
   let s:className = s:baseClassName . "Export"

   if ( VM_ProjectTestFileExists( s:className . ".c", s:repository, s:projectFolder ) == 0 )
      wincmd =

      tabnew

      " Construit le fichier de corps de class
      "---------------------------------------
      call VM_ProjectBuildFile( "edit", s:className, "c_fact", s:comment, s:className . ".c", s:repository, s:projectFolder )

      " Construit le fichier d'accessors
      "---------------------------------
      call VM_ProjectBuildFile( "vsplit", s:className, "mac_fact", s:comment, s:className . ".mac", s:repository, s:projectFolder )

      " Construit le fichier d'entête de class
      "---------------------------------------
      call VM_ProjectBuildFile( "vsplit", s:className, "h_fact", s:comment, s:className . ".h", s:repository, s:projectFolder )

      " Construit le fichier de type
      "-----------------------------
      call VM_ProjectBuildFile( "split", s:className, "typ_fact", s:comment, s:className . ".typ", s:repository, s:projectFolder )

      " Construit le fichier de structure
      "----------------------------------
      call VM_ProjectBuildFile( "split", s:className, "str_fact", s:comment, s:className . ".str", s:repository, s:projectFolder )
   endif " End IF the factory is not built yet

   let s:className = s:baseClassName

   if ( VM_ProjectTestFileExists( s:className . ".c", s:repository, s:projectFolder ) == 0 )
      wincmd =

      tabnew

      " Construit le fichier de corps de class
      "---------------------------------------
      call VM_ProjectBuildFile( "edit", s:className, "c_fact", s:comment, s:className . ".c", s:repository, s:projectFolder )

      " Construit le fichier d'accessors
      "---------------------------------
      call VM_ProjectBuildFile( "vsplit", s:className, "mac_fact", s:comment, s:className . ".mac", s:repository, s:projectFolder )

      " Construit le fichier d'entête de class
      "---------------------------------------
      call VM_ProjectBuildFile( "vsplit", s:className, "h_fact", s:comment, s:className . ".h", s:repository, s:projectFolder )

      " Construit le fichier de type
      "-----------------------------
      call VM_ProjectBuildFile( "split", s:className, "typ_fact", s:comment, s:className . ".typ", s:repository, s:projectFolder )

      " Construit le fichier de structure
      "----------------------------------
      call VM_ProjectBuildFile( "split", s:className, "str_fact", s:comment, s:className . ".str", s:repository, s:projectFolder )
   endif " End IF the factory is not built yet
else " End IF we are on the build of a command export
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
endif " End IF we are on the build of a regular export

wincmd =

delfunction VM_BuildConditionParam
delfunction VM_BuildNamedAttributeOffset
delfunction VM_BuildAddressObject
delfunction VM_BuildAttributeAccessor
delfunction VM_BuildPrefixeAttribute
delfunction VM_BuildAddressAttribute
delfunction VM_BuildCaseList
delfunction VM_BuildParamList
delfunction VM_BuildInitializationParameter
delfunction VM_BuildVariableName
delfunction VM_BuildEnumName
delfunction VM_CheckIgnoredType
delfunction VM_ComputeTypeObject
delfunction VM_BuildConflationOffset
delfunction VM_BuildConflationSwitch
delfunction VM_BuildAttributeOffset
delfunction VM_GetFolderInclude
delfunction VM_FindStructuredFile
delfunction VM_BuildIncludeFactory
delfunction VM_BuildIncludeList
delfunction VM_AddInclude

if ( s:deleteFunctionAddDesc != 0 )
   delfunction VM_AddDescGlobal
endif

"---< Fin de fichier >----------------------------------------------------------

