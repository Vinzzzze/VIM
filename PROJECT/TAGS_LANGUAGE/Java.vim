" Fichier : Java.vim
"
" But : Handle the current line gotten from the tag file for the Java language.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 31 Dec 2014
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*s:JAVA_InitLanguage" ) == 0 )

" Fonction : JAVA_InitLanguage
"
" But : Initialize the language definition. These attributes will be added
"        - baseFolder : The current base folder for all files
"        - classes : The dictionary for all classes
"        - displayFct : The function used to display the dictionary ( this function )
"
" Parametres :
"    languageDic - The dictionary to initialize
"-------------------------------------------------------------------------------
function s:JAVA_InitLanguage( languageDic )
   " Initialize the display variables
   "---------------------------------
   if ( exists( "g:JAVA_internalFirstLevel" ) == 0 )
      let g:JAVA_internalFirstLevel = function( "JAVA_InternalExtractFirstLevel" )
   endif

   if ( exists( "g:JAVA_internalSecondLevel" ) == 0 )
      let g:JAVA_internalSecondLevel = function( "JAVA_ExtractSecondLevel" )
   endif

   if ( exists( "g:JAVA_internalLastLevel" ) == 0 )
      let g:JAVA_internalLastLevel = function( "JAVA_ExtractLastLevel" )
   endif

   if ( exists( "g:JAVA_externalFirstLevel" ) == 0 )
      let g:JAVA_externalFirstLevel = function( "JAVA_ExternalExtractFirstLevel" )
   endif

   if ( exists( "g:JAVA_externalSecondLevel" ) == 0 )
      let g:JAVA_externalSecondLevel = function( "JAVA_ExtractSecondLevel" )
   endif

   if ( exists( "g:JAVA_externalLastLevel" ) == 0 )
      let g:JAVA_externalLastLevel = function( "JAVA_ExtractLastLevel" )
   endif

   if ( exists( "g:JAVA_dictDisplayHierarchy" ) == 0 )
      let g:JAVA_dictDisplayHierarchy = "JAVA_DisplayHierarchy"
   endif

   if ( exists( "g:JAVA_classType" ) == 0 )
      let g:JAVA_classType = "Class"
   endif

   if ( exists( "g:JAVA_enumType" ) == 0 )
      let g:JAVA_enumType = "Enum"
   endif

   " Then, initialize the dictionary itself
   "---------------------------------------
   let a:languageDic.classes = {}
   let a:languageDic.baseFolder = g:tagBaseFolder
   let a:languageDic.sortName = "0"
   let a:languageDic.displayFct = function( g:JAVA_dictDisplayHierarchy )
endfunction

endif

if ( exists( "*s:JAVA_CreateElement" ) == 0 )

" Fonction : JAVA_CreateElement
"
" But : Create an element for handle either class either enum definition.
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The created element
"-------------------------------------------------------------------------------
function s:JAVA_CreateElement( baseDictionnary, name, relativePath, filename, position )
   let currentElement = {}
   let currentElement.relativePath = a:relativePath
   let currentElement.associatedFile = a:filename
   let currentElement.associatedPosition = a:position
   let currentElement.name = a:name

   let a:baseDictionnary[ a:name ] = currentElement

   return currentElement
endfunction

endif

if ( exists( "*s:JAVA_ElementToClass" ) == 0 )

" Fonction : JAVA_ElementToClass
"
" But : Transform the current element into a class. If the element is already a
"       class or an enum, nothing is done
"
" Parametres :
"    currentElement - The element to be transformed
" Retour :
"    The current element, updated if update had to be done
"-------------------------------------------------------------------------------
function s:JAVA_ElementToClass( currentElement )
   if ( exists( "a:currentElement.type" ) == 0 )
      let a:currentElement.type = g:JAVA_classType
      let a:currentElement.classes = {}
   endif

   return a:currentElement
endfunction

endif

if ( exists( "*s:JAVA_ElementToEnum" ) == 0 )

" Fonction : JAVA_ElementToEnum
"
" But : Transform the current element into a class. If the element is already a
"       class or an enum, nothing is done.
"
" Parametres :
"    currentElement - The element to be transformed
" Retour :
"    The current element, update if update had to be done
"-------------------------------------------------------------------------------
function s:JAVA_ElementToEnum( currentElement )
   if ( exists( "a:currentElement.type" ) == 0 )
      let a:currentElement.type = g:JAVA_enumType
      let a:currentElement.values = []
   endif

   return a:currentElement
endfunction

endif

if ( exists( "*s:JAVA_CreateClass" ) == 0 )

" Fonction : JAVA_CreateClass
"
" But : Initialize the object used to handle a class definition
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The created class
"-------------------------------------------------------------------------------
function s:JAVA_CreateClass( baseDictionnary, name, relativePath, filename, position )
   let currentClass = s:JAVA_CreateElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )
   let currentClass = s:JAVA_ElementToClass( currentClass )

   return currentClass
endfunction

endif

if ( exists( "*s:JAVA_CreateEnum" ) == 0 )

" Fonction : JAVA_CreateEnum
"
" But : Create an enum definition
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current enum name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The created enum
"-------------------------------------------------------------------------------
function s:JAVA_CreateEnum( baseDictionnary, name, relativePath, filename, position )
   let currentEnum = s:JAVA_CreateElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )
   let currentEnum = s:JAVA_ElementToEnum( currentEnum )

   return currentEnum
endfunction

endif

if ( exists( "*s:JAVA_UpdateElement" ) == 0 )

" Fonction : JAVA_UpdateElement
"
" But : Update the elment definition
"
" Parametres :
"    currentElement - The element to be updated
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The element updated
"-------------------------------------------------------------------------------
function s:JAVA_UpdateElement( currentElement, relativePath, filename, position )
   if ( a:relativePath != "" )
      let a:currentElement.relativePath = a:relativePath
   endif

   if ( a:filename != "" )
      let a:currentElement.associatedFile = a:filename
   endif

   if ( a:position != "" )
      let a:currentElement.associatedPosition = a:position
   endif

   return a:currentElement
endfunction

endif

if ( exists( "*s:JAVA_GetCreateElement" ) == 0 )

" Fonction : JAVA_GetCreateElement
"
" But : Get the existing element or create it if it does not exists yet.
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The existing element or the created element if it was not existing
"-------------------------------------------------------------------------------
function s:JAVA_GetCreateElement( baseDictionnary, name, relativePath, filename, position )
   if ( exists( "a:baseDictionnary[ a:name ]" ) == 0 )
      let currentElement = s:JAVA_CreateElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )
   else
      let currentElement = s:JAVA_UpdateElement( a:baseDictionnary[ a:name ], a:relativePath, a:filename, a:position )
   endif

   return currentElement
endfunction

endif

if ( exists( "*s:JAVA_GetCreateClass" ) == 0 )

" Fonction : JAVA_GetCreateClass
"
" But : Get the existing class or create it if it does not exists.
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The created / existing class
"-------------------------------------------------------------------------------
function s:JAVA_GetCreateClass( baseDictionnary, name, relativePath, filename, position )
   let currentClass = s:JAVA_GetCreateElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )

   return s:JAVA_ElementToClass( currentClass )
endfunction

endif

if ( exists( "*s:JAVA_GetCreateEnum" ) == 0 )

" Fonction : JAVA_GetCreateEnum
"
" But : Get the existing enum or create it if it does not exists.
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
"    filename - The filename where the class can be found
"    position - The position where the class can be found
" Retour :
"    The created / existing enum
"-------------------------------------------------------------------------------
function s:JAVA_GetCreateEnum( baseDictionnary, name, relativePath, filename, position )
   let currentEnum = s:JAVA_GetCreateElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )

   return s:JAVA_ElementToEnum( currentEnum )
endfunction

endif

if ( exists( "*s:JAVA_CreateClassHierarchy" ) == 0 )

" Fonction : s:JAVA_CreateClassHierarchy
"
" But : Build / Get all the classes for the specified hierarchy
"
" Parametres :
"    classHierarchy - The class hierarchy description
" Retour :
"    The last created element
"-------------------------------------------------------------------------------
function s:JAVA_CreateClassHierarchy( classHierarchy )
   let currentClass = {}

   for currentClassName in a:classHierarchy
      if ( empty( currentClass ) != 0 )
         let currentClass = s:JAVA_GetCreateElement( g:tagCurrentLanguageDef.classes, currentClassName, "", "", "" )
      else
         let currentClass = s:JAVA_ElementToClass( currentClass )
         let currentClass = s:JAVA_GetCreateElement( currentClass.classes, currentClassName, "", "", "" )
      endif
   endfor

   return currentClass
endfunction

endif

if ( exists( "*JAVA_ExternalExtractFirstLevel" ) == 0 )

" Fonction : JAVA_ExternalExtractFirstLevel
"
" But : Build the first level dictionnary. It will contains :
"       - name : The name of the current level
"       - sortName : The name used to sort the same levels between them
"       - elementList : The dictionnary of the elements to display
"       - translateToDisplay : The function used to display the elements
"
" Parametres :
"    folderName - The path to the file for the current element
"    folderDescription - The current folder description
" Retour :
"    The first level dictionary
"-------------------------------------------------------------------------------
function JAVA_ExternalExtractFirstLevel( folderName, folderDescription )
   if ( ( len( a:folderName ) > 0 )&&( a:folderName[ 0 ] == "com" ) )
      let currentName = join( a:folderName[ 0 : 2 ], "." )

      if ( exists( "a:folderDescription[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = currentName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( "JAVA_DisplayIntermediateLevel" )

         let a:folderDescription[ currentName ] = retValue
      else
         let retValue = a:folderDescription[ currentName ]
      endif

      call VM_DeleteFirstElements( a:folderName, 3 )
   elseif ( ( len( a:folderName ) > 2 )&&( a:folderName[ 2 ] != "test" ) )
      let currentName = a:folderName[ 0 ]

      if ( exists( "a:folderDescription[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = currentName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( "JAVA_DisplayFirstLevel" )

         let a:folderDescription[ currentName ] = retValue
      else
         let retValue = a:folderDescription[ currentName ]
      endif

      call VM_DeleteFirstElements( a:folderName, 4 )
   else
      let retValue = {}

      call VM_DeleteFirstElements( a:folderName, 4 )
   endif

   return retValue
endfunction

endif

if ( exists( "*JAVA_InternalExtractFirstLevel" ) == 0 )

" Fonction : JAVA_InternalExtractFirstLevel
"
" But : Build the first level dictionary. It will contains :
"       - name : The name of the current level
"       - sortName : The name used to sort the same levels between them
"       - elementList : The dictionnary of the elements to display
"       - translateToDisplay : The function used to display the elements
"
" Parametres :
"    folderName - The path to the file for the current element
"    folderDescription - The current folder description
" Retour :
"    The first level dictionary
"-------------------------------------------------------------------------------
function JAVA_InternalExtractFirstLevel( folderName, folderDescription )
   if ( len( a:folderName ) > 1 )
      let introName = a:folderName[ 0 ]
      let introSort = "55"
      let currentName = a:folderName[ 1 ]
      let sortName = currentName

      if ( introName == "modules" )
         let introSort = "00" . sortName
         let currentName = introName . "-" . currentName
         let sortName = a:folderName[ 3 ]

         call VM_DeleteFirstElements( a:folderName, 5 )
      elseif ( introName == "core" )
         let introSort = "99"
         let currentName = "core STePS"
         let sortName = a:folderName[ 2 ]

         call VM_DeleteFirstElements( a:folderName, 4 )
      else
         call VM_DeleteFirstElements( a:folderName, 3 )
      endif

      if ( sortName == "test" )
         let introSort = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" . introSort

         if ( currentName != sortName )
            let currentName .= " : test"
         endif
      elseif ( sortName == "itest" )
         let introSort = "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz" . introSort

         if ( currentName != sortName )
            let currentName .= " : itest"
         endif
      endif

      if ( exists( "a:folderDescription[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = introSort . sortName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( "JAVA_DisplayFirstLevel" )

         let a:folderDescription[ currentName ] = retValue
      else
         let retValue = a:folderDescription[ currentName ]
      endif
   else
      let retValue = {}

      call VM_DeleteFirstElements( a:folderName, 3 )
   endif

   return retValue
endfunction

endif

if ( exists( "*JAVA_ExtractSecondLevel" ) == 0 )

" Fonction : JAVA_ExtractSecondLevel
"
" But : Extract the second level definition of the current folder list.
"
" Parametres :
"    folderName - The path to the file for the current element
"    parentDescription - The parent element's description
" Retour :
"    The second dictinary level to use
"-------------------------------------------------------------------------------
function JAVA_ExtractSecondLevel( folderName, parentDescription )
   if ( len( a:folderName ) > 1 )
      let currentName = join( a:folderName[ 0 : 2 ], "." )

      if ( exists( "a:parentDescription.elementList[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = currentName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( "JAVA_DisplayIntermediateLevel" )

         let a:parentDescription.elementList[ currentName ] = retValue
      else
         let retValue = a:parentDescription.elementList[ currentName ]
      endif
   else
      let retValue = {}
   endif

   call VM_DeleteFirstElements( a:folderName, 3 )

   return retValue
endfunction

endif

if ( exists( "*JAVA_ExtractLastLevel" ) == 0 )

" Fonction : JAVA_ExtractLastLevel
"
" But : Build the element that will own the classes
"
" Parametres :
"    folderName - The path to the file for the current element
"    parentDescription - The parent element's description
" Retour :
"    The class owner description
"-------------------------------------------------------------------------------
function JAVA_ExtractLastLevel( folderName, parentDescription )
   let currentName = join( a:folderName, "." )
   let sortName = currentName

   if ( sortName == "" )
      if ( exists( "a:parentDescription.classArray" ) == 0 )
         let a:parentDescription.classArray = []
      endif

      let retValue = a:parentDescription
   else
      if ( exists( "a:parentDescription.elementList[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = sortName
         let retValue.classArray = []
         let retValue.translateToDisplay = function( "JAVA_DisplayIntermediateLevel" )

         let a:parentDescription.elementList[ currentName ] = retValue
      else
         let retValue = a:parentDescription.elementList[ currentName ]
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*JAVA_DisplayFirstLevel" ) == 0 )

" Fonction : JAVA_DisplayFirstLevel
"
" But : Display the first level definition.
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function JAVA_DisplayFirstLevel( linesArray, currentIntro, lastElement ) dict
   call add( a:linesArray, JAVA_BuildLine( join( a:currentIntro, "" ) . "+-# " . self.name, "", "" ) )

   let lastValue = len( self.elementList ) - 1
   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

   for currentSubLevel in sort( values( self.elementList ), 'VM_CompareSortName' )
      call currentSubLevel.translateToDisplay( a:linesArray, usedIntro, lastValue )

      let lastValue -= 1
   endfor
endfunction

endif

if ( exists( "*JAVA_DisplayIntermediateLevel" ) == 0 )

" Fonction : JAVA_DisplayIntermediateLevel
"
" But : Display the intermediate level
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function JAVA_DisplayIntermediateLevel( linesArray, currentIntro, lastElement ) dict
   if ( self.name > "" )
      call add( a:linesArray, JAVA_BuildLine( join( a:currentIntro, "" ) . "+-+( " . self.name . " )", "", "" ) )

      let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )
   endif

   if ( exists( "self.elementList" ) != 0 )
      let lastValue = len( self.elementList ) - 1

      if ( exists( "self.classArray" ) != 0 )
         let lastValue += 1
      endif

      for currentSubLevel in sort( values( self.elementList ), 'VM_CompareSortName' )
         call currentSubLevel.translateToDisplay( a:linesArray, usedIntro, lastValue )

         let lastValue -= 1
      endfor
   endif

   if ( exists( "self.classArray" ) != 0 )
      let lastValue = len( self.classArray ) - 1

      for currentClass in sort( self.classArray, 'VM_CompareNameNoCasse' )
         call JAVA_DisplayClass( a:linesArray, currentClass, usedIntro, lastValue )

         let lastValue -= 1
      endfor
   endif
endfunction

endif

if ( exists( "*JAVA_DisplayClass" ) == 0 )

" Fonction : JAVA_DisplayClass
"
" But : Display the current class
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    lineClass - The line class element
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function JAVA_DisplayClass( linesArray, lineClass, currentIntro, lastElement )
   let type = a:lineClass.element.type
   call add( a:linesArray, JAVA_BuildLine( join( a:currentIntro, "" ) . "+-+" . type . " " . a:lineClass.name, a:lineClass.file, a:lineClass.element.associatedPosition ) )

   if ( type == g:JAVA_classType )
      let lastValue = len( a:lineClass.element.classes ) - 1
      let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

      for subClass in sort( values( a:lineClass.element.classes ), 'VM_CompareNameNoCasse' )
         let newLineClass = {}

         let newLineClass.name = subClass.name
         let newLineClass.element = subClass
         let newLineClass.file = a:lineClass.file

         call JAVA_DisplayClass( a:linesArray, newLineClass, usedIntro, lastValue )
      endfor
   elseif ( type == g:JAVA_enumType )
      let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

      for currentCaseValue in a:lineClass.element.values
         call add( a:linesArray, JAVA_BuildLine( join( usedIntro, "" ) . "{ " . currentCaseValue . " }", "", "" ) )
      endfor
   endif
endfunction

endif

if ( exists( "*JAVA_BuildLine" ) == 0 )

" Fonction : JAVA_BuildLine
"
" But : Build the line to be displaid
"
" Parametres :
"    text - The text to be displaid
"    filename - The filename associated to the line
"    position - The position in the filename
" Retour :
"    The line element to be displaid
"-------------------------------------------------------------------------------
function JAVA_BuildLine( text, filename, position )
   return VM_BuildTagLine( "java", a:text, a:filename, a:position )
endfunction

endif

if ( exists( "*JAVA_DisplayHierarchy" ) == 0 )

" Fonction : JAVA_DisplayHierarchy
"
" But : Build the array to be displaid in the class window. This function will
"       be associated the the Java dictionary definition
"
" Parametres :
"    currentIntro - the current intro to use
"    lastElement - 0 if it is the last element to print, antoher value otherwise
" Retour :
"    The array with the lines to be displaid
"     - text : the text to be displaid
"     - file : the complete filename
"     - position : the position to find the definition in the file
"-------------------------------------------------------------------------------
function JAVA_DisplayHierarchy( currentIntro, lastElement ) dict
   let folderDescription = {}

   if ( self.baseFolder == "" )
      let FirstLevel = g:JAVA_internalFirstLevel
      let SecondLevel = g:JAVA_internalSecondLevel
      let LastLevel = g:JAVA_internalLastLevel
   else
      let FirstLevel = g:JAVA_externalFirstLevel
      let SecondLevel = g:JAVA_externalSecondLevel
      let LastLevel = g:JAVA_externalLastLevel
   endif

   for currentElement in values( self.classes )
      let folderArray = split( currentElement.relativePath, "/" )
      let currentDescription = FirstLevel( folderArray, folderDescription )

      if ( empty( currentDescription ) == 0 )
         let currentDescription = SecondLevel( folderArray, currentDescription )

         if ( empty( currentDescription ) == 0 )
            let currentDescription = LastLevel( folderArray, currentDescription )

            if ( empty( currentDescription ) == 0 )
               let computedFilename = self.baseFolder

               if ( computedFilename > "" )
                  let computedFilename .= "/"
               endif

               if ( currentElement.relativePath > "" )
                  let computedFilename .= currentElement.relativePath . "/"
               endif

               let computedFilename .= currentElement.associatedFile

               let currentClass = {}
               let currentClass.name = currentElement.name
               let currentClass.element = currentElement
               let currentClass.file = computedFilename

               call add( currentDescription.classArray, currentClass )
            endif
         endif
      endif
   endfor

   let retValue = [ JAVA_BuildLine( join( a:currentIntro, "" ) . "+-+> Java", "", "" ) ]
   let currentValue = len( folderDescription ) - 1
   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

   for currentElement in sort( values( folderDescription ), 'VM_CompareSortName' )
      call currentElement.translateToDisplay( retValue, usedIntro, currentValue )

      let currentValue -= 1
   endfor

   return retValue
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( empty( g:tagCurrentLanguageDef ) != 0 )
   call s:JAVA_InitLanguage( g:tagCurrentLanguageDef )
endif

if ( g:tagType == "e" )
   " Current tag is an enum value
   "-----------------------------
   if ( empty( g:tagRemainingList ) == 0 )
      let s:enumDefinition = substitute( g:tagRemainingList[ 0 ], "^enum:", "", "" )

      if ( s:enumDefinition != g:tagRemainingList[ 0 ] )
         let s:currentClass = s:JAVA_CreateClassHierarchy( split( s:enumDefinition, "\\." ) )
         let s:currentClass = s:JAVA_ElementToEnum( s:currentClass )
         call add( s:currentClass.values, g:tagName )
      endif
   endif
elseif ( g:tagType == "c" )
   " Current tag is a class or an internal class
   "--------------------------------------------
   if ( empty( g:tagRemainingList ) != 0 )
      " This is a primary class
      "------------------------
      call s:JAVA_GetCreateClass( g:tagCurrentLanguageDef.classes, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
   else
      " This is a sub-class
      "--------------------
      let s:classHierarchy = substitute( g:tagRemainingList[ 0 ], "^class:", "", "" )

      if ( s:classHierarchy != g:tagRemainingList[ 0 ] )
         let s:currentEnumParent = s:JAVA_CreateClassHierarchy( split( s:classHierarchy, "\\." ) )
         let s:currentEnumParent = s:JAVA_ElementToClass( s:currentEnumParent )

         call s:JAVA_GetCreateClass( s:currentEnumParent.classes, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
      endif
   endif
elseif ( g:tagType == "g" )
   " Current tag is an enum or internal enum definition
   "---------------------------------------------------
   if ( empty( g:tagRemainingList ) != 0 )
      " This is a primary enum
      "------------------------
      call s:JAVA_GetCreateEnum( g:tagCurrentLanguageDef.classes, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
   else
      " This is an inner-class enum
      "----------------------------
      let s:enumHierarchy = substitute( g:tagRemainingList[ 0 ], "^\\(interface\\|class\\):", "", "" )

      if ( s:enumHierarchy != g:tagRemainingList[ 0 ] )
         let s:enumName = split( g:tagName, "\\." )[ -1 ]
         let s:currentEnumParent = s:JAVA_CreateClassHierarchy( split( s:enumHierarchy, "\\." ) )
         let s:currentEnumParent = s:JAVA_ElementToClass( s:currentEnumParent )

         call s:JAVA_GetCreateEnum( s:currentEnumParent.classes, s:enumName, g:tagRelativePath, g:tagFilename, g:tagPosition )
      endif
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

