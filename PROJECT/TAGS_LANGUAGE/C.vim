" Fichier : C.vim
"
" But : Handle the class definition for the C language.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 janv. 2015
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*s:C_InitLanguage" ) == 0 )

" Fonction : s:C_InitLanguage
"
" But : Initialize the language definition.
"
" Parametres :
"    languageDic - The dictionary to initialize
"-------------------------------------------------------------------------------
function s:C_InitLanguage( languageDic )
   " Initialize the display variables
   "---------------------------------
   if ( exists( "g:C_dictDisplayHierarchy" ) == 0 )
      let g:C_dictDisplayHierarchy = "C_DisplayHierarchy"
   endif

   if ( exists( "g:C_displayClasses" ) == 0 )
      let g:C_displayClasses = "C_DisplayClasse"
   endif

   if ( exists( "g:C_displayFolder" ) == 0 )
      let g:C_displayFolder = "C_DisplayFolder"
   endif

   if ( exists( "g:C_displayFolderClasses" ) == 0 )
      let g:C_displayFolderClasses = "C_DisplayFolderClasses"
   endif

   if ( exists( "g:C_firstLevel" ) == 0 )
      let g:C_firstLevel = function( "C_FirstLevel" )
   endif

   if ( exists( "g:C_secondLevel" ) == 0 )
      let g:C_secondLevel = function( "C_SecondLevel" )
   endif

   if ( exists( "g:C_lastLevel" ) == 0 )
      let g:C_lastLevel = function( "C_LastLevel" )
   endif

   if ( exists( "g:C_displayFolder" ) == 0 )
      let g:C_displayFolder = "C_DisplayFolder"
   endif

   " Initialize the language dictionary
   "-----------------------------------
   let a:languageDic.classes = {}
   let a:languageDic.baseFolder = g:tagBaseFolder
   let a:languageDic.sortName = "0"
   let a:languageDic.displayFct = function( g:C_dictDisplayHierarchy )
endfunction

endif

if ( exists( "*s:C_BuildClassDefinition" ) == 0 )

" Fonction : s:C_BuildClassDefinition
"
" But : Build the class object
"
" Parametres :
"    baseDictionnary - The dictionnary where the element is looking for
"    name - The current class name
"    relativePath - The relative path to get the file
" Retour :
"    The created element
"-------------------------------------------------------------------------------
function s:C_BuildClassDefinition( baseDictionnary, name, relativePath, filename, position )
   let currentElement = {}
   let currentElement.relativePath = a:relativePath
   let currentElement.name = a:name
   let currentElement.associatedFile = a:filename
   let currentElement.associatedPosition = a:position

   let a:baseDictionnary[ a:relativePath . "/" . a:name ] = currentElement

   return currentElement
endfunction

endif

if ( exists( "*C_BuildLine" ) == 0 )

" Fonction : C_BuildLine
"
" But : Build a line to be displaid
"
" Parametres :
"    text - The text to be displaid
"    filename - The filename associated to the line
"    folder - The folder associated to the line
" Retour :
"    The line element to be displaid
"-------------------------------------------------------------------------------
function C_BuildLine( text, filename, folder )
   let cLine = VM_BuildTagLine( "c", a:text, a:filename, "" )
   let cLine[ "folder" ] = a:folder

   return cLine
endfunction

endif

if ( exists( "*C_DisplayClasse" ) == 0 )

" Fonction : C_DisplayClasse
"
" But : Display the C classes in the current folder
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function C_DisplayClasse( linesArray, currentIntro, lastElement ) dict
   call add( a:linesArray, C_BuildLine( join( a:currentIntro, "" ) . "+-+( " . self.name . " )", "", "" ) )

   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

   for currentClass in sort( self.classes, 'VM_CompareName' )
      call add( a:linesArray, C_BuildLine( join( usedIntro, "" ) . "+C " . currentClass.name, currentClass.name, currentClass.relativePath ) )
   endfor
endfunction

endif

if ( exists( "*C_DisplayFolderClasses" ) == 0 )

" Fonction : C_DisplayFolderClasses
"
" But : Display the sub-folders and the classes of the current folder.
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function C_DisplayFolderClasses( linesArray, currentIntro, lastElement ) dict
   call add( a:linesArray, C_BuildLine( join( a:currentIntro, "" ) . "+-+( " . self.name . " )", "", "" ) )

   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )
   let lastValue = len( self.elementList )

   if ( lastValue != 0 )
      if ( exists( "self.classes" ) != 0 )
         let lastValue += len( self.classes )
      endif

      for currentFolder in sort( self.elementList, 'VM_CompareSortName' )
         call currentFolder( a:linesArray, usedIntro, lastValue )

         let lastValue -= 1
      endfor
   elseif ( exists( "self.classes" ) != 0 )
      let lastValue += len( self.classes )
   endif

   if ( exists( "self.classes" ) != 0 )
      for currentClass in sort( self.classes, 'VM_CompareName' )
         call add( a:linesArray, C_BuildLine( join( usedIntro, "" ) . "+C " . currentClass.name, currentClass.name, currentClass.relativePath ) )
      endfor
   endif
endfunction

endif

if ( exists( "*C_DisplayFolder" ) == 0 )

" Fonction : C_DisplayFolder
"
" But : Display a folder content.
"
" Parametres :
"    linesArray - The array where the lines will be stored
"    currentIntro - The intro to use to output the definitions
"    lastElement - 0 if it is the last element to print, antoher value otherwise
"-------------------------------------------------------------------------------
function C_DisplayFolder( linesArray, currentIntro, lastElement ) dict
   call add( a:linesArray, C_BuildLine( join( a:currentIntro, "" ) . "+-+( " . self.name . " )", "", "" ) )

   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )
   let lastValue = len( self.elementList )

   for currentFolder in sort( values( self.elementList ), 'VM_CompareSortName' )
      call currentFolder.translateToDisplay( a:linesArray, usedIntro, lastValue )

      let lastValue -= 1
   endfor
endfunction

endif

if ( exists( "*C_LastLevel" ) == 0 )

" Fonction : C_LastLevel
"
" But : Build the last level reference
"
" Parametres :
"    folderName - The path to the file for the current element
"    parentDescription - The parent element's description
" Retour :
"    The last dictionary level to use
"-------------------------------------------------------------------------------
function C_LastLevel( folderName, parentDescription )
   if ( len( a:folderName ) > 0 )
      let currentName = join( a:folderName, "/" )

      if ( exists( "a:parentDescription.elementList[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = currentName
         let retValue.classes = []
         let retValue.translateToDisplay = function( g:C_displayClasses )

         let a:parentDescription.elementList[ currentName ] = retValue
      else
         let retValue = a:parentDescription.elementList[ currentName ]
      endif
   else
      if ( exists( "a:parentDescription.classes" ) == 0 )
         let a:parentDescription.classes = []
         let a:parentDescription.translateToDisplay = function( g:C_displayFolderClasses )
      endif

      let retValue = a:parentDescription
   endif

   call VM_DeleteFirstElements( a:folderName, 1 )

   return retValue
endfunction

endif

if ( exists( "*C_SecondLevel" ) == 0 )

" Fonction : C_SecondLevel
"
" But : Build the second level folder value.
"
" Parametres :
"    folderName - The path to the file for the current element
"    parentDescription - The parent element's description
" Retour :
"    The second dictionary level to use
"-------------------------------------------------------------------------------
function C_SecondLevel( folderName, parentDescription )
   if ( len( a:folderName ) > 0 )
      let currentName = a:folderName[ 0 ]

      if ( exists( "a:parentDescription.elementList[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = currentName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( g:C_displayFolder )

         let a:parentDescription.elementList[ currentName ] = retValue
      else
         let retValue = a:parentDescription.elementList[ currentName ]
      endif
   else
      if ( exists( "a:parentDescription.classes" ) == 0 )
         let a:parentDescription.classes = []
         let a:parentDescription.translateToDisplay = function( g:C_displayFolderClasses )
      endif

      let retValue = a:parentDescription
   endif

   call VM_DeleteFirstElements( a:folderName, 1 )

   return retValue
endfunction

endif

if ( exists( "*C_FirstLevel" ) == 0 )

" Fonction : C_FirstLevel
"
" But : Build the first level folder value.
"
" Parametres :
"    folderName - The path to the file for the current element
"    folderDescription - The current folder description
" Retour :
"    The first level dictionary
"-------------------------------------------------------------------------------
function C_FirstLevel( folderName, folderDescription )
   if ( len( a:folderName ) > 0 )
      let currentName = a:folderName[ 0 ]
      let sortName = currentName
      let currentFolder = a:folderDescription

      if ( substitute( currentName, "[Tt][Ee][Ss][Tt]", "", "" ) != currentName )
         if ( exists( "currentFolder.test" ) == 0 )
            let retValue = {}
            let retValue.name = "TEST"
            let retValue.sortName = "zzzzzzzzzzzzzzzzzzzzzzzz"
            let retValue.elementList = {}
            let retValue.translateToDisplay = function( g:C_displayFolder )

            let currentFolder.test = retValue
         endif

         let currentFolder = currentFolder.test.elementList
         let sortName = "zzzzzzzzzzzzzzzzzzzzzz" . sortName
      else if ( exists( "currentFolder[ currentName ]" ) == 0 )
         let retValue = {}
         let retValue.name = currentName
         let retValue.sortName = sortName
         let retValue.elementList = {}
         let retValue.translateToDisplay = function( g:C_displayFolder )

         let currentFolder[ currentName ] = retValue
      else
         let retValue = currentFolder[ currentName ]
      endif
   else
      let retValue = {}
   endif

   call VM_DeleteFirstElements( a:folderName, 1 )

   return retValue
endfunction

endif

if ( exists( "*C_DisplayHierarchy" ) == 0 )

" Fonction : C_DisplayHierarchy
"
" But : Prepare the hierarchy display, regroup the classes by types
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
function C_DisplayHierarchy( currentIntro, lastElement ) dict
   let folderDescription = {}

   for currentElement in values( self.classes )
      let folderArray = split( currentElement.relativePath, "/" )

      let currentDescription = g:C_firstLevel( folderArray, folderDescription )

      if ( empty( currentDescription ) == 0 )
         let currentDescription = g:C_secondLevel( folderArray, currentDescription )

         if ( empty( currentDescription ) == 0 )
            let currentDescription = g:C_lastLevel( folderArray, currentDescription )

            let currentClass = {}
            let currentClass.relativePath = currentElement.relativePath
            let currentClass.associatedFile = currentElement.associatedFile
            let currentClass.associatedPosition = currentElement.associatedPosition
            let currentClass.name = currentElement.name

            call add( currentDescription.classes, currentClass )
         endif
      endif
   endfor

   let retValue = [ C_BuildLine( join( a:currentIntro, "" ) . "+-+> C", "", "" ) ]
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
   call s:C_InitLanguage( g:tagCurrentLanguageDef )
endif

if ( exists( "g:tagCurrentLanguageDef.classes[ g:tagClassName ]" ) == 0 )
   call s:C_BuildClassDefinition( g:tagCurrentLanguageDef.classes, g:tagClassName, g:tagRelativePath, g:tagFilename, g:tagPosition )
endif

"---< Fin de fichier >----------------------------------------------------------

