" Fichier : languagesVM.vim
"
" But : The way the dynamical languages are handled in the projects
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 22 Aug 2017
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_ListLibraryLanguage" ) == 0 )

" Fonction : VM_ListLibraryLanguage
"
" But : Get all the library language files definition
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
" Retour :
"     The library language files list
"-------------------------------------------------------------------------------
function VM_ListLibraryLanguage( projectFolder )
   return VM_GetFiles( a:projectFolder . "/" . g:VM_languageRepository )
endfunction

endif

if ( exists( "*VM_TestLibraryLanguage" ) == 0 )

" Fonction : VM_TestLibraryLanguage
"
" But : Test if the library already have a language definition set.
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
" Retour :
"     0 if there is no language file, another value otherwise
"-------------------------------------------------------------------------------
function VM_TestLibraryLanguage( projectFolder )
   return len( VM_ListLibraryLanguage( a:projectFolder ) )
endfunction

endif

if ( exists( "*VM_ConvertEnumToNameLanguage" ) == 0 )

" Fonction : VM_ConvertEnumToNameLanguage
"
" But : Convert the enum of a language to the language name
"
" Parametres :
"     languageEnum - the current enum value for the language
" Retour :
"     The current language name
"-------------------------------------------------------------------------------
function VM_ConvertEnumToNameLanguage( languageEnum )
   return substitute( substitute( tolower( a:languageEnum ), "^ *lang_", "", "" ), " *$", "", "" )
endfunction

endif

if ( exists( "*VM_ConvertNameToVariableLanguage" ) == 0 )

" Fonction : VM_ConvertNameToVariableLanguage
"
" But : Convert the language name to the variable name.
"
" Parametres :
"     languageName - the current language name
" Retour :
"     The variable name to use
"-------------------------------------------------------------------------------
function VM_ConvertNameToVariableLanguage( languageName )
   return "lang_" . a:languageName
endfunction

endif

if ( exists( "*VM_GetLanguageList" ) == 0 )

" Fonction : VM_GetLanguageList
"
" But : Extract the current library's language list.
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
" Retour :
"     The list of the languages defined in the current library
"-------------------------------------------------------------------------------
function VM_GetLanguageList( projectFolder )
   let languageFileList = VM_ListLibraryLanguage( a:projectFolder )
   let retValue = []

   if ( len( languageFileList ) != 3 )
      echo "The language definition for the project [" . a:projectFolder . "] is not valid, gotten " . len( languageFileList ) . " files instead of 3.\n"
   else
      for currentLanguage in readfile( a:projectFolder . "/" . g:VM_languageRepository . "/" . languageFileList[ 2 ] )
         call add( retValue, VM_ConvertEnumToNameLanguage( currentLanguage ) )
      endfor

      " call uniq( sort( retValue ) )
      call sort( retValue )
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_CreateFileLanguage" ) == 0 )

" Fonction : VM_CreateFileLanguage
"
" But : Create the specified file for the specified language.
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The name of the language to create
"     file - The filename to create
"-------------------------------------------------------------------------------
function VM_CreateFileLanguage( projectFolder, language, file )
   let currentContent = []

   if ( filereadable( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( g:VM_languageDefaultName ) . "/" . a:file . ".enum" ) != 0 )
      let currentContent = readfile( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( g:VM_languageDefaultName ) . "/" . a:file . ".enum" )
   endif

   call writefile( currentContent, a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . a:file . ".enum" )
endfunction

endif

if ( exists( "*VM_CreateLanguage" ) == 0 )

" Fonction : VM_CreateLanguage
"
" But : Create all the files to handle the specified language
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The name of the language to create
" Retour :
"     0 if the language add been created, another value otherwise
"-------------------------------------------------------------------------------
function VM_CreateLanguage( projectFolder, language )
   let existsLanguage = filewritable( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) )
   let retValue = -1

   if ( existsLanguage == 0 )
      call VM_ProjectBuildAllFolders( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) )

      call VM_CreateFileLanguage( a:projectFolder, a:language, g:VM_languageFileMessage )
      call VM_CreateFileLanguage( a:projectFolder, a:language, g:VM_languageFileParamUsage )
      call VM_CreateFileLanguage( a:projectFolder, a:language, g:VM_languageFileParamOrder )

      let retValue = 0
   elseif ( existsLanguage == 1 )
      echo "The language seems to be a file, there is something corrupted in VM's kingdom.\n"
   elseif ( existsLanguage == 2 )
      echo " The language seems to be already existing, nothing done.\n"
   else
      echo "Unable to create the folder to handle the language.\n"
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_ValidateLanguageName" ) == 0 )

" Fonction : VM_ValidateLanguageName
"
" But : Validate that the specified language name is not the default language
"       name as this default name should never be used
"
" Parametres :
"     language - The name of the language to create
" Retour :
"     0 if the language name is not the default one, another value otherwise
"-------------------------------------------------------------------------------
function VM_ValidateLanguageName( language )
   return ( ( a:language != "" )&&( a:language != g:VM_languageDefaultName ) )
endfunction

endif

if ( exists( "*VM_AddDefinitionLanguage" ) == 0 )

" Fonction : VM_AddDefinitionLanguage
"
" But : Add the specified language ( folder, ENUM and variable ... )
"
" Buffer : 
"     The file that owns the language enum definition
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The name of the language to create
"-------------------------------------------------------------------------------
function VM_AddDefinitionLanguage( projectFolder, language )
   let usedLanguage = substitute( a:language, "^\\clang_", "", "" )

   if ( VM_ValidateLanguageName( usedLanguage ) != 0 )
      let errorCreation = VM_CreateLanguage( a:projectFolder, usedLanguage )

      if ( errorCreation == 0 )
         let variableName = VM_ConvertNameToVariableLanguage( usedLanguage )

         if ( ( line( "$" ) == 1 )&&( getline( 1 ) == "" ) )
            call setline( 1, g:VM_languageIndent . toupper( variableName ) )
         else
            call append( line( "$" ), g:VM_languageIndent . toupper( variableName ) )
         endif

         write!
         execute "vsplit " . expand( "%:r" ) . ".h"

         let lineNumber = search( "< Structure >", "w" ) - 2

         call append( lineNumber, g:VM_languageDeclareVariable . variableName . ";" )

         write
         quit
      endif
   else
      echo "A language name cannot be empty or equivalent to the default language name."
   endif
endfunction

endif

if ( exists( "*VM_RequestAndCallLanguage" ) == 0 )

" Fonction : VM_RequestAndCallLanguage
"
" But : Ask for a name and call the specified function
"
" Buffer : 
"     The file from which the project name can be extracted
" Parametres :
"     textRequest - The text used for the name request
"     functionCall - The name of the function to call
"-------------------------------------------------------------------------------
function VM_RequestAndCallLanguage( textRequest, functionCall )
   let response = input( a:textRequest )

   if ( response > "" )
      let projectName = expand( "%:h:h" )
      execute "call " . a:functionCall . "( projectName, response )"
   endif
endfunction

endif

if ( exists( "*VM_DeleteLanguage" ) == 0 )

" Fonction : VM_DeleteLanguage
"
" But : Delete the specified language
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The name of the language to create
" Retour :
"     0 if the language had been successfully deleted
"-------------------------------------------------------------------------------
function VM_DeleteLanguage( projectFolder, language )
   let existsLanguage = filewritable( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) )
   let retValue = 1

   if ( existsLanguage == 2 )
      let retValue = delete( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileMessage . ".enum" )

      if ( retValue == 0 )
         call VM_ProjectDeleteAllBuffer( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileMessage . ".enum" )
         let retValue = delete( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamUsage . ".enum" )
      endif
      if ( retValue == 0 )
         call VM_ProjectDeleteAllBuffer( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamUsage . ".enum" )
         let retValue = delete( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamOrder . ".enum" )
      endif
      if ( retValue == 0 )
         call VM_ProjectDeleteAllBuffer( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamOrder . ".enum" )
      endif
   elseif ( existsLanguage == 0 )
      echo "The language is not defined, so, won't be deleted.\n"
   elseif ( existsLanguage == 1 )
      echo "The language seems to be a file, there is something corrupted in VM's kingdom.\n"
   else
      echo "Unable to delete the language for unknown reason.\n"
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_DelDefinitionLanguage" ) == 0 )

" Fonction : VM_DelDefinitionLanguage
"
" But : Delete the specified language definition.
"
" Buffer : 
"     The file where the language enum values are stored
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"-------------------------------------------------------------------------------
function VM_DelDefinitionLanguage( projectFolder )
   let currentLine = line( "." )
   let language = VM_ConvertEnumToNameLanguage( getline( currentLine ) )

   if ( ( currentLine == 1 )&&( line( "$" ) == 1 ) )
      if ( input( "Do you want to delete all the languages for the current library ( Y for yes ) ? " ) == "Y" )
         let errorDelete = VM_DeleteLanguage( a:projectFolder, language )

         if ( errorDelete == 0 )
            for fileToDelete in VM_ListLibraryLanguage( a:projectFolder )
               call VM_ProjectDeleteAllBuffer( a:projectFolder . "/" . g:VM_languageRepository . "/" . fileToDelete )
               call delete( a:projectFolder . "/" . g:VM_languageRepository . "/" . fileToDelete )
            endfor

            call delete( a:projectFolder . "/" . g:VM_languageRepository, "rf" )

            let allTabsDescription = VM_GetTabs()

            for currentEntry in allTabsDescription[ 0 ]
               let completeFilename = substitute( currentEntry.completeFilename, g:VM_projectDirSeparator, "/", "g" )

               if ( substitute( completeFilename, "^" . a:projectFolder . "/" . g:VM_languageRepository . "\\(/\\|$\\)", "", "" ) != completeFilename )
                  let currentWindow = 1
                  let currentTab = currentEntry.tabList[ 0 ]

                  for tabEntry in s:tabsDescription[ currentTab ]
                     if ( substitute( tabEntry.completeFilename, g:VM_projectDirSeparator, "/", "g" ) == completeFilename )
                        break
                     endif

                     let currentWindow += 1
                  endfor

                  call VM_GotoTabFile( currentTab, currentWindow )
                  quit!
               endif
            endfor
         else
            echo "Last language cannot be deleted.\n"
         endif
      else
         echo "Cannot delete the last language of the library.\n"
      endif
   elseif ( input( "Deleting language [" . language . "] (Y to delete) : " ) == "Y" )
      let errorDelete = VM_DeleteLanguage( a:projectFolder, language )

      if ( errorDelete == 0 )
         delete

         write!
         execute "vsplit " . expand( "%:r" ) . ".h"

         execute "/< Variables Languages >/+" . ( currentLine + 1 ) . " delete"

         write
         quit

         let allTabsDescription = VM_GetTabs()

         for currentEntry in allTabsDescription[ 0 ]
            let completeFilename = substitute( currentEntry.completeFilename, g:VM_projectDirSeparator, "/", "g" )

            if ( substitute( completeFilename, "^" . a:projectFolder . "/" . g:VM_languageRepository . "/" . language . "\\(/\\|$\\)", "", "" ) != completeFilename )
               let currentWindow = 1
               let currentTab = currentEntry.tabList[ 0 ]

               for tabEntry in s:tabsDescription[ currentTab ]
                  if ( substitute( tabEntry.completeFilename, g:VM_projectDirSeparator, "/", "g" ) == completeFilename )
                     break
                  endif

                  let currentWindow += 1
               endfor

               call VM_GotoTabFile( currentTab, currentWindow )
               quit!
            endif
         endfor
      else
         echo "Error, the language [" . language . "], cannot be deleted : " . errorDelete . "\n"
      endif
   endif
endfunction

endif

if ( exists( "*VM_RenameLanguage" ) == 0 )

" Fonction : VM_RenameLanguage
"
" But : Rename the specified language
"
" Buffer : 
"     The file that owns the language enum values
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The new language name
"-------------------------------------------------------------------------------
function VM_RenameLanguage( projectFolder, language )
   let currentLine = line( "." )
   let oldValue = getline( currentLine )
   let oldLanguage = VM_ConvertEnumToNameLanguage( oldValue )
   let newLanguage = substitute( a:language, "^\\clang_", "", "" )
   let variableNewLang = VM_ConvertNameToVariableLanguage( newLanguage )

   if ( VM_ValidateLanguageName( newLanguage ) != 0 )
      call setline( currentLine, "" )

      let alreadyExisting = search( "^" . g:VM_languageIndent . toupper( variableNewLang ) . "$", "wn" )

      if ( alreadyExisting == 0 )
         wall

         let languageFiles = VM_GetFiles( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( oldLanguage ) )
         let renameError = rename( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( oldLanguage ), a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( newLanguage ) )

         if ( renameError == 0 )
            call setline( currentLine, g:VM_languageIndent . toupper( variableNewLang ) )

            write!
            execute "vsplit " . expand( "%:r" ) . ".h"

            let lineNumber = search( "< Variables Languages >", "w" ) + 1 + currentLine

            call setline( lineNumber, g:VM_languageDeclareVariable . variableNewLang . ";" )

            write
            quit

            for updatedFile in languageFiles
               call VM_ProjectDeleteAllBuffer( a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( oldLanguage ) . "/" . updatedFile )
            endfor
         else
            echo "Unable to rename the language folder, renaming canceled.\n"
         endif
      else
         call setline( currentLine, oldValue )

         echo "The expected new language name already exists, cannot rename.\n"

         write!
      endif
   else
      echo "A language name cannot be empty or equivalent to the default language name."
   endif
endfunction

endif

if ( exists( "*VM_ConvertMessageToVariableLanguage" ) == 0 )

" Fonction : VM_ConvertMessageToVariableLanguage
"
" But : Convert the message name to a language variable name.
"
" Buffer : 
"     The file where the message variables are added
" Parametres :
"     messageName - the name of the message to be converted
" Retour :
"     The variable name ( toupper to get the enum value )
"-------------------------------------------------------------------------------
function VM_ConvertMessageToVariableLanguage( messageName )
   let currentLibName = expand( "%:t:r" )
   let messageId = substitute( a:messageName, "^\\c" . currentLibName . "_", "", "" )

   return currentLibName . "_" . messageId
endfunction

endif

if ( exists( "*VM_ConvertVariableToMessageLanguage" ) == 0 )

" Fonction : VM_ConvertVariableToMessageLanguage
"
" But : Convert a variable name to a message identifier
"
" Buffer : 
"     The file where the message variables are added
" Parametres :
"     messageVariable - the variable name of the message to be converted
" Retour :
"     The message identifier
"-------------------------------------------------------------------------------
function VM_ConvertVariableToMessageLanguage( messageVariable )
   let currentLibName = expand( "%:t:r" )

   return substitute( a:messageVariable, "^" . currentLibName . "_", "", "" )
endfunction

endif

if ( exists( "*VM_BuildMessageContentLanguage" ) == 0 )

" Fonction : VM_BuildMessageContentLanguage
"
" But : Build the message line content
"
" Parametres :
"     messageName - The message name definition
"     content - The content message definition
" Retour :
"     The message content to use
"-------------------------------------------------------------------------------
function VM_BuildMessageContentLanguage( messageName, content )
   return g:VM_languageStartComment . a:messageName . g:VM_languageEndComment . a:content . ","
endfunction

endif

if ( exists( "*VM_AddElementMessageLanguage" ) == 0 )

" Fonction : VM_AddElementMessageLanguage
"
" But : Add the definition to the specified file
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"     file - the name of the file to update
"     content - The text content to add to the file
"-------------------------------------------------------------------------------
function VM_AddElementMessageLanguage( projectFolder, language, file, content )
   execute "edit " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . a:file . ".enum"

   if ( ( line( "$" ) == 1 )&&( getline( 1 ) == "" ) )
      call setline( 1, g:VM_languageIndent . a:content )
   else
      call append( line( "$" ), g:VM_languageIndent . a:content )
   endif

   write
endfunction

endif

if ( exists( "*VM_BuildMessageValue" ) == 0 )

" Fonction : VM_BuildMessageValue
"
" But : Build the message value by replacing the dedicated text by the message
"       value
"
" Parametres :
"     baseValue - The base value where the message subtitution had to be done
"     message - The message name
" Retour :
"     The value built
"-------------------------------------------------------------------------------
function VM_BuildMessageValue( baseValue, messageName )
   let retValue = substitute( a:baseValue, "\\[@MESSAGE_NAME@\\]", a:messageName, "g" )

   return substitute( retValue, "\\[@MESSAGE_ENUM@\\]", toupper( a:messageName ), "g" )
endfunction

endif

if ( exists( "*VM_AddAllMessageLanguage" ) == 0 )

" Fonction : VM_AddAllMessageLanguage
"
" But : Add the message definition to the specified language
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"     messageName - the name of the message to be added
"-------------------------------------------------------------------------------
function VM_AddAllMessageLanguage( projectFolder, language, messageName )
   if ( a:language == g:VM_languageDefaultName )
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileMessage, VM_BuildMessageContentLanguage( a:messageName, g:VM_languageDefaultValue ) )
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamUsage, VM_BuildMessageContentLanguage( a:messageName, g:VM_languageDefaultParamUsage ) )
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamOrder, VM_BuildMessageContentLanguage( a:messageName, g:VM_languageDefaultParamOrder ) )
   else
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileMessage, VM_BuildMessageContentLanguage( a:messageName, VM_BuildMessageValue( g:VM_languageInitValue, a:messageName ) ) )
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamUsage, VM_BuildMessageContentLanguage( a:messageName, VM_BuildMessageValue( g:VM_languageInitParamUsage, a:messageName ) ) )
      call VM_AddElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamOrder, VM_BuildMessageContentLanguage( a:messageName, VM_BuildMessageValue( g:VM_languageInitParamOrder, a:messageName ) ) )
   endif
endfunction

endif

if ( exists( "*VM_AddMessageLanguage" ) == 0 )

" Fonction : VM_AddMessageLanguage
"
" But : Add a message for the lib at the end of the current message list.
"
" Buffer : 
"     The file where the message enum are added
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     messageName - the name of the message to be added
"-------------------------------------------------------------------------------
function VM_AddMessageLanguage( projectFolder, messageName )
   let variableMessageId = VM_ConvertMessageToVariableLanguage( a:messageName )
   let enumMessageId = toupper( variableMessageId )
   let messageAlreadyExisting = search( "^" . g:VM_languageIndent . enumMessageId . ",$", "wn" )

   if ( messageAlreadyExisting == 0 )
      if ( ( line( "$" ) == 1 )&&( getline( 1 ) == "" ) )
         call setline( line( "$" ), g:VM_languageIndent . enumMessageId . "," )
      else
         call append( line( "$" ), g:VM_languageIndent . enumMessageId . "," )
      endif

      execute "split " . expand( "%:r" ) . ".h"

      let lineNumber = search( "< Variables Languages >", "w" ) - 2

      call append( lineNumber, g:VM_languageDeclareVariable . variableMessageId . ";" )

      write

      call VM_AddAllMessageLanguage( a:projectFolder, g:VM_languageDefaultName, a:messageName )

      for currentLanguage in VM_GetLanguageList( a:projectFolder )
         call VM_AddAllMessageLanguage( a:projectFolder, currentLanguage, a:messageName )
      endfor

      quit
      write!
   else
      echo "The message is already defined."
   endif
endfunction

endif

if ( exists( "*VM_DelElementMessageLanguage" ) == 0 )

" Fonction : VM_DelElementMessageLanguage
"
" But : Delete the message from the specified file
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"     file - the name of the file to update
"     lineNumber - The line where the message to delete can be found
"-------------------------------------------------------------------------------
function VM_DelElementMessageLanguage( projectFolder, language, file, lineNumber )
   execute "edit " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . a:file . ".enum"

   execute a:lineNumber . " delete"

   write
endfunction

endif

if ( exists( "*VM_DelMessageLanguage" ) == 0 )

" Fonction : VM_DelMessageLanguage
"
" But : Delete the message at the current position for the lib
"
" Buffer : 
"     The message enum where the constants are created
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"-------------------------------------------------------------------------------
function VM_DelMessageLanguage( projectFolder )
   let lineNumber = line( "." )

   if ( ( lineNumber > 1 )||( getline( lineNumber ) > "" ) )
      delete

      execute "split " . expand( "%:r" ) . ".h"

      execute "/< Variables Messages >/+" . ( lineNumber + 1 ) . " delete"

      write

      call VM_DelElementMessageLanguage( a:projectFolder, g:VM_languageDefaultName, g:VM_languageFileMessage, lineNumber )
      call VM_DelElementMessageLanguage( a:projectFolder, g:VM_languageDefaultName, g:VM_languageFileParamUsage, lineNumber )
      call VM_DelElementMessageLanguage( a:projectFolder, g:VM_languageDefaultName, g:VM_languageFileParamOrder, lineNumber )

      for currentLanguage in VM_GetLanguageList( a:projectFolder )
         call VM_DelElementMessageLanguage( a:projectFolder, currentLanguage, g:VM_languageFileMessage, lineNumber )
         call VM_DelElementMessageLanguage( a:projectFolder, currentLanguage, g:VM_languageFileParamUsage, lineNumber )
         call VM_DelElementMessageLanguage( a:projectFolder, currentLanguage, g:VM_languageFileParamOrder, lineNumber )
      endfor

      quit
      write!
   else
      echo "No more message to delete.\n"
   endif
endfunction

endif

if ( exists( "*VM_OpenLanguage" ) == 0 )

" Fonction : VM_OpenLanguage
"
" But : Open the message file for the specified language
"
" Buffer : 
"     The buffer where the files will be opened
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"-------------------------------------------------------------------------------
function VM_OpenLanguage( projectFolder, language )
   execute "edit " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileMessage . ".enum"
   execute "split " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamUsage . ".enum"
   execute "split " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . g:VM_languageFileParamOrder . ".enum"
endfunction

endif

if ( exists( "*VM_BuildClassOpenLanguage" ) == 0 )

" Fonction : VM_BuildClassOpenLanguage
"
" But : Build the object that describe the class to open file.
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     baseFilename - The filename that owns the enum of the messages
" Retour :
"     The object ot be used in the class to open function call : VM_ClassOpenDefinition
"-------------------------------------------------------------------------------
function VM_BuildClassOpenLanguage( projectFolder, baseFilename )
   let fileToOpen = {}
   let fileToOpen.class = "lang"
   let fileToOpen.folder = a:projectFolder . "/" . g:VM_languageRepository
   let fileToOpen.ext = fnamemodify( a:baseFilename, ":e" )
   let fileToOpen.file = fnamemodify( a:baseFilename, ":r" )
   let fileToOpen.position = ""

   return fileToOpen
endfunction

endif

if ( exists( "*VM_MoveNextMessageDefinitionLanguage" ) == 0 )

" Fonction : VM_MoveNextMessageDefinitionLanguage
"
" But : Move to the next language definition
"
" Buffer : 
"     One of the three files that define the language
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"-------------------------------------------------------------------------------
function VM_MoveNextMessageDefinitionLanguage( projectFolder )
   let currentFile = expand( "%:t:r" )
   let currentLanguage = tolower( expand( "%:h:t" ) )
   let listLanguages = VM_GetLanguageList( a:projectFolder )

   if ( len( listLanguages ) <= 1 )
      echo "There is no other language to move to.\n"
   else
      let nextIndex = index( listLanguages, currentLanguage ) + 1
      if ( nextIndex >= len( listLanguages ) )
         let nextIndex = 0
      endif

      if ( currentFile == g:VM_languageFileMessage )
         2 wincmd j
      elseif ( currentFile == g:VM_languageFileParamUsage )
         wincmd j
      elseif ( currentFile != g:VM_languageFileParamOrder )
         let nextIndex = -1

         echo "The current file is not any of the three files used to define messages.\n"
      endif

      if ( nextIndex >= 0 )
         let currentFile = expand( "%:t:r" )

         while ( currentFile != g:VM_languageFileMessage )
            if ( &modified != 0 )
               write
            endif

            quit

            let currentFile = expand( "%:t:r" )
         endwhile

         if ( &modified != 0 )
            write
         endif

         call VM_OpenLanguage( a:projectFolder, listLanguages[ nextIndex ] )

         2 wincmd k
         wincmd =
      endif
   endif
endfunction

endif

if ( exists( "*VM_UpdElementMessageLanguage" ) == 0 )

" Fonction : VM_UpdElementMessageLanguage
"
" But : Update one of the definition file on a message name change
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"     file - the name of the file to update
"     currentLine - The line of the message to be updated
"     oldMessageName - The current name of the message to be renamed
"     newMessageName - The new name to give t the message to update
"-------------------------------------------------------------------------------
function VM_UpdElementMessageLanguage( projectFolder, language, file, currentLine, oldMessageName, newMessageName )
   execute "edit " . a:projectFolder . "/" . g:VM_languageRepository . "/" . toupper( a:language ) . "/" . a:file . ".enum"

   call setline( a:currentLine, substitute( getline( a:currentLine ), "\\<" . a:oldMessageName . "\\>", a:newMessageName, "" ) )

   write
endfunction

endif

if ( exists( "*VM_UpdAllMessageLanguage" ) == 0 )

" Fonction : VM_UpdAllMessageLanguage
"
" But : Update the message name in all of the message definition files
"
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     language - The language to be updated
"     currentLine - The line of the message to be updated
"     oldMessageName - The current name of the message to be renamed
"     newMessageName - The new name to give t the message to update
"-------------------------------------------------------------------------------
function VM_UpdAllMessageLanguage( projectFolder, language, currentLine, oldMessageName, newMessageName )
   call VM_UpdElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileMessage, a:currentLine, a:oldMessageName, a:newMessageName )
   call VM_UpdElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamUsage, a:currentLine, a:oldMessageName, a:newMessageName )
   call VM_UpdElementMessageLanguage( a:projectFolder, a:language, g:VM_languageFileParamOrder, a:currentLine, a:oldMessageName, a:newMessageName )
endfunction

endif

if ( exists( "*VM_UpdateMessageLanguage" ) == 0 )

" Fonction : VM_UpdateMessageLanguage
"
" But : Update the specified message name
"
" Buffer : 
"     The file that contains the enum for the messages
" Parametres :
"     projectFolder - the base of the library folder where the definition can be gotten
"     messageName - The name to give t the message to update
"-------------------------------------------------------------------------------
function VM_UpdateMessageLanguage( projectFolder, messageName )
   let variableMessageId = VM_ConvertMessageToVariableLanguage( a:messageName )
   let enumMessageId = toupper( variableMessageId )
   let currentLine = line( "." )
   let oldValue = getline( currentLine )

   call setline( currentLine, "" )

   let messageAlreadyExisting = search( "^" . g:VM_languageIndent . enumMessageId . ",$", "wn" )

   if ( messageAlreadyExisting == 0 )
      call setline( currentLine, g:VM_languageIndent . enumMessageId . "," )

      execute "split " . expand( "%:r" ) . ".h"

      let lineNumber = search( "< Variables Messages >", "w" ) + 1 + currentLine
      let oldMessageName = VM_ConvertVariableToMessageLanguage( substitute( substitute( getline( lineNumber ), "^" . g:VM_languageDeclareVariable, "", "" ), ";$", "", "" ) )

      call setline( lineNumber, g:VM_languageDeclareVariable . variableMessageId . ";" )

      write

      call VM_UpdAllMessageLanguage( a:projectFolder, g:VM_languageDefaultName, currentLine, oldMessageName, a:messageName )

      for currentLanguage in VM_GetLanguageList( a:projectFolder )
         call VM_UpdAllMessageLanguage( a:projectFolder, currentLanguage, currentLine, oldMessageName, a:messageName )
      endfor

      quit
      write!
   else
      call setline( currentLine, oldValue )

      echo "The new message name is already used, cannot rename.\n"
   endif
endfunction

endif

if ( exists( "*VM_GetFolderBaseLanguage" ) == 0 )

" Fonction : VM_GetFolderBaseLanguage
"
" But : Get the folder base language from the current file.
"
" Retour :
"    The name of the folder base
"-------------------------------------------------------------------------------
function VM_GetFolderBaseLanguage()
   let currentFolder = "%:h"
   let retValue = expand( currentFolder )

   while ( filewritable( retValue . "/" . g:VM_languageRepository ) != 2 )
      let currentFolder .= ":h"

      if ( retValue == "." )
         let retValue = ""

         break
      endif

      let retValue = expand( currentFolder )
   endwhile

   return retValue
endfunction

endif

if ( exists( "*VM_OpenTabLanguage" ) == 0 )

" Fonction : VM_OpenTabLanguage
"
" But : Open the language definition tab
"-------------------------------------------------------------------------------
function VM_OpenTabLanguage()
   let folderName = VM_GetFolderBaseLanguage()

   if ( folderName > "" )
      let g:projectFolder = folderName

      call VM_MarkWindow()
      call VM_ProjectBuildClass()

      unlet g:projectFolder
   else
      call input( "" )

      echo "No language defined.\n"
   endif
endfunction

endif

if ( exists( "*VM_GetVariableName" ) == 0 )

" Fonction : VM_GetVariableName
"
" But : Get the variable name corresponding to the current enum
"
" Parametres :
"     projectFolder - the base of the folder where the language definition can be found
"     filename - the base name of the language definition to open
"     lineNum - the line number of the variable to be gotten
" Retour :
"     The variable name
"-------------------------------------------------------------------------------
function VM_GetVariableName( projectFolder, filename, lineNum )
   let usedFilename = split( expand( a:projectFolder . "/" . g:VM_languageRepository . "/" . a:filename . ".h" ), "\n" )

   if ( len( usedFilename ) == 0 )
      throw "No header file found...";
   endif

   execute "split " . usedFilename[ 0 ]

   let lineNumber = search( "< Variables Messages >", "w" ) + 1 + a:lineNum
   let retValue = strpart( getline( lineNumber ), len( g:VM_languageDeclareVariable ) )

   quit

   return substitute( retValue, ";$", "", "" )
endfunction

endif

if ( exists( "*VM_UseVariableMessageLanguage" ) == 0 )

" Fonction : VM_UseVariableMessageLanguage
"
" But : Use the variable name to be input in the switched file
"
" Parametres :
"     projectFolder - the base of the folder where the language definition can be found
"     filename - the base name of the language definition to open
"-------------------------------------------------------------------------------
function VM_UseVariableMessageLanguage( projectFolder, filename )
   let variableName = VM_GetVariableName( a:projectFolder, a:filename, line( "." ) )

   if ( exists( "g:VM_previousTab" ) != 0 )
      call VM_SwitchTab()

      let currentLineNum = line( "." )
      let currentLine = getline( currentLineNum )
      let currentColNum = col( "." )
      let endLine = strpart( currentLine, currentColNum )
      let currentLine = strpart( currentLine, 0, currentColNum )

      call setline( currentLineNum, currentLine . variableName . endLine )
   endif
endfunction

endif

if ( exists( "*VM_SearchVariableMessageLanguage" ) == 0 )

" Fonction : VM_SearchVariableMessageLanguage
"
" But : Search in the switched file.
"
" Parametres :
"     projectFolder - the base of the folder where the language definition can be found
"     filename - the base name of the language definition to open
"-------------------------------------------------------------------------------
function VM_SearchVariableMessageLanguage( projectFolder, filename )
   let variableName = VM_GetVariableName( a:projectFolder, a:filename, line( "." ) )

   if ( exists( "g:VM_previousTab" ) != 0 )
      call VM_SwitchTab()

      if ( search( "\\<" . variableName . "\\>", "wz" ) == 0 )
         echo "The message " . variableName . " is not used in this file.\n"
      endif
   endif
endfunction

endif

if ( exists( "*VM_SearchProjectMessageLanguage" ) == 0 )

" Fonction : VM_SearchProjectMessageLanguage
"
" But : Search the current message in the whole project.
"
" Parametres :
"     projectFolder - the base of the folder where the language definition can be found
"     filename - the base name of the language definition to open
"-------------------------------------------------------------------------------
function VM_SearchProjectMessageLanguage( projectFolder, filename )
   let variableName = VM_GetVariableName( a:projectFolder, a:filename, line( "." ) )
   let searchList = ""

   for extention in g:VM_languageSearchList
      let searchList .= a:projectFolder . "/**/" . extention . " "
   endfor

   if ( searchList == "" )
      echo "No search list defined."
   else
      tabnew
      execute "vimgrep /\\<" . variableName . "\\>/ " . searchList
      copen
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "g:VM_languageRepository" ) == 0 )
   let g:VM_languageRepository = "LANGUAGE"
endif

if ( exists( "g:VM_languageDefaultSize" ) == 0 )
   let g:VM_languageDefaultSize = 10
endif

if ( exists( "g:VM_languageDefaultName" ) == 0 )
   let g:VM_languageDefaultName = "undefined_language"
endif

if ( exists( "g:VM_languageDefaultValue" ) == 0 )
   let g:VM_languageDefaultValue = "NULL"
endif

if ( exists( "g:VM_languageDefaultParamUsage" ) == 0 )
   let g:VM_languageDefaultParamUsage = "0x0000"
endif

if ( exists( "g:VM_languageDefaultParamOrder" ) == 0 )
   let g:VM_languageDefaultParamOrder = "0x0000000000000000"
endif

if ( exists( "g:VM_languageInitValue" ) == 0 )
   let g:VM_languageInitValue = "\"<@[@MESSAGE_NAME@]_text@>\""
endif

if ( exists( "g:VM_languageInitParamUsage" ) == 0 )
   let g:VM_languageInitParamUsage = "0x<@[@MESSAGE_ENUM@]_PARAMUSAGE@>"
endif

if ( exists( "g:VM_languageInitParamOrder" ) == 0 )
   let g:VM_languageInitParamOrder = "0x<@[@MESSAGE_ENUM@]_PARAMORDER@>"
endif

if ( exists( "g:VM_languageIndent" ) == 0 )
   let g:VM_languageIndent = "   "
endif

if ( exists( "g:VM_languageDeclareVariable" ) == 0 )
   let g:VM_languageDeclareVariable = "extern int32   "
endif

if ( exists( "g:VM_languageFileMessage" ) == 0 )
   let g:VM_languageFileMessage = "messages"
endif

if ( exists( "g:VM_languageFileParamUsage" ) == 0 )
   let g:VM_languageFileParamUsage = "paramUsage"
endif

if ( exists( "g:VM_languageFileParamOrder" ) == 0 )
   let g:VM_languageFileParamOrder = "paramOrder"
endif

if ( exists( "g:VM_languageStartComment" ) == 0 )
   let g:VM_languageStartComment = "/* "
endif

if ( exists( "g:VM_languageEndComment" ) == 0 )
   let g:VM_languageEndComment = " */        "
endif

if ( exists( "g:VM_languageNbOpen" ) == 0 )
   let g:VM_languageNbOpen = 2
endif

if ( exists( "g:VM_languageSearchList" ) == 0 )
   let g:VM_languageSearchList = [ "*.[ch]", "*.mac", "*.typ", "*.str" ]
endif

"---< Fin de fichier >----------------------------------------------------------

