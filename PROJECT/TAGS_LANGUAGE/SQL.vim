" Fichier : SQL.vim
"
" But : Handle the current line gotten from the tag file for the SQL language.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 13 janv. 2015
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*s:SQL_InitLanguage" ) == 0 )

" Fonction : s:SQL_InitLanguage
"
" But : Initialize the language definition.
"
" Parametres :
"    languageDic - The dictionary to initialize
"-------------------------------------------------------------------------------
function s:SQL_InitLanguage( languageDic )
   " Initialize the display variables
   "---------------------------------
   if ( exists( "g:SQL_dictDisplayHierarchy" ) == 0 )
      let g:SQL_dictDisplayHierarchy = "SQL_DisplayHierarchy"
   endif

   " Initialize the language dictionary
   "-----------------------------------
   let a:languageDic.tables = {}
   let a:languageDic.functions = {}
   let a:languageDic.procedures = {}
   let a:languageDic.classes = {}
   let a:languageDic.baseFolder = g:tagBaseFolder
   let a:languageDic.sortName = "5"
   let a:languageDic.displayFct = function( g:SQL_dictDisplayHierarchy )
endfunction

endif

if ( exists( "*s:SQL_BuildSingleElement" ) == 0 )

" Fonction : s:SQL_BuildSingleElement
"
" But : Build an SQL element without sub-values
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
function s:SQL_BuildSingleElement( baseDictionnary, name, relativePath, filename, position )
   let currentElement = {}
   let currentElement.relativePath = a:relativePath
   let currentElement.associatedFile = a:filename
   let currentElement.associatedPosition = a:position
   let currentElement.name = a:name

   let a:baseDictionnary[ a:name ] = currentElement

   return currentElement
endfunction

endif

if ( exists( "*s:SQL_BuildTableElement" ) == 0 )

" Fonction : s:SQL_BuildTableElement
"
" But : Build a table element that will contains it's column list.
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
function s:SQL_BuildTableElement( baseDictionnary, name, relativePath, filename, position )
   let basicElement = s:SQL_BuildSingleElement( a:baseDictionnary, a:name, a:relativePath, a:filename, a:position )
   let basicElement.columns = []

   return basicElement
endfunction

endif

if ( exists( "*SQL_BuildLine" ) == 0 )

" Fonction : SQL_BuildLine
"
" But : Create the line to display for the SQL language
"
" Parametres :
"    text - The text to be displaid
"    filename - The filename associated to the line
"    position - The position in the filename
" Retour :
"    The line element to be displaid
"-------------------------------------------------------------------------------
function SQL_BuildLine( text, filename, position )
   return VM_BuildTagLine( "sql", a:text, a:filename, a:position )
endfunction

endif

if ( exists( "*SQL_DisplayHierarchy" ) == 0 )

" Fonction : SQL_DisplayHierarchy
"
" But : Build the array to be displaid in the class window.
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
function SQL_DisplayHierarchy( currentIntro, lastElement ) dict
   let nbFunctions = len( self.functions )
   let nbProcedures = len( self.procedures )
   let nbTables = len( self.tables )
   let nbClasses = len( self.classes )

   let retValue = [ SQL_BuildLine( join( a:currentIntro, "" ) . "+-+> SQL", "", "" ) ]
   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

   if ( nbFunctions > 0 )
      call add( retValue, SQL_BuildLine( join( usedIntro, "" ) . "+-+( Functions )", "", "" ) )
      let fctIntro = VM_AddIntroLevel( usedIntro, nbProcedures + nbTables )

      for currentFunction in sort( values( self.functions ), 'VM_CompareName' )
         call add( retValue, SQL_BuildLine( join( fctIntro, "" ) . "+-+F " . currentFunction.name, currentFunction.associatedFile, currentFunction.associatedPosition ) )
      endfor
   endif

   if ( nbProcedures > 0 )
      call add( retValue, SQL_BuildLine( join( usedIntro, "" ) . "+-+( Procedures )", "", "" ) )
      let procIntro = VM_AddIntroLevel( usedIntro, nbTables )

      for currentProcedure in sort( values( self.procedures ), 'VM_CompareName' )
         call add( retValue, SQL_BuildLine( join( procIntro, "" ) . "+-+P " . currentProcedure.name, currentProcedure.associatedFile, currentProcedure.associatedPosition ) )
      endfor
   endif

   if ( nbTables > 0 )
      call add( retValue, SQL_BuildLine( join( usedIntro, "" ) . "+-+( Tables )", "", "" ) )
      let tableIntro = VM_AddIntroLevel( usedIntro, nbClasses )

      for currentTable in sort( values( self.tables ), 'VM_CompareName' )
         call add( retValue, SQL_BuildLine( join( tableIntro, "" ) . "+-+# " . currentTable.name, currentTable.associatedFile, currentTable.associatedPosition ) )
         let nbTables -= 1
         let columnIntro = VM_AddIntroLevel( tableIntro, 0 )

         for currentColumn in currentTable.columns
            call add( retValue, SQL_BuildLine( join( columnIntro, "" ) . "+-+@ " . currentColumn.name, currentTable.associatedFile, currentColumn.associatedPosition ) )
         endfor
      endfor
   endif

   if ( nbClasses > 0 )
      call add( retValue, SQL_BuildLine( join( usedIntro, "" ) . "+-+( Scripts )", "", "" ) )
      let procIntro = VM_AddIntroLevel( usedIntro, 0 )

      for currentScript in sort( values( self.classes ), 'VM_CompareName' )
         call add( retValue, SQL_BuildLine( join( procIntro, "" ) . "+-+P " . currentScript.name, currentScript.associatedFile, currentScript.associatedPosition ) )
      endfor
   endif

   return retValue
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( empty( g:tagCurrentLanguageDef ) != 0 )
   call s:SQL_InitLanguage( g:tagCurrentLanguageDef )
endif

if ( g:tagType == "f" )
   " This is a function
   "-------------------
   call s:SQL_BuildSingleElement( g:tagCurrentLanguageDef.functions, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
elseif ( g:tagType == "p" )
   " This is a stored procedure
   "---------------------------
   call s:SQL_BuildSingleElement( g:tagCurrentLanguageDef.procedures, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
elseif ( g:tagType == "F" )
   " This is a column table
   "-----------------------
   let s:tableElements = split( g:tagName, "\\." )

   if ( exists( "g:tagCurrentLanguageDef.tables[ s:tableElements[ 0 ] ]" ) == 0 )
      call s:SQL_BuildTableElement( g:tagCurrentLanguageDef.tables, s:tableElements[ 0 ], g:tagRelativePath, g:tagFilename, g:tagPosition )
   endif

   let s:currentTable = g:tagCurrentLanguageDef.tables[ s:tableElements[ 0 ] ]
   let s:currentColumn = {}
   let s:currentColumn.name = s:tableElements[ 1 ]
   let s:currentColumn.table = s:currentTable
   let s:currentColumn.associatedPosition = g:tagPosition

   call add( s:currentTable.columns, s:currentColumn )
elseif ( g:tagType == "t" )
   " This is a table
   "----------------
   if ( exists( "g:tagCurrentLanguageDef.tables[ g:tagName ]" ) == 0 )
      call s:SQL_BuildTableElement( g:tagCurrentLanguageDef.tables, g:tagName, g:tagRelativePath, g:tagFilename, g:tagPosition )
   else
      let g:tagCurrentLanguageDef.tables[ g:tagName ].associatedPosition = g:tagPosition
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

