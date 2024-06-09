" Fichier : projectVM.vim
"
" But : Plugin d'utilisation de projets à la mode Vinceounours
"
" Auteur : Vince "Cool Coyote" - coolcoyote@noos.fr
" Date : 22 Mar 2013
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_DeleteFirstElements" ) == 0 )

" Fonction : VM_DeleteFirstElements
"
" But : Delete the first's nth elements from the list
"
" Parametres :
"    listToUpdate - The list to be updated
"    nbElements - Nb elements to delete
"-------------------------------------------------------------------------------
function VM_DeleteFirstElements( listToUpdate, nbElements )
   let lastElement = len( a:listToUpdate )

   if ( lastElement > 0 )
      if ( lastElement > a:nbElements )
         let lastElement = a:nbElements
      endif

      call remove( a:listToUpdate, 0, lastElement - 1 )
   endif
endfunction

endif

if ( exists( "*VM_SetIgnoreCase" ) == 0 )

" Fonction : VM_SetIgnoreCase
"
" But : Set the ignore case option
"-------------------------------------------------------------------------------
function VM_SetIgnoreCase()
   if ( exists( "g:VM_OptionIgnoreCase" ) == 0 )
      let g:VM_OptionIgnoreCase = &ignorecase
   endif
   set ignorecase
endfunction

endif

if ( exists( "*VM_RestoreIgnoreCase" ) == 0 )

" Fonction : VM_RestoreIgnoreCase
"
" But : Restore the ignore case option
"-------------------------------------------------------------------------------
function VM_RestoreIgnoreCase()
   if ( exists( "g:VM_OptionIgnoreCase" ) != 0 )
      let &ignorecase = g:VM_OptionIgnoreCase
      unlet g:VM_OptionIgnoreCase
   endif
endfunction

endif

if ( exists( "*VM_SetNoIgnoreCase" ) == 0 )

" Fonction : VM_SetNoIgnoreCase
"
" But : Set the no ignore case option
"-------------------------------------------------------------------------------
function VM_SetNoIgnoreCase()
   if ( exists( "g:VM_OptionNoIgnoreCase" ) == 0 )
      let g:VM_OptionNoIgnoreCase = &ignorecase
      set noignorecase
   endif
endfunction

endif

if ( exists( "*VM_RestoreNoIgnoreCase" ) == 0 )

" Fonction : VM_RestoreNoIgnoreCase
"
" But : Restore the no ignore case option
"-------------------------------------------------------------------------------
function VM_RestoreNoIgnoreCase()
   if ( exists( "g:VM_OptionNoIgnoreCase" ) != 0 )
      let &ignorecase = g:VM_OptionNoIgnoreCase
      unlet g:VM_OptionNoIgnoreCase
   endif
endfunction

endif

if ( exists( "*VM_SetHLSearch" ) == 0 )

" Fonction : VM_SetHLSearch
"
" But : Set the ignore case option
"-------------------------------------------------------------------------------
function VM_SetHLSearch()
   if ( exists( "g:VM_OptionHLSearch" ) == 0 )
      let g:VM_OptionHLSearch = &hlsearch
   endif
   set hlsearch
endfunction

endif

if ( exists( "*VM_RestoreHLSearch" ) == 0 )

" Fonction : VM_RestoreHLSearch
"
" But : Restore the ignore case option
"-------------------------------------------------------------------------------
function VM_RestoreHLSearch()
   if ( exists( "g:VM_OptionHLSearch" ) != 0 )
      let &hlsearch = g:VM_OptionHLSearch
      unlet g:VM_OptionHLSearch
   endif
endfunction

endif

if ( exists( "*VM_SetNoHLSearch" ) == 0 )

" Fonction : VM_SetNoHLSearch
"
" But : Set the no ignore case option
"-------------------------------------------------------------------------------
function VM_SetNoHLSearch()
   if ( exists( "g:VM_OptionNoHLSearch" ) == 0 )
      let g:VM_OptionNoHLSearch = &hlsearch
      set nohlsearch
   endif
endfunction

endif

if ( exists( "*VM_RestoreNoHLSearch" ) == 0 )

" Fonction : VM_RestoreNoHLSearch
"
" But : Restore the no ignore case option
"-------------------------------------------------------------------------------
function VM_RestoreNoHLSearch()
   if ( exists( "g:VM_OptionNoHLSearch" ) != 0 )
      let &hlsearch = g:VM_OptionNoHLSearch
      unlet g:VM_OptionNoHLSearch
   endif
endfunction

endif

if ( exists( "*VM_ProjectInitialize" ) == 0 )

" Fonction : VM_ProjectInitialize
"
" But : Declare le début d'utilisation d'un nouveau projet.
"-------------------------------------------------------------------------------
function VM_ProjectInitialize()
   " Compute the folder base
   "------------------------
   let g:VM_projectBaseFolder = substitute( expand( "%:p:h" ), "\\", "/", "g" )

   " Move to the folder base
   "------------------------
   execute "cd " . g:VM_projectBaseFolder

   " Execute the project dedicated definition
   "-----------------------------------------
   if ( filereadable( ".project_def" ) != 0 )
      source .project_def
   endif

   call VM_ResetTagName()
endfunction

endif

if ( exists( "*VM_ResetTagName" ) == 0 )

" Fonction : VM_ResetTagName
"
" But : Reset the tag filename to use.
"-------------------------------------------------------------------------------
function VM_ResetTagName()
   " Get the tag option name
   "------------------------
   let additionnal_tags_files = ""

   if ( exists( "g:VM_projectCommonTags" ) != 0 )
      let additionnal_tags_files = g:VM_projectCommonTags
   endif

   if ( additionnal_tags_files > "" )
      let additionnal_tags_files = "," . additionnal_tags_files
   endif

   if ( exists( "g:VM_projectSpecificTags" ) != 0 )
      if ( g:VM_projectSpecificTags > "" )
         let additionnal_tags_files = "," . g:VM_projectSpecificTags . additionnal_tags_files
      endif
   endif

   " Get the first tags file to look for
   "------------------------------------
   let beforeTags = ""

   if ( exists( "g:VM_projectBeforeTags" ) != 0 )
      if ( g:VM_projectBeforeTags > "" )
         let beforeTags = g:VM_projectBeforeTags . ","
      endif
   endif

   " Set the tag option
   "-------------------
   execute "set tags=" . beforeTags . g:VM_projectBaseFolder . "/" . g:VM_projectTagName . additionnal_tags_files
endfunction

endif

if ( exists( "*VM_UseTabFile" ) == 0 )

" Fonction : VM_UseTabFile
"
" But : Goto the tab and the specified file
"
" Parametres :
"    tabNumber - The number of the tab to go to
"    winNumber - The number of the window to go to in the tab
"-------------------------------------------------------------------------------
function VM_UseTabFile( tabNumber, winNumber )
   close
   close

   call VM_GotoTabFile( a:tabNumber, a:winNumber )
endfunction

endif

if ( exists( "*VM_TabSelected" ) == 0 )

" Fonction : VM_TabSelected
"
" But : Go to the buffer associated to the current line number.
"-------------------------------------------------------------------------------
function VM_TabSelected( selectMode )
   if ( b:usedTab < len( b:tabsBufferListAvailable ) )
      let arrayBuffer = b:tabsBufferListAvailable[ b:usedTab ]
      let selectedBuffer = line( "." )

      if ( b:usedTab == 0 )
         let selectedBuffer -= 1

         if ( selectedBuffer < len( arrayBuffer ) )
            let currentBuffer = arrayBuffer[ selectedBuffer ]
            let tabListSize = len( currentBuffer.tabList )
            let tabNumber = -1

            if ( tabListSize == 0 )
               echo "Trying to go to a non tabbed file.\n"
            elseif ( tabListSize == 1 )
               let tabNumber = currentBuffer.tabList[ 0 ]
            elseif ( a:selectMode == 0 )
               let listSelect = [ "Select tab :" ]
               let listDistinctTabs = []
               let choiceNumber = 0
               let lastNumber = 0

               for tabNumber in currentBuffer.tabList
                  if ( ( lastNumber +  0 ) < ( tabNumber + 0 ) )
                     let choiceNumber += 1

                     call add( listSelect, choiceNumber . " . Tab N°" . tabNumber )
                     call add( listDistinctTabs, tabNumber )

                     let lastNumber = tabNumber
                  endif
               endfor

               if ( choiceNumber > 1 )
                  let tabNumber = inputlist( listSelect )

                  if ( tabNumber > len( listDistinctTabs ) )
                     echo "\nWrong choice, there is no existing tab at position " . tabNumber . "\n"
                     let tabNumber = 0
                  elseif ( tabNumber > 0 )
                     let tabNumber = listDistinctTabs[ tabNumber - 1 ]

                     echo "\n"
                  endif
               else
                  let tabNumber = listDistinctTabs[ 0 ]
               endif
            elseif ( a:selectMode < 0 )
               let tabNumber = listDistinctTabs[ 0 ]
            else
               let tabNumber = listDistinctTabs[ choiceNumber - 1 ]
            endif

            if ( ( tabNumber + 0 ) > 0 )
               let filePositions = []
               let choicePosition = [ "Select window number:" ]
               let currentPosition = 0
               let currentChoiceNumber = 0

               for tabCurrentBuffer in b:tabsBufferListAvailable[ tabNumber ]
                  let currentPosition += 1

                  if ( tabCurrentBuffer == currentBuffer )
                     call add( filePositions, currentPosition )

                     let currentChoiceNumber += 1

                     call add( choicePosition, currentChoiceNumber . " . Window N°" . currentPosition )
                  endif
               endfor

               let filePositionSize = len( filePositions )
               let filePositionSelected = 0

               if ( filePositionSize == 0 )
                  echo "File is no more available in the tab.\n"
               elseif ( filePositionSize == 1 )
                  let filePositionSelected = filePositions[ 0 ]
               elseif ( a:selectMode == 0 )
                  let selectedPosition = inputlist( choicePosition ) - 1

                  if ( selectedPosition > currentChoiceNumber )
                     echo "\nWrong choice, no existing buffer at position " . ( selectedPosition + 1 ) . "\n"
                  elseif ( selectedPosition >= 0 )
                     let filePositionSelected = filePositions[ selectedPosition ]
                  endif
               elseif ( a:selectMode < 0 )
                  let filePositionSelected = filePositions[ 0 ]
               else
                  let filePositionSelected = filePositions[ currentChoiceNumber - 1 ]
               endif

               if ( filePositionSelected > 0 )
                  call VM_MarkOriginalWindow()
                  call VM_UseTabFile( tabNumber, filePositionSelected )
               else
                  wincmd h
                  execute ( tabNumber + 1 )
                  call VM_DisplayCorrespondingBufferTabs()

                  if ( filePositionSize > 0 )
                     execute filePositions[ 0 ]
                  endif
               endif
            endif
         else
            echo "Trying to use an non existing buffer.\n"
         endif
      else
         call VM_MarkOriginalWindow()
         call VM_UseTabFile( b:usedTab, selectedBuffer )
      endif
   else
      echo "Trying to use a not existing tab.\n"
   endif
endfunction

endif

if ( exists( "*VM_MapCtrlEnter" ) == 0 )

" Fonction : VM_MapCtrlEnter
"
" But : Define the map for c Ctrl enter mapping
"
" Parametres :
"    mapType - prefixe to the map command for the map type ( c, o, blank or any other subtype )
"    mapPost - suffixe to the map command for using it only on the current buffer for example
"    command - the command associated to the current map
"-------------------------------------------------------------------------------
function VM_MapCtrlEnter( mapType, mapPost, command )
   execute a:mapType . "map" . a:mapPost . " " . g:VM_projectCtrlEnter . " " . a:command
endfunction

endif

if ( exists( "*VM_MapSearchGrep" ) == 0 )

" Fonction : VM_MapSearchGrep
"
" But : Map the keys for the search definition.
"-------------------------------------------------------------------------------
function VM_MapSearchGrep()
   if ( ( exists( "g:VM_terminalUsage" ) == 0 )&&( exists( "g:VM_AlternativeSearchedFileList" ) != 0 ) )
      execute "cmap <S-C-CR> " . g:VM_AlternativeSearchedFileList
   endif
   if ( exists( "g:VM_ShiftSearchedFileList" ) != 0 )
      execute "cmap " . g:VM_projectShiftEnter . " " . g:VM_ShiftSearchedFileList
   endif
   if ( exists( "g:VM_ControlSearchedFileList" ) != 0 )
      call VM_MapCtrlEnter( "c", " ", g:VM_ControlSearchedFileList )
   endif
   if ( exists( "g:VM_AllSearchedFileList" ) != 0 )
      execute "cmap <C-End> " . g:VM_AllSearchedFileList
   endif
   if ( exists( "g:VM_UpSearchedFolder" ) != 0 )
      execute "cmap <PageUp> " . g:VM_UpSearchedFolder
   endif
   if ( exists( "g:VM_DownSearchedFolder" ) != 0 )
      execute "cmap <PageDown> " . g:VM_DownSearchedFolder
   endif
   if ( exists( "g:VM_ShiftUpSearchedFolder" ) != 0 )
      execute "cmap <S-PageUp> " . g:VM_ShiftUpSearchedFolder
   endif
   if ( exists( "g:VM_ShiftDownSearchedFolder" ) != 0 )
      execute "cmap <S-PageDown> " . g:VM_ShiftDownSearchedFolder
   endif
endfunction

endif

if ( exists( "*VM_GotoTabFile" ) == 0 )

" Fonction : VM_GotoTabFile
"
" But : Goto the specified tab and file.
"
" Parametres :
"    tabNumber - The number of the tab to go to
"    winNumber - The number of the window to go to in the tab
"-------------------------------------------------------------------------------
function VM_GotoTabFile( tabNumber, winNumber )
   execute a:tabNumber . "tabnext"
   execute a:winNumber . "wincmd w"
endfunction

endif

if ( exists( "*VM_MarkWindow" ) == 0 )

" Fonction : VM_MarkWindow
"
" But : Mark the current position to be able to come back here
"-------------------------------------------------------------------------------
function VM_MarkWindow()
   let g:VM_previousTab = tabpagenr()
   let g:VM_previousWindow = winnr()
endfunction

endif

if ( exists( "*VM_MarkOriginalWindow" ) == 0 )

" Fonction : VM_MarkOriginalWindow
"
" But : Use the original window as the previous window.
"-------------------------------------------------------------------------------
function VM_MarkOriginalWindow()
   let g:VM_previousTab = g:VM_returnTab
   let g:VM_previousWindow = g:VM_returnWindow
endfunction

endif

if ( exists( "*VM_SwitchTab" ) == 0 )

" Fonction : VM_SwitchTab
"
" But : Switch to the previous recorded tab and file. If no tab and file were
"       recorded yet, record the current one.
"-------------------------------------------------------------------------------
function VM_SwitchTab()
   if ( exists( "g:VM_previousTab" ) != 0 )
      let tabToGo = g:VM_previousTab
      let winToGo = g:VM_previousWindow

      call VM_MarkWindow()
      call VM_GotoTabFile( tabToGo, winToGo )
   else
      call VM_MarkWindow()
   endif
endfunction

endif

if ( exists( "*VM_UnswitchTab" ) == 0 )

" Fonction : VM_UnswitchTab
"
" But : Delete the previously recorded switch tab.
"-------------------------------------------------------------------------------
function VM_UnswitchTab()
   if ( exists( "g:VM_previousTab" ) != 0 )
      unlet g:VM_previousTab
   endif

   if ( exists( "g:VM_previousWindow" ) != 0 )
      unlet g:VM_previousWindow
   endif
endfunction

endif

if ( exists( "*VM_ProjectAnalyze" ) == 0 )

" Fonction : VM_ProjectAnalyze
"
" But : Analyze the current project.
"-------------------------------------------------------------------------------
function VM_ProjectAnalyze()
   if ( exists( "g:VM_classesAllLines" ) != 0 )
      unlet g:VM_classesAllLines
   endif

   let outFile = ""

   if ( exists( "g:VM_projectCTagsOut" ) != 0 )
      let outFile = " " . g:VM_projectCTagsOut . " " . g:VM_projectBaseFolder . "/" . g:VM_projectTagName . " "
   endif " End IF the tag output file had to be set

   return system( g:VM_projectCTags . outFile . g:VM_ctagsFolders )
endfunction

endif

if ( exists( "*VM_ProjectFunctionExecute" ) == 0 )

" Fonction : VM_ProjectFunctionExecute
"
" But : Execute the function file specified.
"
" Parametres :
"    fileExecute - string : The file to be executed
"-------------------------------------------------------------------------------
function VM_ProjectFunctionExecute( fileExecute )
   if ( ( exists( "g:VM_projectLocalDirAlternate" ) != 0 )&&( filereadable( expand( g:VM_projectLocalDirAlternate . "/" . a:fileExecute ) ) != 0 ) )
      execute "source " . g:VM_projectLocalDirAlternate . "/" . a:fileExecute
   " End IF the terminal mapping had been found in the local function folder
   elseif ( ( exists( "g:VM_projectDirAlternate" ) != 0 )&&( filereadable( expand( g:VM_projectDirAlternate . "/" . a:fileExecute ) ) != 0 ) )
      execute "source " . g:VM_projectDirAlternate . "/" . a:fileExecute
   endif " End IF the terminal mapping had been found in the project function folder
endfunction

endif

if ( exists( "*VM_ProjectTerminalMappingFile" ) == 0 )

" Fonction : VM_ProjectTerminalMappingFile
"
" But : Execute the mapping code for a terminal definition.
"
" Parametres :
"     mappingFile - The base of the mapping file to execute
"-------------------------------------------------------------------------------
function VM_ProjectTerminalMappingFile( mappingFile )
   if ( exists( "g:VM_xtermDefinition" ) != 0 )
      let terminalFile = a:mappingFile . g:VM_xtermDefinition . ".vim"
   " End IF we are using the specified terminal mapping
   elseif ( $TERM == "" )
      let terminalFile = a:mappingFile . "Default.vim"
   else " End IF we must use the default terminal mapping
      let terminalFile = a:mappingFile . "-" . $TERM . ".vim"
   endif " End IF use the terminal corresponding to the definition

   call VM_ProjectFunctionExecute( terminalFile )
endfunction

endif

if ( exists( "*VM_ProjectEnterFile" ) == 0 )

" Fonction : VM_ProjectEnterFile
"
" But : Enter in a file
"-------------------------------------------------------------------------------
function VM_ProjectEnterFile()

   " J'initialise les tailles de tabulation
   "---------------------------------------
   setlocal shiftwidth=3
   setlocal tabstop=3
   setlocal expandtab
   setlocal autoindent
   setlocal showmode
   setlocal textwidth=0

   call VM_ProjectFunctionExecute( "defaultMapping.vim" )

   if ( exists( "g:VM_terminalUsage" ) == 0 )
      call VM_ProjectFunctionExecute( "graphicMapping.vim" )
   else
      call VM_ProjectTerminalMappingFile( "termMapping" )
   endif

   call VM_MapSearchGrep()

   if ( exists( "g:VM_bepoUsage" ) != 0 )
      nnoremap , ;
      nnoremap ; ,
      vnoremap , ;
      vnoremap ; ,
      onoremap , ;
      onoremap ; ,
   endif

   if ( ( exists( "g:VM_projectDefaultEnteringFileInit" ) != 0 )&&( filereadable( expand( g:VM_projectDefaultEnteringFileInit ) ) != 0 ) )
      execute "source " . g:VM_projectDefaultEnteringFileInit
   endif

   if ( ( exists( "g:VM_projectLocalEnteringFileInit" ) != 0 )&&( filereadable( expand( g:VM_projectLocalEnteringFileInit ) ) != 0 ) )
      execute "source " . g:VM_projectLocalEnteringFileInit
   endif

   if ( expand( "%" ) == "" )
      call VM_ProjectExecuteEnteringFile( "" )
   else
      call VM_ProjectExecuteEnteringFile( &filetype )

      " Update the file format
      "-----------------------
      if ( ( &modifiable != 0 )&&( exists( "g:VM_projectFileFormat" ) != 0 ) )
         let isAlreadyModified = &modified
         execute "set fileformat=" . g:VM_projectFileFormat

         if ( isAlreadyModified == 0 )
            set nomodified
         endif
      endif
   endif
endfunction

endif

if ( exists( "*VM_GetMinIndentation" ) == 0 )

" Fonction : VM_GetMinIndentation
"
" But : Get the minimum indentation on the area
"-------------------------------------------------------------------------------
function VM_GetMinIndentation()
   let start = line( "'<" )
   let end = line( "'>" )
   let retValue = -1

   while ( start <= end )
      let currentLine = getline( start )

      if ( substitute( currentLine, "[ \t]\\+", "", "" ) > "" )
         let currentIndent = len( substitute( currentLine, "[^ \t].*", "", "" ) )

         if ( retValue < 0 )
            let retValue = currentIndent
         elseif ( retValue > currentIndent )
            let retValue = currentIndent
         endif
      endif

      let start += 1
   endwhile

   return retValue
endfunction

endif

if ( exists( "*VM_CommentAtMinIndente" ) == 0 )

" Fonction : VM_CommentAtMinIndente
"
" But : Comment the designed area
"
" Parametres :
"    textComment - The text to add for setting the comment
"-------------------------------------------------------------------------------
function VM_CommentAtMinIndente( textComment )
   let positionComment = VM_GetMinIndentation()

   if ( positionComment >= 0 )
      let start = line( "'<" )
      let end = line( "'>" )

      while ( start <= end )
         let currentLine = getline( start )

         if ( len( currentLine ) > positionComment )
            call setline( start, strpart( currentLine, 0, positionComment ) . a:textComment . strpart( currentLine, positionComment ) )
         endif

         let start += 1
      endwhile
   endif
endfunction

endif

if ( exists( "*VM_ProjectExecuteEnteringFile" ) == 0 )

" Fonction : VM_ProjectExecuteEnteringFile
"
" But : Execute the specified file from the entering folder
"
" Parametres :
"    fileToExec - The filename to execute
"-------------------------------------------------------------------------------
function VM_ProjectExecuteEnteringFile( fileToExec )
   " Je teste l'existance du fichier de description générale du type de fichier
   "---------------------------------------------------------------------------
   let fileExecute = g:VM_projectDirEnterFile . "/" . a:fileToExec . ".vim"

   if ( filereadable( expand( fileExecute ) ) != 0 )
      execute "source " . fileExecute
   endif

   if ( exists( "g:VM_projectLocalDirEnterFile" ) != 0 )
      " Je teste l'existance du fichier de description locale au projet courant
      "------------------------------------------------------------------------
      let fileExecute = g:VM_projectLocalDirEnterFile . "/" . a:fileToExec . ".vim"

      if ( filereadable( expand( fileExecute ) ) != 0 )
         execute "source " . fileExecute
      endif
   endif
endfunction

endif

if ( exists( "*VM_ProjectLeaveFile" ) == 0 )

" Fonction : VM_ProjectLeaveFile
"
" But : Leave in a file
"-------------------------------------------------------------------------------
function VM_ProjectLeaveFile()
   call VM_ProjectExecuteLeavingFile( &filetype )
endfunction

endif

if ( exists( "*VM_ProjectExecuteLeavingFile" ) == 0 )

" Fonction : VM_ProjectExecuteLeavingFile
"
" But : Execute the specified file from the leaving folder
"
" Buffer :
"
" Parametres :
"    fileToExec - The filename to execute
"-------------------------------------------------------------------------------
function VM_ProjectExecuteLeavingFile( fileToExec )
   if ( exists( "g:VM_projectLocalDirLeaveFile" ) != 0 )
      " Je teste l'existance du fichier de description locale au projet courant
      "------------------------------------------------------------------------
      let fileExecute = g:VM_projectLocalDirLeaveFile . "/" . a:fileToExec . ".vim"

      if ( filereadable( expand( fileExecute ) ) != 0 )
         execute "source " . fileExecute
      endif
   endif

   " Je teste l'existance du fichier de construction des commentaires
   "-----------------------------------------------------------------
   let fileExecute = g:VM_projectDirLeaveFile . "/" . a:fileToExec . ".vim"

   if ( filereadable( expand( fileExecute ) ) != 0 )
      execute "source " . fileExecute
   endif

   call VM_CleanDictionary()
endfunction

endif

if ( exists( "*VM_ProjectCalculExcelDate" ) == 0 )

" Fonction : VM_ProjectCalculExcelDate
"
" But : Compute the excel date into a human one.
"
" Parametres :
"     dateEx - Nombre représentant une date au format excel
" Retour :
"     Chaine de caractères qui représente la date au format DD MMM YYYY
"-------------------------------------------------------------------------------
function VM_ProjectCalculExcelDate( dateEx )
   " 1522 est le 1er mars 1600, en fait c'est faux, parce que excel considère qu'il y a eu un 29 feb 1900 !!!
   "---------------------------------------------------------------------------------------------------------
   let baseDate = a:dateEx + 109511
   " let baseDate = a:dateEx + 110973
   " Calcul le nombre d'année écoulées ainsi que le nombre de jours
   "---------------------------------------------------------------
   let nbBaseYear = baseDate / 365
   let nbDaysInYear = baseDate - ( nbBaseYear * 365 )
   " Calcul le nombre d'années bisextiles
   "-------------------------------------
   let nbBisextile = nbBaseYear / 4
   let nbBisextile = nbBisextile - ( nbBaseYear / 100 )
   let nbBisextile = nbBisextile + ( nbBaseYear / 400 )
   " Re-calcule le nombre de jour écoulés depuis le 1er mar de l'année en cours
   "---------------------------------------------------------------------------
   let nbDaysInYear = nbDaysInYear - nbBisextile
   while ( nbDaysInYear < 0 )
      let nbDaysInYear = nbDaysInYear + 365
      " Le coup du nbBaseYear == 300 c'est encore et toujours pour notre 29 Feb 1900
      "-----------------------------------------------------------------------------
      if ( ( ( ( nbBaseYear / 4 ) * 4 ) == nbBaseYear )&&( ( ( ( nbBaseYear / 100 ) * 100 ) != nbBaseYear )||( ( ( nbBaseYear / 400 ) * 400 ) == nbBaseYear )||( nbBaseYear == 300 ) ) )
      " if ( ( ( ( nbBaseYear / 4 ) * 4 ) == nbBaseYear )&&( ( ( ( nbBaseYear / 100 ) * 100 ) != nbBaseYear )||( ( ( nbBaseYear / 400 ) * 400 ) == nbBaseYear ) ) )
         let nbDaysInYear = nbDaysInYear + 1
      endif
      let nbBaseYear = nbBaseYear - 1
   endwhile
   " Calcule le numéro du mois correspondant au jour calculé
   "--------------------------------------------------------
   let numMois = ( ( 309 * nbDaysInYear ) + 122 ) / 9455
   let numDay = nbDaysInYear - ( ( ( numMois * 9455 ) + 130 ) / 309 ) + 1
   " Détermine le nom du mois
   "-------------------------
   let tabMois_0 = "Mar"
   let tabMois_1 = "Apr"
   let tabMois_2 = "May"
   let tabMois_3 = "Jun"
   let tabMois_4 = "Jul"
   let tabMois_5 = "Aug"
   let tabMois_6 = "Sep"
   let tabMois_7 = "Oct"
   let tabMois_8 = "Nov"
   let tabMois_9 = "Dec"
   let tabMois_10 = "Jan"
   let tabMois_11 = "Feb"
   execute "let nomMois = tabMois_" . numMois
   " Replace l'année dans notre calendrier
   "--------------------------------------
   let RealYear = 1600 + nbBaseYear
   if ( numMois > 9 )
      let RealYear = RealYear + 1
   endif
   " Affiche la date
   "----------------
   return numDay . " " . nomMois . " " . RealYear
endfunction

endif

if ( exists( "*VM_ProjectBuildClass" ) == 0 )

" Fonction : VM_ProjectBuildClass
"
" But : Build a file from the specified questions.
"-------------------------------------------------------------------------------
function VM_ProjectBuildClass()
   " Récupère le nom de la classe
   "-----------------------------
   let classBuild = input( "File type : " )
   echo "\n"

   " Get the project local class definition
   "---------------------------------------
   let fileClass = ""
   if ( exists( "g:VM_projectLocalDirClasses" ) != 0 )
      let fileClass = g:VM_projectLocalDirClasses . "/" . classBuild . ".vim"

      if ( filereadable( expand( fileClass ) ) == 0 )

         " Get the default file constructor
         "---------------------------------
         let fileClass = ""
      endif
  endif

   " Get the source file to execute in the global definition
   "--------------------------------------------------------
   if ( fileClass == "" )
      let fileClass = g:VM_projectDirClasses . "/" . classBuild . ".vim"

      if ( filereadable( expand( fileClass ) ) == 0 )

         " Get the default file constructor
         "---------------------------------
         let fileClass = g:VM_projectDirClasses . "/default.vim"
      endif
   endif

   " Execute the source to build the files
   "--------------------------------------
   if ( filereadable( expand( fileClass ) ) != 0 )
      let g:VM_additionnalValues = {}
      execute "source " . fileClass
      unlet g:VM_additionnalValues
   else
      echo "No class file found.\n"
      call input( "Enter to continue..." )
   endif
endfunction

endif

if ( exists( "*VM_GetReferenceFile" ) == 0 )

" Fonction : VM_GetReferenceFile
"
" But : Get the reference file.
"
" Parametres :
"    filename - The reference file to find
" Retour :
"    The complete filename or empty string if the file cannot be found
"-------------------------------------------------------------------------------
function VM_GetReferenceFile( filename )
   let computedFileName = ""

   if ( exists( "g:VM_projectLocalDirReference" ) != 0 )
      let computedFileName = g:VM_projectLocalDirReference . "/" . a:filename

      if ( filereadable( expand( computedFileName ) ) == 0 )
         let computedFileName = ""
      endif
   endif

   if ( computedFileName == "" )
      let computedFileName = g:VM_projectDirReference . "/" . a:filename

      if ( filereadable( expand( computedFileName ) ) == 0 )
         let computedFileName = ""
      endif
   endif

   return computedFileName
endfunction

endif

if ( exists( "*VM_ConvertToUpper" ) == 0 )

" Fonction : VM_ConvertToUpper
"
" But : Convert the name to an upper name.
"
" Parametres :
"     nameToConvert - The name to translate in upper case
" Retour :
"     The converted name
"-------------------------------------------------------------------------------
function VM_ConvertToUpper( nameToConvert )
   let convertedName = substitute( a:nameToConvert, "[aàâä]", "A","g" )
   let convertedName = substitute( convertedName, "b", "B", "g" )
   let convertedName = substitute( convertedName, "c", "C", "g" )
   let convertedName = substitute( convertedName, "d", "D", "g" )
   let convertedName = substitute( convertedName, "[eéèêë]", "E", "g" )
   let convertedName = substitute( convertedName, "f", "F", "g" )
   let convertedName = substitute( convertedName, "g", "G", "g" )
   let convertedName = substitute( convertedName, "h", "H", "g" )
   let convertedName = substitute( convertedName, "[iîï]", "I", "g" )
   let convertedName = substitute( convertedName, "j", "J", "g" )
   let convertedName = substitute( convertedName, "k", "K", "g" )
   let convertedName = substitute( convertedName, "l", "L", "g" )
   let convertedName = substitute( convertedName, "m", "M", "g" )
   let convertedName = substitute( convertedName, "[nñ]", "N", "g" )
   let convertedName = substitute( convertedName, "[oôö]", "O", "g" )
   let convertedName = substitute( convertedName, "p", "P", "g" )
   let convertedName = substitute( convertedName, "q", "Q", "g" )
   let convertedName = substitute( convertedName, "r", "R", "g" )
   let convertedName = substitute( convertedName, "s", "S", "g" )
   let convertedName = substitute( convertedName, "t", "T", "g" )
   let convertedName = substitute( convertedName, "[uùûü]", "U", "g" )
   let convertedName = substitute( convertedName, "v", "V", "g" )
   let convertedName = substitute( convertedName, "w", "W", "g" )
   let convertedName = substitute( convertedName, "x", "X", "g" )
   let convertedName = substitute( convertedName, "y", "Y", "g" )
   let convertedName = substitute( convertedName, "z", "Z", "g" )

   return substitute( convertedName, "\\.", "_", "g" )
endfunction

endif

if ( exists( "*VM_ProjectBuildAllFolders" ) == 0 )

" Fonction : VM_ProjectBuildAllFolders
"
" But : Build the folders to the specified point.
"
" Parametres :
"     folderToCreate - The folder to create
"-------------------------------------------------------------------------------
function VM_ProjectBuildAllFolders( folderToCreate )
   call mkdir( a:folderToCreate, "p" )
endfunction

endif

if ( exists( "*VM_ProjectTestFileExists" ) == 0 )

" Fonction : VM_ProjectTestFileExists
"
" But : Test if the file already exists
"
" Buffer : 
"
" Parametres :
"     filename - The filename to create
"     repository - The sub-folder in the project where the file had to be generated
"     projectFolder - The inside project folder
" Retour :
"     0 if the file does not exists, another value otherwise
"-------------------------------------------------------------------------------
function VM_ProjectTestFileExists( filename, repository, projectFolder )
   " Transform the current repository name into the standard / separator
   "--------------------------------------------------------------------
   let projectFolder = substitute( a:projectFolder, g:VM_projectDirSeparator, "/", "g" )
   let repository = substitute( a:repository, g:VM_projectDirSeparator, "/", "g" )

   " Compute the folder name used for the file creation
   "---------------------------------------------------
   let folderUsed = repository

   if ( projectFolder != "" )
      if ( repository != "" )
         let folderUsed = projectFolder . "/" . repository
      else
         let folderUsed = projectFolder
      endif
   endif

   return filereadable( folderUsed . "/" . a:filename )
endfunction

endif

if ( exists( "*VN_ProjectTestFile" ) == 0 )

" Fonction : VN_ProjectTestFile
"
" But : Test if the specified file already exists
"
" Parametres :
"     filename - The filename to create
"     repository - The sub-folder in the project where the file had to be generated
"     projectFolder - The inside project folder
" Retour :
"     0 if the file does not exist, another value otherwise
"-------------------------------------------------------------------------------
function VN_ProjectTestFile( filename, repository, projectFolder )
   " Transform the current repository name into the standard / separator
   "--------------------------------------------------------------------
   let projectFolder = substitute( a:projectFolder, g:VM_projectDirSeparator, "/", "g" )
   let repository = substitute( a:repository, g:VM_projectDirSeparator, "/", "g" )

   " Compute the folder name used for the file creation
   "---------------------------------------------------
   let folderUsed = repository

   if ( projectFolder != "" )
      if ( repository != "" )
         let folderUsed = projectFolder . "/" . repository
      else
         let folderUsed = projectFolder
      endif
   endif

   return filereadable( folderUsed . "/" . a:filename )
endfunction

endif

if ( exists( "*VM_ProjectBuildFile" ) == 0 )

" Fonction : VM_ProjectBuildFile
"
" But : Build a file from the specified questions.
"
" Parametres :
"     command - The command used to open the file
"     elementName - The element to create
"     modelName - The model name to use
"     comment - The comment of the creation
"     filename - The filename to create
"     repository - The sub-folder in the project where the file had to be generated
"     projectFolder - The inside project folder
"-------------------------------------------------------------------------------
function VM_ProjectBuildFile( command, elementName, modelName, comment, filename, repository, projectFolder )
   " Transform the current repository name into the standard / separator
   "--------------------------------------------------------------------
   let projectFolder = substitute( a:projectFolder, g:VM_projectDirSeparator, "/", "g" )
   let repository = substitute( a:repository, g:VM_projectDirSeparator, "/", "g" )

   " Compute the folder name used for the file creation
   "---------------------------------------------------
   let folderUsed = repository

   if ( projectFolder != "" )
      if ( repository != "" )
         let folderUsed = projectFolder . "/" . repository
      else
         let folderUsed = projectFolder
      endif
   endif

   if ( filereadable( folderUsed . "/" . a:filename ) == 0 )
      " Creation du répertoire
      "-----------------------
      call VM_ProjectBuildAllFolders( folderUsed )

      " Creation du fichier
      "--------------------
      execute a:command . " " . folderUsed . "/" . a:filename

      " Récupération du template à utiliser
      "------------------------------------
      let templateFileName = VM_GetReferenceFile( a:modelName )

      if ( templateFileName != "" )
         " Nettoyage complet du fichier
         "-----------------------------
         % delete
         " Création du template du fichier
         "--------------------------------
         execute "read " . templateFileName
         " Elimine la première ligne du fichier créé
         "------------------------------------------
         1 delete
         " Calcule les valeur des variables qui seront utilisées pour le remplacement des templates
         "-----------------------------------------------------------------------------------------
         let elementAuthor = $USER_NAME
         let elementEmail = $ADDRESS_EMAIL
         let elementDate = strftime( "%d %b %Y" )
         let elementInclude = VM_ConvertToUpper( a:filename )
         let elementMacro = VM_ConvertToUpper( a:elementName )
         let projectMacro = VM_ConvertToUpper( projectFolder )

         " Boucle sur les valeurs additionnelles : played in first to have macro replaced after
         "-------------------------------------------------------------------------------------
         if ( ( exists( "g:VM_additionnalValues" ) != 0 ) && ( empty( g:VM_additionnalValues ) == 0 ) )
            for fromName in keys( g:VM_additionnalValues )
               execute "% substitute /\\[@" . fromName . "@\\]/" . substitute( g:VM_additionnalValues[ fromName ], "/", "\\\\/", "g" ) . "/ge"
            endfor
         endif

         " Remplace les templates par la valeur correspondante
         "----------------------------------------------------
         execute "% substitute /\\[@ELEMENT_FILE@\\]/" . substitute( a:filename, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_DESC@\\]/" . substitute( a:comment, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_AUTHOR@\\]/" . substitute( elementAuthor, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_EMAIL@\\]/" . substitute( elementEmail, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_DATE@\\]/" . substitute( elementDate, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_INCLUDE@\\]/" . substitute( elementInclude, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@PROJECT_MACRO@\\]/" . substitute( projectMacro, "/", "_", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_MACRO@\\]/" . substitute( elementMacro, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_NAME@\\]/" . substitute( a:elementName, "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_BLANK@\\]/" . substitute( a:elementName, ".", " ", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_REPOSITORY@\\]/" . substitute( repository . "/", "/", "\\\\/", "g" ) . "/ge"
         execute "% substitute /\\[@ELEMENT_PROJECT@\\]/" . substitute( repository, "/", ".", "g" ) . "/ge"
         % substitute /@++@//ge

         " Update the file format
         "-----------------------
         if ( exists( "g:VM_projectFileFormat" ) != 0 )
            execute "set fileformat=" . g:VM_projectFileFormat
         endif

         " Save the file created
         "----------------------
         1
         write!
      endif
   endif
endfunction

endif

if ( exists( "*VM_ProjectBuildFunction" ) == 0 )

" Fonction : VM_ProjectBuildFunction
"
" But : Build a function introduction.
"-------------------------------------------------------------------------------
function VM_ProjectBuildFunction()
   " Je calcule l'extention du fichier courant pour déterminer le nom du fichier
   " de construction des commentaires que je vais utiliser
   "----------------------------------------------------------------------------
   let fileExtend = expand( "%:e" )

   " Je teste l'existance du fichier de construction descommentaires
   "----------------------------------------------------------------
   let fileExecute = ""

   if ( exists( "g:VM_projectLocalDirComments" ) != 0 )
      let fileExecute = g:VM_projectLocalDirComments . "/" . fileExtend . ".vim"

      if ( filereadable( expand( fileExecute ) ) == 0 )
         let fileExecute = ""
      endif
   endif

   if ( fileExecute == "" )
      let fileExecute = g:VM_projectDirComments . "/" . fileExtend . ".vim"

      if ( filereadable( expand( fileExecute ) ) == 0 )
         let fileExecute = ""
      endif
   endif

   if ( fileExecute == "" )
      let fileExtend = &filetype

      if ( exists( "g:VM_projectLocalDirComments" ) != 0 )
         let fileExecute = g:VM_projectLocalDirComments . "/" . fileExtend . ".vim"

         if ( filereadable( expand( fileExecute ) ) == 0 )
            let fileExecute = ""
         endif
      endif

      if ( fileExecute == "" )
         let fileExecute = g:VM_projectDirComments . "/" . fileExtend . ".vim"

         if ( filereadable( expand( fileExecute ) ) == 0 )
            let fileExecute = ""
         endif
      endif
   endif

   if ( fileExecute != "" )

      " Il ne me reste qu'à utiliser le fichier de création de commentaires
      "--------------------------------------------------------------------
      execute "source " . fileExecute
   else
      " Pas de fichier de création des commentaires
      "--------------------------------------------
      echo "Pas de fichier de création des commentaires\n"
   endif
endfunction

endif

if ( exists( "*VM_ProjectBuildAlternateFunction" ) == 0 )

" Fonction : VM_ProjectBuildAlternateFunction
"
" But : Build a function introduction.
"-------------------------------------------------------------------------------
function VM_ProjectBuildAlternateFunction()
   " Je calcule l'extention du fichier courant pour déterminer le nom du fichier
   " de construction des commentaires que je vais utiliser
   "----------------------------------------------------------------------------
   let fileExtend = expand( "%:e" )

   " Je teste l'existance du fichier de construction descommentaires
   "----------------------------------------------------------------
   let fileExecute = g:VM_projectDirAlternate . "/" . fileExtend . ".vim"

   if ( filereadable( expand( fileExecute ) ) != 0 )

      " Il ne me reste qu'à utiliser le fichier de création de commentaires
      "--------------------------------------------------------------------
      execute "source " . fileExecute
   else
      " Pas de fichier de création des commentaires
      "--------------------------------------------
      echo "Pas de fichier de copy de la fonction dans le fichier alternatif ( " . fileExecute . " )"
   endif
endfunction

endif

if ( exists( "*VM_PrintLimitedLengthLine" ) == 0 )

" Fonction : VM_PrintLimitedLengthLine
"
" But : Affiche un texte sur une ou plusieurs lignes en fonction de sa longueur
"       et de la longueur d'affichage maximale.
"
" Buffer : Buffer dans lequel doit être afficher la ligne
"
" Parametres :
"     beginFirst - Début de la première ligne
"     beginOther - Début des autres lignes
"     numLine - Numéro de la ligne à partir de laquelle on doit écrire
"     stringToPrint - chaine de caractères à afficher.
"     lengthLimit - Taille maximale d'affichage
"
" Retour :
"     Numéro de la prochaine ligne sur laquelle afficher ce qui va en dessous
"     de l'affichage réalisé.
"-------------------------------------------------------------------------------
function VM_PrintLimitedLengthLine( beginFirst, beginOther, numLine, stringToPrint, lengthLimit )

   " Je prépare ma variable de retour
   "---------------------------------
   let numLineRet = a:numLine
   " Je découpe mon  libelle en mroceaux de largeurComment caractères de long
   "-------------------------------------------------------------------------
   let restToPrint = a:stringToPrint
   " J'initialise le début de ligne que je dois afficher
   "----------------------------------------------------
   let debutLigne = a:beginFirst

   while ( restToPrint > "" )
      " Je cherche à savoir si je peux afficher tous les caractères
      "------------------------------------------------------------
      if ( strlen( restToPrint ) <= a:lengthLimit )
         " Je peux afficher toute ma chaine de caractères, je termine tout ici
         "--------------------------------------------------------------------
         call append( numLineRet, debutLigne . restToPrint )
         let restToPrint = ""
         " Je me prépare à afficher le reste du répertoire
         "------------------------------------------------
         let numLineRet = numLineRet + 1
      else
         " Je recherche l'endroit où couper la chaine de caractère
         "--------------------------------------------------------
         let posCourante = a:lengthLimit
         let currentChar = strpart( restToPrint, posCourante, 1 )
         while ( ( posCourante > 0 )&&( currentChar != " " ) )
            " Lecture du caractère précédant
            "-------------------------------
            let posCourante = posCourante - 1
            let currentChar = strpart( restToPrint, posCourante, 1 )
         endwhile
         " Je vérifie que G bel et bien trouvé un caractère de séparation
         "---------------------------------------------------------------
         if ( posCourante == 0 )
            " Pas de caracètre de séparation, je coupe au largeurComment nième caractère
            "---------------------------------------------------------------------------
            let posCourante = a:lengthLimit
         endif
         " Je calcule la ligne à afficher
         "-------------------------------
         let linePrinted = strpart( restToPrint, 0, posCourante )
         " J'ajoute ma ligne de libellé
         "-----------------------------
         call append( numLineRet, debutLigne . linePrinted )
         let numLineRet = numLineRet + 1
         " Je détermine ce qu'il reste à afficher
         "---------------------------------------
         let currentChar = strpart( restToPrint, posCourante, 1 )
         while ( ( posCourante < strlen( restToPrint ) )&&( currentChar == " " ) )
            " Passe à la lecture du caractère suivant
            "----------------------------------------
            let posCourante = posCourante + 1
            let currentChar = strpart( restToPrint, posCourante, 1 )
         endwhile
         " Je coupe la ligne au niveau de la suite à afficher
         "---------------------------------------------------
         if ( posCourante < strlen( restToPrint ) )
            " Il me reste tout un morceau de libellé à afficher
            "--------------------------------------------------
            let restToPrint = strpart( restToPrint, posCourante, strlen( restToPrint ) )
         else
            " Plus rien à afficher
            "---------------------
            let restToPrint = ""
         endif
      endif
      " Je modifie le début de la ligne à afficher
      "-------------------------------------------
      let debutLigne = a:beginOther
   endwhile
   " Retourne le numéro de la prochaine ligne à afficher
   "----------------------------------------------------
   return numLineRet

endfunction

endif

if ( exists( "*VM_Completion" ) == 0 )

" Fonction : VM_Completion
"
" But : Get the completion of the current word.
"
" Parametres :
"     word - The word to complete
"-------------------------------------------------------------------------------
function VM_Completion( word )
   " Compute the file name that correspond to the completion to do
   "--------------------------------------------------------------
   let baseFileName = g:VM_projectCompletionFile . "/" . toupper( &filetype ) . "/"
   let localBaseFileName = ""
   let singleName = strpart( getline( "." ), col( "." ) - 1, 1 )

   if ( exists( "g:VM_projectLocalCompletionFile" ) != 0 )
      let localBaseFileName = g:VM_projectLocalCompletionFile . "/" . toupper( &filetype ) . "/"
   endif

   if ( filereadable( expand( localBaseFileName . a:word . ".vim" ) ) != 0 )
      execute "source " . localBaseFileName . a:word . ".vim"
   elseif ( filereadable( expand( baseFileName . a:word . ".vim" ) ) != 0 )
      execute "source " . baseFileName . a:word . ".vim"
   elseif ( filereadable( expand( localBaseFileName . singleName . ".vim" ) ) != 0 )
      execute "source " . localBaseFileName . singleName . ".vim"
   elseif ( filereadable( expand( baseFileName . singleName . ".vim" ) ) != 0 )
      execute "source " . baseFileName . singleName . ".vim"
   elseif ( filereadable( expand( localBaseFileName . "default.vim" ) ) != 0 )
      execute "source " . localBaseFileName . "default.vim"
   elseif ( filereadable( expand( baseFileName . "default.vim" ) ) != 0 )
      execute "source " . baseFileName . "default.vim"
   endif
endfunction

endif

if ( exists( "*VM_ExecuteList" ) == 0 )

" Fonction : VM_ExecuteList
"
" But : Execute all the elements of the specified list.
"
" Parametres :
"    commandList - The list of the commands to execute
"-------------------------------------------------------------------------------
function VM_ExecuteList( commandList )
   for currentCommand in a:commandList
      execute currentCommand
   endfor
endfunction

endif

if ( exists( "*VM_BuildPath" ) == 0 )

" Fonction : VM_BuildPath
"
" But : Build the path definition.
"
"-------------------------------------------------------------------------------
function VM_BuildPath()
   call VM_ExecuteList( g:VM_listCmdPathBuild )

   execute "set path=" . g:VM_beforePath . g:VM_globalPath . g:VM_finalPath
endfunction

endif

if ( exists( "*VM_EliminateDuplicatedLine" ) == 0 )

" Fonction : VM_EliminateDuplicatedLine
"
" But : Eliminate the lines that are the same than the previous one.
"
" Buffer : Current
"-------------------------------------------------------------------------------
function VM_EliminateDuplicatedLine()
   let numLine = 1

   while ( numLine < line( "$" ) )
      let currentLine = getline( numLine )
      let numLine = numLine + 1

      while ( getline( numLine ) == currentLine )
         execute numLine . " delete"
      endwhile
   endwhile
endfunction

endif

if ( exists( "*VM_ExtractFolders" ) == 0 )

" Fonction : VM_ExtractFolders
"
" But : Extract the folders from a system command.
"
" Parametres :
"    commandList - The command to execute toget the directory list
" Retour :
"    The list of the folders available
"-------------------------------------------------------------------------------
function VM_ExtractFolders( commandList )
   let retList = []

   for currentLine in split( system( a:commandList ), "\n" )
      if ( currentLine == substitute( currentLine, "^ls: ", "", "" ) )
         call add( retList, substitute( substitute( currentLine, g:VM_extractProjectNameBegin, "", "" ), g:VM_extractProjectNameEnd, "", "" ) )
      endif
   endfor

   return retList
endfunction

endif

if ( exists( "*VM_GetFolders" ) == 0 )

" Fonction : VM_GetFolders
"
" But : Get the list of the folders
"
" Parametres :
"    folderBase - The folder from switch the list had to be extracted
" Retour :
"    The list of the folders available
"-------------------------------------------------------------------------------
function VM_GetFolders( folderBase )
   let commandList = g:VM_projectListDirStart . a:folderBase . g:VM_projectListDirEnd

   return VM_ExtractFolders( commandList )
endfunction

endif

if ( exists( "*VM_GetFiles" ) == 0 )

" Fonction : VM_GetFiles
"
" But : Get the list of the files
"
" Parametres :
"    folderBase - The folder from switch the list had to be extracted
" Retour :
"    The list of the files available
"-------------------------------------------------------------------------------
function VM_GetFiles( folderBase )
   let commandList = g:VM_projectListDirStart . a:folderBase . g:VM_projectListFileEnd

   return VM_ExtractFolders( commandList )
endfunction

endif

if ( exists( "*VM_GetDistantFolders" ) == 0 )

" Fonction : VM_GetDistantFolders
"
" But : Get the list of the distant folders
"
" Parametres :
"    folderBase - The folder from switch the list had to be extracted
" Retour :
"    The list of the folders available
"-------------------------------------------------------------------------------
function VM_GetDistantFolders( folderBase )
   let commandList = g:VM_distantListDirStart . a:folderBase . g:VM_distantListDirEnd

   return VM_ExtractFolders( commandList )
endfunction

endif

if ( exists( "*VM_GetBuffers" ) == 0 )

" Fonction : VM_GetBuffers
"
" But : Get the current buffer list.
"
" Retour :
"    The list of the current buffer
"-------------------------------------------------------------------------------
function VM_GetBuffers()
   " let saved_lang = v:lang
   " language C
   redir => lstBuff
   silent buffers
   redir END
   " execute 'language' saved_lang

   let buffersList = []
   let maxfilelength = 0
   for entry in split( lstBuff, '\n' )
      let buffer = {}
      let buffer.status = substitute( entry, '\s*[0-9]\+\s\+\(.\{-}\)\s\+".*', '\1', '' )
      let buffer.path = substitute( entry, '.\{-}"\(.\{-}\)".*', '\1', '' )
      let buffer.path = fnamemodify( buffer.path, ':p' )
      let buffer.file = fnamemodify( buffer.path, ':p:t' )
      let buffer.class = fnamemodify( buffer.path, ':p:t:r' )
      let buffer.ext = fnamemodify( buffer.path, ':e' )
      let buffer.dir = fnamemodify( buffer.path, ':p:h' )
      let buffer.bufnr = str2nr( substitute( entry, '\s*\([0-9]\+\).*', '\1', '' ) )
      let buffer.lnum = str2nr( substitute( entry, '.*"\s\+line\s\+\([0-9]\+\).*', '\1', '' ) )

      call add( buffersList, buffer )
   endfor

   return buffersList
endfunction

endif

if ( exists( "*VM_GetTabs" ) == 0 )

" Fonction : VM_GetTabs
"
" But : Get the complete list of tabs with the files
"
" Retour :
"    The complete tabs list
"-------------------------------------------------------------------------------
function VM_GetTabs()
   " let saved_lang = v:lang
   " language C
   redir => lstTabs
   silent tabs
   redir END
   " execute 'language' saved_lang

   let tabsList = []
   let filesList = {}
   let completeFileList = []
   let currentFileList = completeFileList

   for entry in split( lstTabs, '\n' )
      let tabNumber = substitute( entry, "^" . g:VM_tabIntro . " ", "", "" )

      if ( tabNumber == entry )
         let currentFileName = substitute( substitute( entry, "^\\(>\\|\\)[ 	]\\+", "", "" ), g:VIM_REP_SEPARATOR, "/", "g" )

         if ( exists( "filesList[ \"" . currentFileName . "\" ]" ) == 0 )
            let filename = substitute( currentFileName, "\.*/", "", "" )
            let extention = substitute( currentFileName, "\.*\\.", "", "" )

            if ( extention == "" )
               if ( substitute( filename, "\\[[^\\[\\]]*\\]", "", "" ) == "" )
                  let extention = "---"
               endif
            else
               let filename = strpart( filename, 0, len( filename ) - ( len( extention ) + 1 ) )
            endif

            let currentFile = {}

            let currentFile.tabList = []
            let currentFile.completeFilename = currentFileName
            let currentFile.filename = filename
            let currentFile.extention = extention

            call add( completeFileList, currentFile )
            let filesList[ currentFileName ] = currentFile
         else
            let currentFile = filesList[ currentFileName ]
         endif

         call add( currentFile.tabList, currentTabNumber )
         call add( currentFileList, currentFile )
      else
         call add( tabsList, currentFileList )

         let currentTabNumber = tabNumber
         let currentFileList = []
         let currentFileNumber = 1
      endif
   endfor

   call add( tabsList, currentFileList )
   call sort( completeFileList, 'VM_CompareBufferFiles' )

   return tabsList
endfunction

endif

if ( exists( "*VM_CompareBuffer" ) == 0 )

" Fonction : VM_CompareBuffer
"
" But : Sort the buffer list depending on the criteria used to sort
"
" Parametres :
"    element1 - The first element to be compared
"    element2 - The second element to be compared
" Retour :
"    < 0 if the first element is lower than the second
"    = 0 if the elements are equals
"    > 0 if the first element is greater than the second
"-------------------------------------------------------------------------------
function VM_CompareBuffer( element1, element2 )
   let retValue = 0

   if ( a:element1.status =~ "a" )
      if ( a:element2.status =~ "a" )
         let retValue = 0
      else
         let retValue = -1
      endif
   elseif ( a:element2.status =~ "a" )
      let retValue = 1
   endif

   if ( retValue == 0 )
      execute "let attribute1 = a:element1." . g:VM_bufferSortAttribute
      execute "let attribute2 = a:element2." . g:VM_bufferSortAttribute

      if ( attribute1 < attribute2 )
         let retValue = -1
      elseif ( attribute1 > attribute2 )
         let retValue = 1
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_CompareBufferFiles" ) == 0 )

" Fonction : VM_CompareBufferFiles
"
" But : Sort the tabs buffers definitions
"
" Parametres :
"    element1 - The first element to be compared
"    element2 - The second element to be compared
" Retour :
"    < 0 if the first element is lower than the second
"    = 0 if the elements are equals
"    > 0 if the first element is greater than the second
"-------------------------------------------------------------------------------
function VM_CompareBufferFiles( element1, element2 )
   let retValue = 0
   let filename1 = a:element1.filename
   let filename2 = a:element2.filename

   if ( filename1 < filename2 )
      let retValue = -1
   elseif ( filename1 > filename2 )
      let retValue = 1
   else
      let extention1 = a:element1.extention
      let extention2 = a:element2.extention

      if ( extention1 < extention2 )
         let retValue = -1
      elseif ( extention1 > extention2 )
         let retValue = 1
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_IsBufferKept" ) == 0 )

" Fonction : VM_IsBufferKept
"
" But : Test if the current buffer had to be kept or not
"
" Parametres :
"     currentBuffer - The current buffer definition to be kept or not ...
" Retour :
"     0 to not keep the buffer, another value otherwise
"-------------------------------------------------------------------------------
function VM_IsBufferKept( currentBuffer )
   let retValue = 0

   execute "let attributeTestKeep = \"^\" . a:currentBuffer." . g:VM_bufferKeepAttribute . " . \"$\""
   let attributeTestReject = ""

   if ( g:VM_bufferRejectAttribute > "" )
      execute "let attributeTestReject = \"^\" . a:currentBuffer." . g:VM_bufferRejectAttribute . " . \"$\""
   endif

   if ( ( empty( g:VM_bufferListKeep ) != 0 || index( g:VM_bufferListKeep, atttributeTestKeep, 0, 1 ) >= 0 ) && ( empty( g:VM_bufferListReject ) == 0 || index( g:VM_bufferListReject, attributeTestReject, 0, 1 ) < 0 ) )
      let retValue = 1
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_HandleBigFile" ) == 0 )

" Fonction : VM_HandleBigFile
"
" But : Handle big file to avoid slowlyness.
"-------------------------------------------------------------------------------
function VM_HandleBigFile()
   if ( exists( "b:VM_handleBigFile" ) == 0 )
      let b:VM_bufHidden = &l:bufhidden
      let b:VM_backup = &l:backup
      let b:VM_writeBackup = &l:writebackup
      let b:VM_complete = &complete
      let b:VM_eventIgnore = &eventignore
      let b:VM_foldMethod = &l:foldmethod
      let b:VM_foldEnable = &l:foldenable
      let b:VM_swapFile = &l:swapfile

      if ( ( v:version > 704 )||( ( v:version == 704 )&&( has( "patch073" ) != 0 ) ) )
         let b:VM_undoLevels = &l:undolevels
      else
         let b:VM_undoLevels = &undolevels
      endif

      setlocal noautoread noswapfile bufhidden=unload foldmethod=manual nofoldenable complete-=wbuU nobackup nowritebackup undolevels=-1

      let b:VM_handleBigFile = 1
   endif
endfunction

endif

if ( exists( "*VM_UnhandleBigFile" ) == 0 )

" Fonction : VM_UnhandleBigFile
"
" But : Unhandle big file, restore everything
"-------------------------------------------------------------------------------
function VM_UnhandleBigFile()
   if ( exists( "b:VM_handleBigFile" ) == 0 )
      let &l:bufhidden = b:VM_bufHidden
      let &l:backup = b:VM_backup
      let &l:writebackup = b:VM_writeBackup
      let &complete = b:VM_complete
      let &eventignore = b:VM_eventIgnore
      let &l:foldmethod = b:VM_foldMethod
      let &l:foldenable = b:VM_foldEnable
      let &l:swapfile = b:VM_swapFile

      if ( ( v:version > 704 )||( ( v:version == 704 )&&( has( "patch073" ) != 0 ) ) )
         let &l:undolevels = b:VM_undoLevels
      else
         let &undolevels = b:VM_undoLevels
      endif

      unlet b:VM_bufHidden
      unlet b:VM_backup
      unlet b:VM_writeBackup
      unlet b:VM_complete
      unlet b:VM_eventIgnore
      unlet b:VM_foldMethod
      unlet b:VM_foldEnable
      unlet b:VM_swapFile
      unlet b:VM_undoLevels

      unlet b:VM_handleBigFile
   endif
endfunction

endif

if ( exists( "*VM_DetermineFileSize" ) == 0 )

" Fonction : VM_DetermineFileSize
"
" But : Determine if the file size to read is a big file, or not.
"
" Parametres :
"    filename - The complete filename to read
"-------------------------------------------------------------------------------
function VM_DetermineFileSize( filename )
   if ( ( g:VM_largeFileLimit > 0 )&&( getfsize( a:filename ) > g:VM_largeFileLimit ) )
      call VM_HandleBigFile()
   endif
endfunction

endif

if ( exists( "*VM_DeterminePostFileSize" ) == 0 )

" Fonction : VM_DeterminePostFileSize
"
" But : Determine if the current that had been read is finally a big file.
"-------------------------------------------------------------------------------
function VM_DeterminePostFileSize()
   if ( ( g:VM_largeFileLimit > 0 )&&( exists( "b:VM_handleBigFile" ) == 0 )&&( line2byte( line("$") + 1 ) > g:VM_largeFileLimit ) )
      call VM_HandleBigFile()
   endif

   execute "set syntax=" . &filetype
endfunction

endif

if ( exists( "*VM_TailFile" ) == 0 )

" Fonction : VM_TailFile
"
" But : Behave like the tail -f command on the specified file.
"-------------------------------------------------------------------------------
function VM_TailFile()
   if ( exists( "g:VM_specificUpdateTailTime" ) != 0 )
      let &updatetime = g:VM_specificUpdateTailTime
   endif

   autocmd CursorHold <buffer> checktime
   autocmd CursorMoved <buffer> call VM_NeedReload()
   autocmd FileChangedShell <buffer> call VM_FileUpdated()
endfunction

endif

if ( exists( "*VM_NeedReload" ) == 0 )

" Fonction : VM_NeedReload
"
" But : Reload the file when reaching the end.
"-------------------------------------------------------------------------------
function VM_NeedReload()
   if ( line( "." ) == line( "$" ) )
      checktime
   endif
endfunction

endif

if ( exists( "*VM_FileUpdated" ) == 0 )

" Fonction : VM_FileUpdated
"
" But : Check that the file had been updated
"-------------------------------------------------------------------------------
function VM_FileUpdated()
   if ( v:fcs_reason == "changed" )
      if ( exists( "b:VM_handleBigFile" ) == 0 )
         if ( &modified != 0 )
            echo "File modified ... cannot be reloaded !!!"
         else
            edit
         endif
      elseif ( exists( "g:VM_largeFileReloadAction" ) != 0 )
         execute g:VM_largeFileReloadAction
      endif
   endif
endfunction

endif

if ( exists( "*VM_EliminateDuplicate" ) == 0 )

" Fonction : VM_EliminateDuplicate
"
" But : Eliminate the duplicated lines in the buffer list.
"
" Parametres :
"    bufferList - The current buffer list definition
" Retour :
"    Cleaned buffer list
"-------------------------------------------------------------------------------
function VM_EliminateDuplicate( bufferList )
   let retValue = []
   let currentIndex = 0
   let lastIndex = len( a:bufferList )

   if ( currentIndex < lastIndex )
      let currentBuff = a:bufferList[ currentIndex ]
      let currentIndex += 1

      while ( currentIndex < lastIndex )
         let compareBuff = a:bufferList[ currentIndex ]

         if ( VM_CompareBuffer( currentBuff, compareBuff ) == 0 )
            if ( VM_IsBufferKept( currentBuff ) == 0 )
               let currentBuff = compareBuff
            elseif ( VM_IsBufferKept( compareBuff ) != 0 )
               call add( retValue, currentBuff )
               let currentBuff = compareBuff
            endif
         else
            call add( retValue, currentBuff )
            let currentBuff = compareBuff
         endif

         let currentIndex += 1
      endwhile

      call add( retValue, currentBuff )
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_DisplayText" ) == 0 )

" Fonction : VM_DisplayText
"
" But : Reset the display of the current window with the content.
"
" Parametres :
"    fileTypeName - The file type associated to the created window
"    linesDisplay - The list that contains the lines to display
"    fctDisplay - The function called to display each line
"-------------------------------------------------------------------------------
function VM_DisplayText( fileTypeName, linesDisplay, fctDisplay )
   set modifiable
   set noreadonly

   silent % delete _

   " Fill the window with the lines
   "-------------------------------
   for currentLine in a:linesDisplay
      execute "call " . a:fctDisplay . "( currentLine )"
   endfor

   silent 1 delete _
   execute "set filetype=" . a:fileTypeName

   silent call VM_ProjectEnterFile()
endfunction

endif

if ( exists( "*VM_DisplayInternalWindowNoDelete" ) == 0 )

" Fonction : VM_DisplayInternalWindowNoDelete
"
" But : Display an internal window, without deleting the already existing one
"
" Parametres :
"    windowName - The name associated to the created window
"    windowCommand - The command used to create the window ( ex : "botright 10 sview" )
"    fileTypeName - The file type associated to the created window
"    linesDisplay - The list that contains the lines to display
"    fctDisplay - The function called to display each line
"-------------------------------------------------------------------------------
function VM_DisplayInternalWindowNoDelete( windowName, windowCommand, fileTypeName, linesDisplay, fctDisplay )
   " Use the command to open the window
   "-----------------------------------
   execute a:windowCommand . " " . a:windowName

   if ( empty( a:linesDisplay ) == 0 )
      call VM_DisplayText( a:fileTypeName, a:linesDisplay, a:fctDisplay )
   endif
endfunction

endif

if ( exists( "*VM_ProjectDeleteAllBuffer" ) == 0 )

" Fonction : VM_ProjectDeleteAllBuffer
"
" But : Delete all the opened buffers.
"
" Parametres :
"     bufferName - The buffer name to be closed
"-------------------------------------------------------------------------------
function VM_ProjectDeleteAllBuffer( bufferName )
   let bufferNumber = bufnr( a:bufferName )

   if ( ( bufferNumber >= 0 )&&( bufname( bufferNumber ) == a:bufferName ) )
      execute "silent! bdelete! " . bufferNumber
   endif
endfunction

endif

if ( exists( "*VM_DisplayInternalWindow" ) == 0 )

" Fonction : VM_DisplayInternalWindow
"
" But : Display an internal window, deleting the existing one
"
" Parametres :
"    windowName - The name associated to the created window
"    windowCommand - The command used to create the window ( ex : "botright 10 sview" )
"    fileTypeName - The file type associated to the created window
"    linesDisplay - The list that contains the lines to display
"    fctDisplay - The function called to display each line
"-------------------------------------------------------------------------------
function VM_DisplayInternalWindow( windowName, windowCommand, fileTypeName, linesDisplay, fctDisplay )
   " Close the window if it already exists
   "--------------------------------------
   call VM_ProjectDeleteAllBuffer( a:windowName )

   " Use the command to open the window
   "-----------------------------------
   call VM_DisplayInternalWindowNoDelete( a:windowName, a:windowCommand, a:fileTypeName, a:linesDisplay, a:fctDisplay )
endfunction

endif

if ( exists( "*VM_GetProjectBaseFolder" ) == 0 )

" Fonction : VM_GetProjectBaseFolder
"
" But : Get the project base folder.
"
" Retour :
"    The base folder for the projects
"-------------------------------------------------------------------------------
function VM_GetProjectBaseFolder()
   let retValue = g:VM_projectBaseProjects

   if ( exists( "g:VM_projectVIMBaseProjects" ) != 0 )
      let retValue = g:VM_projectVIMBaseProjects
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_GetProjectType" ) == 0 )

" Fonction : VM_GetProjectType
"
" But : Get the project type specificity.
"
" Parametres :
"    init - 0 to get an existing project, another value to create a new project
"    projectName - The project name to use
"    currentBaseProject - The base folder of the project
"-------------------------------------------------------------------------------
function VM_GetProjectType( init, projectName, currentBaseProject )
   " Get the specific project definition
   "------------------------------------
   let projectType = input( "Project type ( CPPGit ) : " )
   echo "\n"

   let computedFileName = ""
   let introFileName = "init"

   if ( a:init == 0 )
      let introFileName = "get"
   endif

   if ( exists( "g:VM_projectLocalDirInit" ) != 0 )
      let computedFileName = g:VM_projectLocalDirInit . "/" . introFileName . projectType . ".vim"

      if ( filereadable( expand( computedFileName ) ) == 0 )
         let computedFileName = ""
      endif
   endif

   if ( computedFileName == "" )
      let computedFileName = g:VM_projectDirInit . "/" . introFileName . projectType . ".vim"

      if ( filereadable( expand( computedFileName ) ) == 0 )
         let computedFileName = ""
      endif
   endif

   if ( computedFileName == "" )
      echo "Unknown project type.\n"
   else
      let g:projectName = a:projectName
      execute "source " . computedFileName
      unlet g:projectName

      if ( a:init != 0 )
         call VM_ProjectBuildFile( "vsplit", a:projectName, "todo", "The todo list for the project.", "todo.txt", a:projectName, a:currentBaseProject )
      else
         execute "cd " . a:currentBaseProject . "/" . a:projectName
         edit todo.txt
      endif

      tabonly
      only

      call VM_ProjectInitialize()

      echo "You have to add the project in the globalBuild.sh file ...\n"
   endif
endfunction

endif

if ( exists( "*VM_NewProject" ) == 0 )

" Fonction : VM_NewProject
"
" But : Create a new project
"-------------------------------------------------------------------------------
function VM_NewProject()
   let currentBaseProject = VM_GetProjectBaseFolder()
   let listExisting = VM_GetFolders( currentBaseProject )
   echo "Existing projects :\n"

   for currentProject in listExisting
      echo "+ - " . currentProject . "\n"
   endfor

   let s:projectName = input( "New project name : " )
   echo "\n"

   if ( s:projectName == "" )
      echo "Project creation cancelled ( empty name )\n"
   elseif ( isdirectory( currentBaseProject . "/" . s:projectName ) != 0 )
      echo "A directory of the specified name already exists.\n"
   else
      " Create the project definition
      "------------------------------
      call VM_ExecuteList( g:VM_projectGlobalCreation )

      " Move to the project folder
      "---------------------------
      execute "cd " . currentBaseProject . "/" . s:projectName

      " Get the specific project definition
      "------------------------------------
      call VM_GetProjectType( 1, s:projectName, currentBaseProject )
   endif
endfunction

endif

if ( exists( "*VM_GetProject" ) == 0 )

" Fonction : VM_GetProject
"
" But : Get a project from the existant repository.
"-------------------------------------------------------------------------------
function VM_GetProject()
   let indexDefined = 0
   let nbAvailable = 0
   let listExisting = VM_GetDistantFolders( g:VM_distantFolderBase )
   let listDefined = VM_GetFolders( VM_GetProjectBaseFolder() )
   let sizeDefined = len( listDefined )

   echo "Projects :\n"

   for currentProject in listExisting
      let alreadyDefined = 0

      if ( indexDefined < sizeDefined )
         while ( ( indexDefined < sizeDefined )&&( currentProject > listDefined[ indexDefined ] ) )
            let indexDefined += 1
         endwhile

         let alreadyDefined = ( ( indexDefined < sizeDefined )&&( currentProject == listDefined[ indexDefined ] ) )
      endif

      if ( alreadyDefined == 0 )
         let nbAvailable += 1
         echo "+ - " . currentProject . "\n"
      endif
   endfor

   if ( nbAvailable > 0 )
      let projectName = input( "Existing project name : " )
      echo "\n"

      if ( projectName == "" )
         echo "Project read cancelled ( empty name )\n"
      else
         " Get the specific project definition
         "------------------------------------
         let currentBaseProject = VM_GetProjectBaseFolder()
         call VM_GetProjectType( 0, projectName, currentBaseProject )
      endif
   else
      echo "All projects had already been gotten\n"
   endif
endfunction

endif

if ( exists( "*VM_DisplayBuffer" ) == 0 )

" Fonction : VM_DisplayBuffer
"
" But : Transform the buffer object a in display line.
"
" Parametres :
"    currentBuffer - The current buffer definition to display
"-------------------------------------------------------------------------------
function VM_DisplayBuffer( currentBuffer )
   if ( a:currentBuffer.status =~ "+" )
      let line = "updated "
   else
      let line = "        "
   endif

   if ( a:currentBuffer.status =~ "a" )
      let line .= "active "
   else
      let line .= "hidden "
   endif

   if ( a:currentBuffer.status =~ "[-=]" )
      let line .= "[RO] "
   else
      let line .= "     "
   endif

   execute "let attribute = a:currentBuffer." . g:VM_bufferSortAttribute
   let pad = g:VM_projectSizeBufferName - strlen( attribute )

   if ( pad > 0 )
      while ( pad > 0 )

         let attribute .= "                                                                                                                                "
         let pad -= 128
      endwhile
   endif

   let attribute = strpart( attribute, 0, g:VM_projectSizeBufferName )

   let line .= attribute . " "

   let line .= a:currentBuffer.dir

   call append( line( "$" ), line )
endfunction

endif

if ( exists( "*VM_DisplayBuffersTab" ) == 0 )

" Fonction : VM_DisplayBuffersTab
"
" But : Display the buffers in the specified tab.
"
" Parametres :
"    entry - Current entry to display
"-------------------------------------------------------------------------------
function VM_DisplayBuffersTab( entry )
   let lineDisplaid = a:entry.filename
   let pad = g:VM_projectSizeBufferName - strlen( lineDisplaid )

   if ( pad > 0 )
      while ( pad > 0 )

         let lineDisplaid .= "                                                                                                                                "
         let pad -= 128
      endwhile
   endif

   let lineDisplaid = strpart( lineDisplaid, 0, g:VM_projectSizeBufferName )
   let lineDisplaid .= " " . strpart( a:entry.extention . "        ", 0, 8 )
   let lineDisplaid .= " ((" . a:entry.completeFilename . "))"

   call append( line( "$" ), lineDisplaid )
endfunction

endif

if ( exists( "*VM_DisplayCorrespondingBufferTabs" ) == 0 )

" Fonction : VM_DisplayCorrespondingBufferTabs
"
" But : Display the buffers available in the specified tab
"-------------------------------------------------------------------------------
function VM_DisplayCorrespondingBufferTabs()
   let currentBufferNum = line( "." ) - 1

   wincmd l
   let b:usedTab = currentBufferNum

   call VM_DisplayText( "VM_tab_buffers_internal", b:tabsBufferListAvailable[ b:usedTab ], "VM_DisplayBuffersTab" )
endfunction

endif

if ( exists( "*VM_DisplayTabs" ) == 0 )

" Fonction : VM_DisplayTabs
"
" But : Display the existing tabs.
"
" Parametres :
"    tabsList - The tab list content
"-------------------------------------------------------------------------------
function VM_DisplayTabs( entry )
   if ( b:currentTabNumber == 0 )
      let tabName = "ALL tabs"
   else
      let tabName = "Tab N°" . b:currentTabNumber
   endif

   let tabName = strpart( tabName . "            ", 0, 12 ) . len( a:entry )

   call append( line( "$" ), tabName )

   let b:currentTabNumber += 1
endfunction

endif

if ( exists( "*VM_RemindsOriginalWindow" ) == 0 )

" Fonction : VM_RemindsOriginalWindow
"
" But : Remember where to go back when closing the tab.
"-------------------------------------------------------------------------------
function VM_RemindsOriginalWindow()
   let g:VM_returnTab = tabpagenr()
   let g:VM_returnWindow = winnr()
endfunction

endif

if ( exists( "*VM_BackToOriginalWindow" ) == 0 )

" Fonction : VM_BackToOriginalWindow
"
" But : Go back to the remembered window
"-------------------------------------------------------------------------------
function VM_BackToOriginalWindow()
   if ( exists( "g:VM_returnTab" ) != 0 )
      call VM_GotoTabFile( g:VM_returnTab, g:VM_returnWindow )
   endif
endfunction

endif

if ( exists( "*VM_CommandBuffer" ) == 0 )

" Fonction : VM_CommandBuffer
"
" But : Execute a spacific commmand buffer to get a nice display of the buffers
"-------------------------------------------------------------------------------
function VM_CommandBuffer()
   call VM_RemindsOriginalWindow()

   let buffList = VM_GetBuffers()
   let buffList = sort( buffList, 'VM_CompareBuffer' )
   let buffList = VM_EliminateDuplicate( buffList )

   call VM_DisplayInternalWindow( "[Buffers]", "botright 10 sview", "VM_buffers_internal", buffList, "VM_DisplayBuffer" )

   let b:bufferAvailable = buffList
endfunction

endif

if ( exists( "*VM_BufferOpen" ) == 0 )

" Fonction : VM_BufferOpen
"
" But : Open the buffer associated to the current line number.
"
" Parametres :
"    command - The command to use for opening the specified buffer
"-------------------------------------------------------------------------------
function VM_BufferOpen( command )
   let currentLine = line( "." )

   if ( currentLine <= len( b:bufferAvailable ) )
      let bufferNumber = b:bufferAvailable[ currentLine - 1 ].bufnr

      close

      call VM_BackToOriginalWindow()
      execute a:command . " " . bufferNumber
   endif
endfunction

endif

if ( exists( "*VM_CommandTabs" ) == 0 )

" Fonction : VM_CommandTabs
"
" But : Execute the command to display the tabs definition
"-------------------------------------------------------------------------------
function VM_CommandTabs()
   call VM_RemindsOriginalWindow()

   let tabsList = VM_GetTabs()

   call VM_DisplayInternalWindow( "[Tabs_Buffers]", "botright 6 sview", "VM_tab_buffers_internal", [], "" )

   let b:tabsBufferListAvailable = tabsList
   let b:usedTab = 0

   call VM_DisplayInternalWindow( "[Tabs]", "vert leftabove 30 sview", "VM_tabs_internal", [], "" )

   wincmd h
   let b:tabsListAvailable = tabsList
   let b:currentTabNumber = 0

   call VM_DisplayText( "VM_tabs_internal", tabsList, "VM_DisplayTabs" )
   1
   call VM_DisplayCorrespondingBufferTabs()
endfunction

endif

if ( exists( "*VM_ReadTagsFile" ) == 0 )

" Fonction : VM_ReadTagsFile
"
" But : Get data from the tag file and export it for display
"
" Buffer :
"    Had to be a modifiable, where the tag file had been loaded
" Parametres :
"    baseFolder - The base folder for the tag filename
"    tagDictionary - The current tag dictionary to update
" Retour :
"    g:tagUnhandledLanguages - The complete list of the unhandled languages
"-------------------------------------------------------------------------------
function VM_ReadTagsFile( baseFolder, tagDictionary )
   let currentLineNum = 1
   let lastLine = line( "$" )
   let g:tagResultLanguages = a:tagDictionary
   let g:tagBaseFolder = a:baseFolder
   let g:tagUnhandledLanguages = {}

   while ( currentLineNum <= lastLine )
      let currentLine = getline( currentLineNum )
      if ( strpart( currentLine, 1, 1 ) != "!" )
         let lineArray = split( currentLine, "\t" )
         let lineLength = len( lineArray )

         if ( lineLength > 4 )
            let g:tagName = lineArray[ 0 ]
            let completeFilename = split( substitute( lineArray[ 1 ], "\\", "/", "g" ), "/" )
            let currentTagPosition = ""

            let currentPosition = 2

            while ( ( currentPosition < lineLength ) && ( substitute( lineArray[ currentPosition ], ";\"$", "", "" ) == lineArray[ currentPosition ] ) )
               let currentTagPosition .= lineArray[ currentPosition ] . "\t"
               let currentPosition += 1
            endwhile

            let g:tagPosition = currentTagPosition . substitute( lineArray[ currentPosition ], ";\"$", "", "" )
            let currentPosition += 1
            let g:tagType = lineArray[ currentPosition ]
            let currentPosition += 1
            let g:tagLanguage = substitute( lineArray[ currentPosition ], "^language:", "", "" )

            if ( g:tagLanguage != lineArray[ currentPosition ] )
               let currentPosition += 1
               execute "let g:tagRemainingList = lineArray[ " . currentPosition . ": ]"

               " Extract file name and folder
               "-----------------------------
               let completeLength = len( completeFilename ) - 1
               let g:tagFilename = completeFilename[ completeLength ]
               let g:tagClassName = substitute( g:tagFilename, "\\.[^\\.]*$", "", "" )
               let g:tagFileExtention = substitute( g:tagFilename, "\.*\\.", "", "" )

               let pathPosition = 0
               let relativePath = []

               while ( pathPosition < completeLength )
                  let currentPathValue = completeFilename[ pathPosition ]

                  if ( currentPathValue == ".." )
                     if ( ( len( relativePath ) == 0 )||( relativePath[ -1 ] == currentPathValue ) )
                        call add( relativePath, currentPathValue )
                     else
                        let relativePath = relativePath[ :-2 ]
                     endif
                  elseif ( currentPathValue != "." )
                     call add( relativePath, currentPathValue )
                  endif

                  let pathPosition += 1
               endwhile

               let g:tagRelativePath = join( relativePath, "/" )
               let fileExecute = g:VM_projectDirTagsLanguage . "/" . g:tagLanguage . ".vim"

               if ( exists( "g:VM_projectLocalDirTagsLanguage" ) != 0 )
                  let fileLocalExecute = g:VM_projectLocalDirTagsLanguage . "/" . g:tagLanguage . ".vim"

                  if ( filereadable( fileLocalExecute ) != 0 )
                     let fileExecute = fileLocalExecute
                  endif
               endif

               if ( filereadable( expand( fileExecute ) ) != 0 )
                  if ( exists( "g:tagResultLanguages[ g:tagLanguage ]" ) == 0 )
                     let g:tagCurrentLanguageDef = {}
                     let g:tagResultLanguages[ g:tagLanguage ] = g:tagCurrentLanguageDef
                  else
                     let g:tagCurrentLanguageDef = g:tagResultLanguages[ g:tagLanguage ]
                  endif

                  execute "source " . fileExecute
               else
                  let g:tagUnhandledLanguages[ g:tagLanguage ] = g:tagLanguage
               endif
            endif
         endif
      endif

      let currentLineNum += 1
   endwhile

   if ( exists( "g:VM_actionAfterTagRead" ) != 0 )
      call g:VM_actionAfterTagRead( a:baseFolder, a:tagDictionary )
   endif

   if ( exists( "g:tagName" ) != 0 )
      unlet g:tagName
   endif

   if ( exists( "g:tagPosition" ) != 0 )
      unlet g:tagPosition
   endif

   if ( exists( "g:tagType" ) != 0 )
      unlet g:tagType
   endif

   if ( exists( "g:tagLanguage" ) != 0 )
      unlet g:tagLanguage
   endif

   if ( exists( "g:tagRemainingList" ) != 0 )
      unlet g:tagRemainingList
   endif

   if ( exists( "g:tagFilename" ) != 0 )
      unlet g:tagFilename
   endif

   if ( exists( "g:tagClassName" ) != 0 )
      unlet g:tagClassName
   endif

   if ( exists( "g:tagFileExtention" ) != 0 )
      unlet g:tagFileExtention
   endif

   if ( exists( "g:tagRelativePath" ) != 0 )
      unlet g:tagRelativePath
   endif

   if ( exists( "g:tagCurrentLanguageDef" ) != 0 )
      unlet g:tagCurrentLanguageDef
   endif

   unlet g:tagResultLanguages
   unlet g:tagBaseFolder
endfunction

endif

if ( exists( "*VM_AddFileToDictionary" ) == 0 )

" Fonction : VM_AddFileToDictionary
"
" But : Add the specified file to the current dictionary
"
" Parametres :
"    currentFile - The current filename
"    relativePath - The relative path for the current filename
"    baseFolder - The base folder for the current filename
"-------------------------------------------------------------------------------
function VM_AddFileToDictionary( currentFile, relativePath, baseFolder )
   for currentExtention in g:VM_readFileAssociatedDescription
      let extentionValue = "." . currentExtention.extention

      if ( strpart( a:currentFile, len( a:currentFile ) - len( extentionValue ) ) == extentionValue )
         if ( exists( "g:tagResultLanguages[ currentExtention.language ]" ) == 0 )
            let tagCurrentLanguageDef = {}
            let tagCurrentLanguageDef.classes = {}
            let tagCurrentLanguageDef.baseFolder = a:baseFolder
            let tagCurrentLanguageDef.sortName = currentExtention.sortName
            let tagCurrentLanguageDef.className = currentExtention.className
            let tagCurrentLanguageDef.languageName = currentExtention.language
            let tagCurrentLanguageDef.displayFct = function( "VM_DisplayFolderFiles" )

            let g:tagResultLanguages[ currentExtention.language ] = tagCurrentLanguageDef
         else
            let tagCurrentLanguageDef = g:tagResultLanguages[ currentExtention.language ]
         endif

         let currentElement = {}
         let currentElement.relativePath = a:relativePath
         let currentElement.associatedFile = a:currentFile
         let currentElement.associatedPosition = ""
         let currentElement.name = a:currentFile

         let tagCurrentLanguageDef.classes[ a:relativePath . "/" . a:currentFile ] = currentElement
      endif
   endfor
endfunction

endif

if ( exists( "*VM_DisplayFolderFiles" ) == 0 )

" Fonction : VM_DisplayFolderFiles
"
" But : Display the files gotten from folder scan.
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
function VM_DisplayFolderFiles( currentIntro, lastElement ) dict
   let folderList = {}
   let globalFolderContent = []

   for currentElement in values( self.classes )
      if ( currentElement.relativePath == "" )
         let currentList = globalFolderContent
      elseif ( exists( "folderList[ currentElement.relativePath ]" ) == 0 )
         let currentFolderContent = {}
         let currentFolderContent.name = currentElement.relativePath
         let currentFolderContent.files = []
         let currentList = currentFolderContent.files

         let folderList[ currentElement.relativePath ] = currentFolderContent
      else
         let currentFolderContent = folderList[ currentElement.relativePath ]
         let currentList = currentFolderContent.files
      endif

      call add( currentList, currentElement )
   endfor

   if ( len( globalFolderContent ) == 0 )
      let currentValue = len( folderList ) - 1
   else
      let currentValue = len( folderList )
   endif

   let retValue = [ VM_BuildTagLine( self.className, join( a:currentIntro, "" ) . "+-+> " . self.languageName, "", "" ) ]
   let usedIntro = VM_AddIntroLevel( a:currentIntro, a:lastElement )

   for currentFolder in sort( values( folderList ), 'VM_CompareName' )
      call add( retValue, VM_BuildTagLine( self.className, join( usedIntro, "" ) . "+-+( " . currentFolder.name . " )", "", "" ) )

      let folderIntro = VM_AddIntroLevel( usedIntro, currentValue )
      let retValue += VM_DisplayFolderContent( self.baseFolder, currentFolder.files, self.className, folderIntro )

      let currentValue -= 1
   endfor

   return retValue + VM_DisplayFolderContent( self.baseFolder, globalFolderContent, self.className, usedIntro )
endfunction

endif

if ( exists( "*VM_DisplayFolderContent" ) == 0 )

" Fonction : VM_DisplayFolderContent
"
" But : Display the folder element list in the classe function display.
"
" Parametres :
"    baseFolder - The base folder of the current project
"    fileList - The file list of the current folder
"    currentClass - The class corresponding to the file
"    currentIntro - The intro for the current file description
" Retour :
"    The array with the lines to be displaid
"     - text : the text to be displaid
"     - file : the complete filename
"     - position : the position to find the definition in the file
"-------------------------------------------------------------------------------
function VM_DisplayFolderContent( baseFolder, fileList, currentClass, currentIntro )
   let retValue = []

   let usedFolder = a:baseFolder

   if ( usedFolder > "" )
      let usedFolder .= "/"
   endif

   for currentFile in sort( a:fileList, 'VM_CompareName' )
      if ( currentFile.relativePath != "" )
         let completeFilename = usedFolder . currentFile.relativePath . "/" . currentFile.associatedFile
      else
         let completeFilename = usedFolder . currentFile.associatedFile
      endif

      call add( retValue, VM_BuildTagLine( a:currentClass, join( a:currentIntro, "" ) . "+-+File " . currentFile.name, completeFilename, "" ) )
   endfor

   return retValue
endfunction

endif

if ( exists( "*VM_GetAllFilesLS" ) == 0 )

" Fonction : VM_GetAllFilesLS
"
" But : Get all files for the file list definition.
"
" Parametres :
"    baseFolder - The base folder from which the search is done
"    dirList - a list that contains all the folder where the files had to be serched
"-------------------------------------------------------------------------------
function VM_GetAllFilesLS( baseFolder, dirList )
   let usedFolder = a:baseFolder

   if ( usedFolder != "" )
      let usedFolder .= "/"
   else
      let usedFolder = "./"
   endif

   let endFolderDefinition = ""

   if ( exists( "g:VM_projectEndFolderDefinition" ) != 0 )
      let endFolderDefinition = g:VM_projectEndFolderDefinition
   endif

   let stateRead = 0
   let relativeDir = ""

   for currentLine in split( system( g:VM_projectListRecursive . usedFolder . join( a:dirList, " " . usedFolder ) ), "\n" )
      if ( stateRead < 3 )
         if ( substitute( currentLine, "^total ", "", "" ) != currentLine )
            let stateRead = 3
         elseif ( currentLine > "" )
            let relativeDir = substitute( substitute( substitute( currentLine, g:VIM_REP_SEPARATOR, "/", "g" ), endFolderDefinition . "\:$", "", "" ), "^" . usedFolder, "", "" )

            if ( relativeDir == "." )
               let relativeDir = ""
            endif
            let stateRead = 2
         endif
      elseif ( currentLine == "" )
         let stateRead = 1
      elseif ( strpart( currentLine, 0, 1 ) == "-" )
         let currentFile = substitute( substitute( currentLine, g:VM_extractProjectNameBegin, "", "" ), g:VM_extractProjectNameEnd, "", "" )
         call VM_AddFileToDictionary( currentFile, relativeDir, a:baseFolder )
      endif
   endfor
endfunction

endif

if ( exists( "*VM_ReadFileExtention" ) == 0 )

" Fonction : VM_ReadFileExtention
"
" But : Read all the files from the specified folders with the expected
"       extention.
"
" Buffer : 
"    Had to be a modifiable, where the tag file had been loaded
" Parametres :
"    baseFolder - The base folder for the tag filename
"    tagDictionary - The current tag dictionary to update
"-------------------------------------------------------------------------------
function VM_ReadFileExtention( baseFolder, tagDictionary )
   if ( exists( "g:VM_readFileDirList" ) == 0 )
      let dirList = []
      for currentFolder in VM_GetFolders( a:baseFolder )
         if ( ( subFolder != "." )&&( subFolder != ".." ) )
            if ( ( exists( "g:VM_readFileDirExclude" ) == 0 )||( index( g:VM_readFileDirExclude, currentFolder ) == -1 ) )
               call add( dirList, currentFolder )
            endif
         endif
      endfor
   else
      let dirList = g:VM_readFileDirList
   endif

   " First get the files in the base folder
   "---------------------------------------
   for currentFile in VM_GetFiles( a:baseFolder )
      call VM_AddFileToDictionary( currentFile, "", a:baseFolder )
   endfor

   if ( exists( "g:VM_projectFctListRecursive" ) != 0 )
      execute "call " . g:VM_projectFctListRecursive . "( a:baseFolder, dirList )"
   else
      " Then, loop on others folders
      "-----------------------------
      let lastDir = len( dirList )
      let currentDirIndex = 0

      while ( currentDirIndex < lastDir )
         let currentDir = dirList[ currentDirIndex ]

         if ( a:baseFolder == "" )
            let completeFolderName = currentDir
         else
            let completeFolderName = a:baseFolder . "/" . currentDir
         endif

         for currentFile in VM_GetFiles( completeFolderName )
            call VM_AddFileToDictionary( currentFile, currentDir, a:baseFolder )
         endfor

         for subFolder in VM_GetFolders( completeFolderName )
            if ( ( subFolder != "." )&&( subFolder != ".." ) )
               call add( dirList, currentDir . "/" . subFolder )
               let lastDir += 1
            endif
         endfor

         let currentDirIndex += 1
      endwhile
   endif
endfunction

endif

if ( exists( "*VM_CompareName" ) == 0 )

" Fonction : VM_CompareName
"
" But : Compare the elements to get a hierarchical order
"
" Buffer : 
"
" Parametres :
"    element1 - The first element to be compared
"    element2 - The second element to be compared
" Retour :
"    < 0 if the first element is lower than the second
"    = 0 if the elements are equals
"    > 0 if the first element is greater than the second
"-------------------------------------------------------------------------------
function VM_CompareName( element1, element2 )
   let retValue = 0

   if ( a:element1.name < a:element2.name )
      let retValue = -1
   elseif ( a:element1.name > a:element2.name )
      let retValue = 1
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_CompareNameNoCasse" ) == 0 )

" Fonction : VM_CompareNameNoCasse
"
" But : Compare the elements to get a hierarchical order
"
" Buffer : 
"
" Parametres :
"    element1 - The first element to be compared
"    element2 - The second element to be compared
" Retour :
"    < 0 if the first element is lower than the second
"    = 0 if the elements are equals
"    > 0 if the first element is greater than the second
"-------------------------------------------------------------------------------
function VM_CompareNameNoCasse( element1, element2 )
   let retValue = 0

   let value1 = toupper( a:element1.name )
   let value2 = toupper( a:element2.name )

   if ( value1 < value2 )
      let retValue = -1
   elseif ( value1 > value2 )
      let retValue = 1
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_CompareSortName" ) == 0 )

" Fonction : VM_CompareSortName
"
" But : Compare the elements to get a hierarchical order
"
" Buffer : 
"
" Parametres :
"    element1 - The first element to be compared
"    element2 - The second element to be compared
" Retour :
"    < 0 if the first element is lower than the second
"    = 0 if the elements are equals
"    > 0 if the first element is greater than the second
"-------------------------------------------------------------------------------
function VM_CompareSortName( element1, element2 )
   let retValue = 0

   if ( a:element1.sortName < a:element2.sortName )
      let retValue = -1
   elseif ( a:element1.sortName > a:element2.sortName )
      let retValue = 1
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_BuildTagLine" ) == 0 )

" Fonction : VM_BuildTagLine
"
" But : Create the line element to be displaid in the tag buffer
"
" Parametres :
"    class - the class of the current line
" Retour :
"    The line element that will be displaid
"-------------------------------------------------------------------------------
function VM_BuildTagLine( class, text, filename, position )
   let retValue = {}

   let retValue.text = a:text
   let retValue.file = a:filename
   let retValue.position = a:position
   let retValue.class = a:class

   return retValue
endfunction

endif

if ( exists( "*VM_AddIntroLevel" ) == 0 )

" Fonction : VM_AddIntroLevel
"
" But : Add a new level to the current intro array
"
" Parametres :
"    currentIntro - The current intro to be updated
"    lastElement - 0 if it is the last element to print, antoher value otherwise
" Retour :
"    The updated intro
"-------------------------------------------------------------------------------
function VM_AddIntroLevel( currentIntro, lastElement )
   let retValue = a:currentIntro[ : ]

   if ( a:lastElement != 0 )
      call add( retValue, "| " )
   else
      call add( retValue, "  " )
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_DisplayTagContent" ) == 0 )

" Fonction : VM_DisplayTagContent
"
" But : Display the array build that represent the tag file content in a visible
"       way.
"
" Parametres :
"    entry - The current line to display
"-------------------------------------------------------------------------------
function VM_DisplayTagContent( entry )
   call append( line( "$" ), a:entry.text )
endfunction

endif

if ( exists( "*VM_BuildBaseFolderDefault" ) == 0 )

" Fonction : VM_BuildBaseFolderDefault
"
" But : Build the base folder for the tag file
"
" Parametres :
"    tagFile - The tag file name
" Retour :
"    The base folder name
"-------------------------------------------------------------------------------
function VM_BuildBaseFolderDefault( tagFile )
   let baseFolder = substitute( a:tagFile, "\/[^/]*$", "", "" )

   if ( ( baseFolder == a:tagFile )||( baseFolder == "." )||( baseFolder == substitute( getcwd(), g:VIM_REP_SEPARATOR, "/", "g" ) ) )
      let baseFolder = ""
   endif

   return baseFolder
endfunction

endif

if ( exists( "*VM_BuildProjectNameDefault" ) == 0 )

" Fonction : VM_BuildProjectNameDefault
"
" But : Build the project name from the BNP environment
"
" Parametres :
"    tagFile - The tag file name
" Retour :
"    The project name
"-------------------------------------------------------------------------------
function VM_BuildProjectNameDefault( tagFile )
   let retValue = "Project"
   let baseFolder = VM_BuildBaseFolderDefault( a:tagFile )

   if ( baseFolder > "" )
      let retValue = "External : " . split( baseFolder, "/" )[ -1 ]
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_ClassOpenDefinition" ) == 0 )

" Fonction : VM_ClassOpenDefinition
"
" But : Open the current file definition.
"
" Buffer : 
"
" Parametres :
"    currentDefinition - The current file definition to be opened
"-------------------------------------------------------------------------------
function VM_ClassOpenDefinition( currentDefinition )
   let specificClassToOpen = g:VM_classesDisplayToOpen . "/" . a:currentDefinition.class . ".vim"
   let g:VM_currentClassOpen = a:currentDefinition
   let g:VM_filenameClassOpen = a:currentDefinition.file
   let g:VM_positionClassOpen = a:currentDefinition.position
   let g:VM_fileSelected = 0

   if ( ( g:VM_classesTabAutoClose != 0 )&&( tabpagenr() != g:VM_forbidTabNumber ) )
      close
   endif

   if ( filereadable( expand( specificClassToOpen ) ) != 0 )
      execute "source " . specificClassToOpen
   endif

   if ( g:VM_fileSelected == 0 )
      if ( g:VM_returnTab == g:VM_forbidTabNumber )
         tabnew

         execute "edit " . g:VM_filenameClassOpen
      else
         call VM_GotoTabFile( g:VM_returnTab, g:VM_returnWindow )

         if ( bufname( "%" ) == "" )
            execute "edit " . g:VM_filenameClassOpen
         else
            call VM_BackToOriginalWindow()
            execute g:VM_classOpenDefault . " " . g:VM_filenameClassOpen
         endif
      endif
   endif

   if ( g:VM_positionClassOpen != "" )
      execute "silent! " . g:VM_positionClassOpen
   endif

   unlet g:VM_fileSelected
   unlet g:VM_positionClassOpen
   unlet g:VM_filenameClassOpen
   unlet g:VM_currentClassOpen
endfunction

endif

if ( exists( "*VM_ClassOpenFile" ) == 0 )

" Fonction : VM_ClassOpenFile
"
" But : Open the specified file.
"
" Parametres :
"    filename - The file searched
"-------------------------------------------------------------------------------
function VM_ClassOpenFile( filename )
   if ( exists( "g:VM_classesAllLines" ) == 0 )
      echo "No class definition found.\n"
   elseif ( a:filename > "" )
      for element in g:VM_classesAllLines
         if ( element.file == a:filename )
            let result = element

            break
         endif
      endfor

      if ( exists( "result" ) != 0 )
         call VM_ClassOpenDefinition( result )
      else
         echo "Class " . a:filename . " cannot be found.\n"
      endif
   endif
endfunction

endif

if ( exists( "*VM_ClassChooseClassDefinition" ) == 0 )

" Fonction : VM_ClassChooseClassDefinition
"
" But : Open the specified file.
"
" Parametres :
"    className - The class searched
"-------------------------------------------------------------------------------
function VM_ClassChooseClassDefinition( className )
   let retValue = {}

   if ( exists( "g:VM_classesAllLines" ) == 0 )
      echo "No class definition found.\n"
   elseif ( a:className > "" )
      let listDefinitions = []
      for element in g:VM_classesAllLines
         if ( ( element.file > "" ) && ( stridx( substitute( element.text, "\.*+-+[^ ]* ", "", "" ), a:className ) >= 0 ) )
            call add( listDefinitions, element )
         endif
      endfor

      let nbClasses = len( listDefinitions )

      if ( nbClasses > 1 )
         let listSelection = [ "Classes known :" ]
         let currentChoice = 1

         for currentClass in listDefinitions
            call add( listSelection, currentChoice . " -- " . substitute( currentClass.text, "\.*+-+[^ ]* ", "", "" ) . " -- " . currentClass.file )

            let currentChoice += 1
         endfor

         let classNumber = inputlist( listSelection ) - 1

         if ( ( classNumber >= 0 ) && ( classNumber < ( currentChoice - 1 ) ) )
            let retValue = listDefinitions[ classNumber ]
         endif
      elseif ( nbClasses > 0 )
         let retValue = listDefinitions[ 0 ]
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_ShowTags" ) == 0 )

" Fonction : VM_ShowTags
"
" But : Convert the tag files into readable version to be displaid.
"
" Parametres :
"    BuildBaseFolder - function used to build the base folder name
"    BuildDictionaryName - function used to get the dictionnary name
"-------------------------------------------------------------------------------
function VM_ShowTags( BuildBaseFolder, BuildDictionaryName )
   call VM_RemindsOriginalWindow()
   let bufferName = "[Classes]"

   if ( bufferName == bufname( winbufnr( 1 ) ) )
      1wincmd w
   else
      let g:VM_returnWindow += 1
      call VM_DisplayInternalWindowNoDelete( bufferName, "vert topleft 50 sview", "VM_classes_display", [], "" )
   endif

   if ( exists( "g:VM_classesAllLines" ) == 0 )
      set modifiable
      set noreadonly

      let g:VM_classesAllLines = []
      let dictionaries = []
      let sortValue = 0

      " Loop on the tag files
      "----------------------
      for currentTag in split( &tags, "," )
         let tagFile = substitute( currentTag, g:VIM_REP_SEPARATOR, "/", "g" )
         let baseFolder = a:BuildBaseFolder( tagFile )
         let sortIdentifier = "0000" + string( sortValue )
         let sortIdentifier = strpart( sortIdentifier, len( sortIdentifier ) - 3 )

         let globalDict = {}
         let globalDict.name = a:BuildDictionaryName( currentTag )
         let globalDict.sortName = sortIdentifier
         let globalDict.languages = {}

         if ( filereadable( expand( currentTag ) ) != 0 )
            silent % delete _
            execute "silent read " . currentTag

            call add( dictionaries, globalDict )
            call VM_ReadTagsFile( baseFolder, globalDict.languages )

            if ( len( globalDict.languages ) == 0 )
               call remove( dictionaries, len( dictionaries ) - 1 )
            endif

            let sortValue += 1
         endif
      endfor

      " The tags had been read, now display them in the window
      "-------------------------------------------------------
      silent % delete _

      let lastGroup = len( dictionaries ) - 1

      for currentTagDef in sort( dictionaries, 'VM_CompareSortName' )
         call add( g:VM_classesAllLines, VM_BuildTagLine( "", "+ " . currentTagDef.name, "", "" ) )

         let leftElement = len( currentTagDef.languages ) - 1

         for currentLanguage in sort( values( currentTagDef.languages ), 'VM_CompareSortName' )
            let g:VM_classesAllLines += currentLanguage.displayFct( [], leftElement )

            let leftElement -= 1
         endfor

         if ( lastGroup > 0 )
            call add( g:VM_classesAllLines, VM_BuildTagLine( "", "", "", "" ) )
         endif

         let lastGroup -= 1
      endfor

      " The array to display is available, now display it
      "--------------------------------------------------
      call VM_DisplayText( "VM_classes_display", g:VM_classesAllLines, "VM_DisplayTagContent" )
      1
   elseif ( line( "$" ) == 1 )
      call VM_DisplayText( "VM_classes_display", g:VM_classesAllLines, "VM_DisplayTagContent" )
      1
   endif
endfunction

endif

if ( exists( "*VM_SearchDelete" ) == 0 )

" Fonction : VM_SearchDelete
"
" But : Delete the first or the last char of the searched text
"
" Buffer : 
"
" Parametres :
"    last - 0 to delete the first char, another value to delete the last one
"-------------------------------------------------------------------------------
function VM_SearchDelete( last )
   let lengthSearched = len( g:VM_searchedText )

   if ( lengthSearched > 0 )
      let lengthSearched -= 1

      if ( a:last == 0 )
         let g:VM_searchedText = strpart( g:VM_searchedText, 1, lengthSearched )
      else
         let g:VM_searchedText = strpart( g:VM_searchedText, 0, lengthSearched )
      endif

      if ( lengthSearched > 0 )
         call VM_ExecuteSearch( 1, "c" )
      else
         match none
      endif
   endif
endfunction

endif

if ( exists( "*VM_SearchInputText" ) == 0 )

" Fonction : VM_SearchInputText
"
" But : Search for the input text
"
" Buffer : 
"
" Parametres :
"    newLetter - The letter to be add to the searched text
"-------------------------------------------------------------------------------
function VM_SearchInputText( newLetter )
   let redoMatch = 0
   let flag = ""

   if ( a:newLetter > "" )
      let g:VM_searchedText .= a:newLetter
      let redoMatch = 1
      let flag = "c"
   endif

   call VM_ExecuteSearch( redoMatch, flag )
endfunction

endif

if ( exists( "*VM_NextSearch" ) == 0 )

" Fonction : VM_NextSearch
"
" But : The function used to search the next occurence of the last searched
"       value.
"
"-------------------------------------------------------------------------------
function VM_NextSearch()
   if ( g:VM_searchedText == "" )
      call VM_SearchInputText( @/ )
   else
      call VM_ExecuteSearch( 0, "" )
   endif
endfunction

endif

if ( exists( "*VM_RegisterSearch" ) == 0 )

" Fonction : VM_RegisterSearch
"
" But : Search for the specified register
"
" Parametres :
"    register - The register to be used for searching
"-------------------------------------------------------------------------------
function VM_RegisterSearch( register )
   execute "let g:VM_searchedText = @" . a:register

   call VM_ExecuteSearch( 1, "c" )
endfunction

endif

if ( exists( "*VM_ExecuteSearch" ) == 0 )

" Fonction : VM_ExecuteSearch
"
" But : Execute the search of the searched class
"
" Buffer : 
"
" Parametres :
"    redoMatch - 0 to not match the searched text, another value otherwise
"    flag - The additionnal flag to be set on the search call
"-------------------------------------------------------------------------------
function VM_ExecuteSearch( redoMatch, flag )
   if ( a:redoMatch != 0 )
      match none
      execute "match Search /" . g:VM_searchedText . "/"
   endif

   let lineSearch = search( g:VM_searchedIntro . g:VM_searchedText, "w" . a:flag )

   if ( lineSearch != 0 )
      echo g:VM_searchedText
   else
      echo "Not found : " . g:VM_searchedText
   endif
endfunction

endif

if ( exists( "*VM_AutoSearchMapping" ) == 0 )

" Fonction : VM_AutoSearchMapping
"
" But : Set the maps used for auto-searched buffers
"-------------------------------------------------------------------------------
function VM_AutoSearchMapping()
   nmap <buffer> <BS> :call VM_SearchDelete( 1 )<CR>
   nmap <buffer> <Del> :call VM_SearchDelete( 0 )<CR>
   nmap <buffer> ? :let g:VM_searchedText = ""<CR>:match none<CR>
   nmap <buffer> / :call VM_NextSearch()<CR>
   nmap <buffer> A :call VM_SearchInputText( "A" )<CR>
   nmap <buffer> B :call VM_SearchInputText( "B" )<CR>
   nmap <buffer> C :call VM_SearchInputText( "C" )<CR>
   nmap <buffer> D :call VM_SearchInputText( "D" )<CR>
   nmap <buffer> E :call VM_SearchInputText( "E" )<CR>
   nmap <buffer> F :call VM_SearchInputText( "F" )<CR>
   nmap <buffer> G :call VM_SearchInputText( "G" )<CR>
   nmap <buffer> H :call VM_SearchInputText( "H" )<CR>
   nmap <buffer> I :call VM_SearchInputText( "I" )<CR>
   nmap <buffer> J :call VM_SearchInputText( "J" )<CR>
   nmap <buffer> K :call VM_SearchInputText( "K" )<CR>
   nmap <buffer> L :call VM_SearchInputText( "L" )<CR>
   nmap <buffer> M :call VM_SearchInputText( "M" )<CR>
   nmap <buffer> N :call VM_SearchInputText( "N" )<CR>
   nmap <buffer> O :call VM_SearchInputText( "O" )<CR>
   nmap <buffer> P :call VM_SearchInputText( "P" )<CR>
   nmap <buffer> Q :call VM_SearchInputText( "Q" )<CR>
   nmap <buffer> R :call VM_SearchInputText( "R" )<CR>
   nmap <buffer> S :call VM_SearchInputText( "S" )<CR>
   nmap <buffer> T :call VM_SearchInputText( "T" )<CR>
   nmap <buffer> U :call VM_SearchInputText( "U" )<CR>
   nmap <buffer> V :call VM_SearchInputText( "V" )<CR>
   nmap <buffer> W :call VM_SearchInputText( "W" )<CR>
   nmap <buffer> X :call VM_SearchInputText( "X" )<CR>
   nmap <buffer> Y :call VM_SearchInputText( "Y" )<CR>
   nmap <buffer> Z :call VM_SearchInputText( "Z" )<CR>
   nmap <buffer> a :call VM_SearchInputText( "a" )<CR>
   nmap <buffer> b :call VM_SearchInputText( "b" )<CR>
   nmap <buffer> c :call VM_SearchInputText( "c" )<CR>
   nmap <buffer> d :call VM_SearchInputText( "d" )<CR>
   nmap <buffer> e :call VM_SearchInputText( "e" )<CR>
   nmap <buffer> f :call VM_SearchInputText( "f" )<CR>
   nmap <buffer> g :call VM_SearchInputText( "g" )<CR>
   nmap <buffer> h :call VM_SearchInputText( "h" )<CR>
   nmap <buffer> i :call VM_SearchInputText( "i" )<CR>
   nmap <buffer> j :call VM_SearchInputText( "j" )<CR>
   nmap <buffer> k :call VM_SearchInputText( "k" )<CR>
   nmap <buffer> l :call VM_SearchInputText( "l" )<CR>
   nmap <buffer> m :call VM_SearchInputText( "m" )<CR>
   nmap <buffer> n :call VM_SearchInputText( "n" )<CR>
   nmap <buffer> o :call VM_SearchInputText( "o" )<CR>
   nmap <buffer> p :call VM_SearchInputText( "p" )<CR>
   nmap <buffer> q :call VM_SearchInputText( "q" )<CR>
   nmap <buffer> r :call VM_SearchInputText( "r" )<CR>
   nmap <buffer> s :call VM_SearchInputText( "s" )<CR>
   nmap <buffer> t :call VM_SearchInputText( "t" )<CR>
   nmap <buffer> u :call VM_SearchInputText( "u" )<CR>
   nmap <buffer> v :call VM_SearchInputText( "v" )<CR>
   nmap <buffer> w :call VM_SearchInputText( "w" )<CR>
   nmap <buffer> x :call VM_SearchInputText( "x" )<CR>
   nmap <buffer> y :call VM_SearchInputText( "y" )<CR>
   nmap <buffer> z :call VM_SearchInputText( "z" )<CR>
   nmap <buffer> 0 :call VM_SearchInputText( "0" )<CR>
   nmap <buffer> 1 :call VM_SearchInputText( "1" )<CR>
   nmap <buffer> 2 :call VM_SearchInputText( "2" )<CR>
   nmap <buffer> 3 :call VM_SearchInputText( "3" )<CR>
   nmap <buffer> 4 :call VM_SearchInputText( "4" )<CR>
   nmap <buffer> 5 :call VM_SearchInputText( "5" )<CR>
   nmap <buffer> 6 :call VM_SearchInputText( "6" )<CR>
   nmap <buffer> 7 :call VM_SearchInputText( "7" )<CR>
   nmap <buffer> 8 :call VM_SearchInputText( "8" )<CR>
   nmap <buffer> 9 :call VM_SearchInputText( "9" )<CR>
   nmap <buffer> . :call VM_SearchInputText( "." )<CR>
   nmap <buffer> * :call VM_SearchInputText( "*" )<CR>
   nmap <buffer> - :call VM_SearchInputText( "-" )<CR>
   nmap <buffer> _ :call VM_SearchInputText( "_" )<CR>
   nmap <buffer> + :call VM_SearchInputText( "+" )<CR>
   nmap <buffer> %A :call VM_RegisterSearch( "A" )<CR>
   nmap <buffer> %B :call VM_RegisterSearch( "B" )<CR>
   nmap <buffer> %C :call VM_RegisterSearch( "C" )<CR>
   nmap <buffer> %D :call VM_RegisterSearch( "D" )<CR>
   nmap <buffer> %E :call VM_RegisterSearch( "E" )<CR>
   nmap <buffer> %F :call VM_RegisterSearch( "F" )<CR>
   nmap <buffer> %G :call VM_RegisterSearch( "G" )<CR>
   nmap <buffer> %H :call VM_RegisterSearch( "H" )<CR>
   nmap <buffer> %I :call VM_RegisterSearch( "I" )<CR>
   nmap <buffer> %J :call VM_RegisterSearch( "J" )<CR>
   nmap <buffer> %K :call VM_RegisterSearch( "K" )<CR>
   nmap <buffer> %L :call VM_RegisterSearch( "L" )<CR>
   nmap <buffer> %M :call VM_RegisterSearch( "M" )<CR>
   nmap <buffer> %N :call VM_RegisterSearch( "N" )<CR>
   nmap <buffer> %O :call VM_RegisterSearch( "O" )<CR>
   nmap <buffer> %P :call VM_RegisterSearch( "P" )<CR>
   nmap <buffer> %Q :call VM_RegisterSearch( "Q" )<CR>
   nmap <buffer> %R :call VM_RegisterSearch( "R" )<CR>
   nmap <buffer> %S :call VM_RegisterSearch( "S" )<CR>
   nmap <buffer> %T :call VM_RegisterSearch( "T" )<CR>
   nmap <buffer> %U :call VM_RegisterSearch( "U" )<CR>
   nmap <buffer> %V :call VM_RegisterSearch( "V" )<CR>
   nmap <buffer> %W :call VM_RegisterSearch( "W" )<CR>
   nmap <buffer> %X :call VM_RegisterSearch( "X" )<CR>
   nmap <buffer> %Y :call VM_RegisterSearch( "Y" )<CR>
   nmap <buffer> %Z :call VM_RegisterSearch( "Z" )<CR>
   nmap <buffer> %a :call VM_RegisterSearch( "a" )<CR>
   nmap <buffer> %b :call VM_RegisterSearch( "b" )<CR>
   nmap <buffer> %c :call VM_RegisterSearch( "c" )<CR>
   nmap <buffer> %d :call VM_RegisterSearch( "d" )<CR>
   nmap <buffer> %e :call VM_RegisterSearch( "e" )<CR>
   nmap <buffer> %f :call VM_RegisterSearch( "f" )<CR>
   nmap <buffer> %g :call VM_RegisterSearch( "g" )<CR>
   nmap <buffer> %h :call VM_RegisterSearch( "h" )<CR>
   nmap <buffer> %i :call VM_RegisterSearch( "i" )<CR>
   nmap <buffer> %j :call VM_RegisterSearch( "j" )<CR>
   nmap <buffer> %k :call VM_RegisterSearch( "k" )<CR>
   nmap <buffer> %l :call VM_RegisterSearch( "l" )<CR>
   nmap <buffer> %m :call VM_RegisterSearch( "m" )<CR>
   nmap <buffer> %n :call VM_RegisterSearch( "n" )<CR>
   nmap <buffer> %o :call VM_RegisterSearch( "o" )<CR>
   nmap <buffer> %p :call VM_RegisterSearch( "p" )<CR>
   nmap <buffer> %q :call VM_RegisterSearch( "q" )<CR>
   nmap <buffer> %r :call VM_RegisterSearch( "r" )<CR>
   nmap <buffer> %s :call VM_RegisterSearch( "s" )<CR>
   nmap <buffer> %t :call VM_RegisterSearch( "t" )<CR>
   nmap <buffer> %u :call VM_RegisterSearch( "u" )<CR>
   nmap <buffer> %v :call VM_RegisterSearch( "v" )<CR>
   nmap <buffer> %w :call VM_RegisterSearch( "w" )<CR>
   nmap <buffer> %x :call VM_RegisterSearch( "x" )<CR>
   nmap <buffer> %y :call VM_RegisterSearch( "y" )<CR>
   nmap <buffer> %z :call VM_RegisterSearch( "z" )<CR>
   nmap <buffer> %* :call VM_RegisterSearch( "*" )<CR>
   nmap <buffer> %+ :call VM_RegisterSearch( "+" )<CR>
   nmap <buffer> %0 :call VM_RegisterSearch( "0" )<CR>
   nmap <buffer> %1 :call VM_RegisterSearch( "1" )<CR>
   nmap <buffer> %2 :call VM_RegisterSearch( "2" )<CR>
   nmap <buffer> %3 :call VM_RegisterSearch( "3" )<CR>
   nmap <buffer> %4 :call VM_RegisterSearch( "4" )<CR>
   nmap <buffer> %5 :call VM_RegisterSearch( "5" )<CR>
   nmap <buffer> %6 :call VM_RegisterSearch( "6" )<CR>
   nmap <buffer> %7 :call VM_RegisterSearch( "7" )<CR>
   nmap <buffer> %8 :call VM_RegisterSearch( "8" )<CR>
   nmap <buffer> %9 :call VM_RegisterSearch( "9" )<CR>
endfunction

endif

if ( exists( "*VM_BuildProjectImports" ) == 0 )

" Fonction : VM_BuildProjectImports
"
" But : Build all the projects imports / include.
"
" Parametres :
"    importText - The text to search to find the imports available
"-------------------------------------------------------------------------------
function VM_BuildProjectImports( importText )
   execute "vsplit " . g:VM_projectImportsFile
   let currentFile = expand( "%" )
   execute "vimgrep /" . a:importText . "/ " . g:VM_projectImportSearchFiles
   copen
   %yank
   cclose
   execute "edit! " . g:VM_projectImportsFile
   %delete _
   put
   1 delete _

   %substitute /.*| //
   %sort
   call VM_EliminateDuplicatedLine()

   write
   close
   if ( currentFile == expand( "%" ) )
      close
   endif
endfunction

endif

if ( exists( "*VM_GetProjectsImports" ) == 0 )

" Fonction : VM_GetProjectsImports
"
" But : Get the imports and return them in a list.
"
" Parametres :
"    importToGet - The import value to search
" Retour :
"    The list of the imports matching the tag
"-------------------------------------------------------------------------------
function VM_GetProjectsImports( importToGet )
   execute "split " . g:VM_projectImportsFile
   let importsList = []
   execute "silent %global /" . a:importToGet . "/ call add( importsList, getline( \".\" ) )"
   close

   return importsList
endfunction

endif

if ( exists( "*VM_TestFoldDisabled" ) == 0 )

" Fonction : VM_TestFoldDisabled
"
" But : Test if the fold is disabled or not.
"
" Retour :
"    0 if the fold is enabled, another value otherwise
"-------------------------------------------------------------------------------
function VM_TestFoldDisabled()
   let testValueFold = 0

   if ( exists( "g:VM_foldDisableAll" ) != 0 )
      let testValueFold = g:VM_foldDisableAll
   endif
   
   if ( ( testValueFold == 0 )&&( exists( "g:VM_foldDisable_" . &filetype ) != 0 ) )
      execute "let testValueFold = g:VM_foldDisable_" . &filetype

      if ( ( substitute( testValueFold, "^[A-Z]", "", "" ) != testValueFold )&&( exists( "*" . testValueFold ) != 0 ) )
         execute "let testValueFold = " . testValueFold . "()"
      endif
   endif

   return testValueFold
endfunction

endif

if ( exists( "*VM_EscapeCommand" ) == 0 )
 
" Fonction : VM_EscapeCommand
"
" But : Escape the chars in the string used to pass to the system call
"
" Parametres :
"    command - the command to escape
" Retour :
"    Escaped string
"-------------------------------------------------------------------------------
function VM_EscapeCommand( command )
   return substitute( substitute( a:command, "\\", "\\\\\\", "g" ), "\"", "\\\\\"", "g" )
endfunction
 
endif

if ( exists( "*VM_ChooseProject" ) == 0 )

" Fonction : VM_ChooseProject
"
" But : Select the project to use, display the list of the current projects
"       before requesting the choice.
"
" Retour :
"    The selected project
"-------------------------------------------------------------------------------
function VM_ChooseProject()
   for currentProject in VM_GetFolders( "" )
      echo "> " . currentProject . "\n"
   endfor
   let projectFolder = input( "\nProject : ", "", "dir" )
   echo "\n"

   return projectFolder
endfunction

endif

if ( exists( "*VM_ExtractFileIntro" ) == 0 )

" Fonction : VM_ExtractFileIntro
"
" But : Extract the file intro from the specified class name.
"
" Parametres :
"    className - the name of the class to create
" Retour :
"    The file intro associated to the class name
"-------------------------------------------------------------------------------
function VM_ExtractFileIntro( className )
   return substitute( a:className, "\_.*", "", "" )
endfunction

endif

if ( exists( "*VM_ReplaceFileIntro" ) == 0 )

" Fonction : VM_ReplaceFileIntro
"
" But : Replace the file introduction by the specified one.
"
" Parametres :
"    className - the name of the class to create
"    newFileIntro - the new file introduction to use
" Retour :
"    The class name using the new file introduction
"-------------------------------------------------------------------------------
function VM_ReplaceFileIntro( className, newFileIntro )
   return substitute( a:className, "^[^_]\\+", a:newFileIntro, "" )
endfunction

endif

if ( exists( "*VM_SelectExistingFolder" ) == 0 )

" Fonction : VM_SelectExistingFolder
"
" But : Select the folder for the class depending on the class name
"
" Parametres :
"    className - the name of the class to create
"-------------------------------------------------------------------------------
function VM_SelectExistingFolder( className )
   " Get the file intro code
   "------------------------
   let fileIntro = VM_ExtractFileIntro( a:className )
   let extentionDefinition = {}

   for currentExtention in g:VM_listProjectFolders
      if ( currentExtention.fileIntro == fileIntro )
         let extentionDefinition = currentExtention

         " End the loop
         "-------------
         break
      endif
   endfor

   return extentionDefinition
endfunction

endif

if ( exists( "*VM_SelectExistingFolderEmpty" ) == 0 )

" Fonction : VM_SelectExistingFolderEmpty
"
" But : Select the folder for the class depending on the class name, or return
"       an empty string.
"
" Parametres :
"    className - the name of the class to create
"-------------------------------------------------------------------------------
function VM_SelectExistingFolderEmpty( className )
   let extentionDefinition = VM_SelectExistingFolder( a:className )

   if ( empty( extentionDefinition ) )
      return ""
   endif

   return extentionDefinition.folder
endfunction

endif

if ( exists( "*VM_SelectFolder" ) == 0 )

" Fonction : VM_SelectFolder
"
" But : Select the folder for the class depending on the class name.
"
" Parametres :
"    className - the name of the class to create
"    projectFolder - The project base folder
" Retour :
"    The folder name choosen
"-------------------------------------------------------------------------------
function VM_SelectFolder( className, projectFolder )
   let extentionDefinition = VM_SelectExistingFolder( a:className )

   if ( empty( extentionDefinition ) )
      let separator = ""
      let listFolders = ""
      for currentExtention in g:VM_listProjectFolders
         let listFolders .= separator . currentExtention.folder
         let separator = ", "
      endfor
      echo "Select folder for : " . a:className . "\n"
      echo "---------------------------------------\n"
      for s:currentProject in VM_GetFolders( a:projectFolder )
         echo "      > " . s:currentProject . "\n"
      endfor
      echo "-------------------------\n"
      echo "Traditional choices are : " . listFolders . "\n"
      let extentionDefinition.folder = input( "\nRepository : " )
      let extentionDefinition.fileIntro = fileIntro
      echo "\n"

      call add( g:VM_listProjectFolders, extentionDefinition )
   endif

   return extentionDefinition.folder
endfunction

endif
 
if ( exists( "*VM_SaveWorkspace" ) == 0 )

" Fonction : VM_SaveWorkspace
"
" But : Save the current workspace
"
" Retour :
"    The complete tabs description
"-------------------------------------------------------------------------------
function VM_SaveWorkspace()
   wall

   let tabOrigin = tabpagenr()
   let winOrigin = winnr()

   let tabList = []
   let tabComplete = {'tabList':tabList, 'tabOrigin':tabOrigin, 'winOrigin':winOrigin}
   let tabNumber = 1

   while tabNumber <= tabpagenr( "$" )
      execute tabNumber . "tabnext"

      let winTabOrigin = winnr()
      let listWindows = []
      let winNumber = 1

      while winNumber <= winnr( "$" )
         let currentFilename = bufname( winbufnr( winNumber ) )

         if ( ( currentFilename > "" ) &&( filereadable( currentFilename ) == 0 ) )
            execute winNumber . "wincmd w"
            close
         else
            let winNumber += 1
         endif
      endwhile

      if ( winTabOrigin > winnr( "$" ) )
         let winTabOrigin = winnr( "$" )
      endif

      let winNumber = 1

      while winNumber <= winnr( "$" )
         execute winNumber . "wincmd w"

         let winDescriptor = {}
         let winDescriptor.identifier = winNumber
         let winDescriptor.folder = substitute( getcwd(), "\\", "/", "g" )
         let winDescriptor.bufferIdentifier = winbufnr( winNumber )
         let winDescriptor.filename = bufname( winDescriptor.bufferIdentifier )

         if ( winDescriptor.filename > "" )
            let winDescriptor.filePosition = winsaveview()
         endif

         let winDescriptor.width = winwidth( winNumber )
         let winDescriptor.height = winheight( winNumber )

         wincmd l

         let winDescriptor.rightWin = winnr()

         execute winNumber . "wincmd w"
         wincmd k

         let winDescriptor.upperWin = winnr()

         execute winNumber . "wincmd w"
         wincmd h

         let winDescriptor.leftWin = winnr()

         execute winNumber . "wincmd w"
         wincmd j

         let winDescriptor.downWin = winnr()

         if ( winDescriptor.leftWin == winNumber )
            let winDescriptor.posX = 0
         else
            let winDescriptor.posX = 1 + listWindows[ winDescriptor.leftWin - 1 ].width + listWindows[ winDescriptor.leftWin - 1 ].posX
         endif

         if ( winDescriptor.upperWin == winNumber )
            let winDescriptor.posY = 0
         else
            let winDescriptor.posY = 1 + listWindows[ winDescriptor.upperWin - 1 ].height + listWindows[ winDescriptor.upperWin - 1 ].posY
         endif

         call add( listWindows, winDescriptor )

         let winNumber += 1
      endwhile

      let tabDefinition = {}

      let tabDefinition.windowList = listWindows
      let tabDefinition.activeWin = winTabOrigin

      call add( tabList, tabDefinition )
      let tabNumber += 1
   endwhile

   call VM_RestoreTabSavePosition( tabComplete )

   return tabComplete
endfunction

endif

if ( exists( "*VM_ComputeBlock" ) == 0 )

" Fonction : VM_ComputeBlock
"
" But : Compute the blocks for the workspace creation.
"
" Parametres :
"    tabDescription - The complete tab description
" Retour :
"    The block that describe the windows in the current tab
"-------------------------------------------------------------------------------
function VM_ComputeBlock( tabDescription )
   let verticalSplit = {}
   let horizontalSplit = {}
   let listBlocks = []

   for currentWin in a:tabDescription.windowList
      let currentBlock = {}

      let currentBlock.action = ""
      let currentBlock.distance = 0
      let currentBlock.posX = currentWin.posX
      let currentBlock.posY = currentWin.posY
      let currentBlock.width = currentWin.width
      let currentBlock.height = currentWin.height
      let currentBlock.listBlocks = []
      let currentBlock.identifier = currentWin.identifier
      let currentBlock.winIdentifier = currentWin.identifier

      call add( listBlocks, currentBlock )
      call VM_ComputeSplit( currentBlock, horizontalSplit, verticalSplit )
   endfor

   let loopStop = 0

   while ( loopStop == 0 )
      let previousBlock = listBlocks[ 0 ]
      let lastBlockIdentifier = len( listBlocks )
      let listBlocks = []
      let actionDestination = {}
      let actionDestination = VM_ComputeBlockAction( verticalSplit, "vsplit", actionDestination )
      let actionDestination = VM_ComputeBlockAction( horizontalSplit, "split", actionDestination )
      let verticalSplit = {}
      let horizontalSplit = {}

      let loopStop = empty( actionDestination )
      let lastActionDone = ""

      let currentBlockIdentifier = 2

      while currentBlockIdentifier <= lastBlockIdentifier
         let currentBlock = actionDestination[ currentBlockIdentifier ]

         if ( ( currentBlock.distance == 1 )&&( ( lastActionDone == "" )||( lastActionDone == currentBlock.action ) ) )
            if ( currentBlock.action == "split" )
               if ( currentBlock.width == previousBlock.width )
                  let lastActionDone = currentBlock.action

                  if ( previousBlock.identifier == ( currentBlock.identifier - 1 ) )
                     let previousBlock = VM_BuildMergeBlock( previousBlock, lastActionDone )
                  endif

                  let previousBlock.height += currentBlock.height + 1
                  call add( previousBlock.listBlocks, currentBlock )

                  let currentBlock = previousBlock
               endif
            elseif ( currentBlock.action == "vsplit" )
               if ( currentBlock.height == previousBlock.height )
                  let lastActionDone = currentBlock.action

                  if ( previousBlock.identifier == ( currentBlock.identifier - 1 ) )
                     let previousBlock = VM_BuildMergeBlock( previousBlock, lastActionDone )
                  endif

                  let previousBlock.width += currentBlock.width + 1
                  call add( previousBlock.listBlocks, currentBlock )

                  let currentBlock = previousBlock
               endif
            else
               echo "Unexpected action [" . currentBlock.action . "] on block id " . currentBlock.identifier . "\n"
            endif
         endif

         if ( previousBlock != currentBlock )
            call add( listBlocks, previousBlock )

            let previousBlock = currentBlock
         endif

         let currentBlockIdentifier += 1
      endwhile

      call add( listBlocks, previousBlock )

      let currentIdentifier = 1

      for currentBlock in listBlocks
         let currentBlock.identifier = currentIdentifier

         call VM_ComputeSplit( currentBlock, horizontalSplit, verticalSplit )

         let currentIdentifier += 1
      endfor
   endwhile

   return listBlocks[ 0 ]
endfunction

endif

if ( exists( "*VM_ComputeBlockAction" ) == 0 )

" Fonction : VM_ComputeBlockAction
"
" But : Compute the block action to reach all blocks
"
" Parametres :
"    blockDefinitions - The block/window list
"    actionPerformed - The action requested between two windows
"    actionDestination - The dictionary where the windows will be stored
" Retour :
"    The list that contains the dictionnary with the window list for each position
"-------------------------------------------------------------------------------
function VM_ComputeBlockAction( blockDefinitions, actionPerformed, actionDestination )
   for currentPos in keys( a:blockDefinitions )
      let previousBlock = {}

      for currentBlock in a:blockDefinitions[ currentPos ]
         if ( empty( previousBlock ) == 0 )
            if ( exists( "a:actionDestination[ " . currentBlock.identifier . " ]" ) == 0 )
               let currentBlock.action = a:actionPerformed
               let currentBlock.distance = currentBlock.identifier - previousBlock.identifier

               let a:actionDestination[ currentBlock.identifier ] = currentBlock
            else
               let currentDistance = currentBlock.identifier - previousBlock.identifier

               if ( currentBlock.distance > currentDistance )
                  let currentBlock.action = a:actionPerformed
                  let currentBlock.distance = currentDistance
               endif
            endif
         endif

         let previousBlock = currentBlock
      endfor
   endfor

   return a:actionDestination
endfunction

endif

if ( exists( "*VM_ComputeSplit" ) == 0 )

" Fonction : VM_ComputeSplit
"
" But : Compute the horizontal and vertical split to do.
"
" Parametres :
"    currentObj - The window / block to add in the vertical and horizontal dictionnary
"    horizontalSplit - The dictionnary that hold the horizontal positions
"    verticalSplit - The distionary that hold the vertical positions
"-------------------------------------------------------------------------------
function VM_ComputeSplit( currentObj, horizontalSplit, verticalSplit )
   if ( exists( "a:verticalSplit[ " . a:currentObj.posY . " ]" ) == 0 )
      let splitList = []

      let a:verticalSplit[ a:currentObj.posY ] = splitList
   else
      let splitList = a:verticalSplit[ a:currentObj.posY ]
   endif

   call add( splitList, a:currentObj )

   if ( exists( "a:horizontalSplit[ " . a:currentObj.posX . " ]" ) == 0 )
      let splitList = []

      let a:horizontalSplit[ a:currentObj.posX ] = splitList
   else
      let splitList = a:horizontalSplit[ a:currentObj.posX ]
   endif

   call add( splitList, a:currentObj )
endfunction

endif

if ( exists( "*VM_BuildMergeBlock" ) == 0 )

" Fonction : VM_BuildMergeBlock
"
" But : Build a new block for merging other blocks
"
" Parametres :
"    previousBlock - The block used as reference to the new built block
"    action - The action used to get this block
" Retour :
"    The build block
"-------------------------------------------------------------------------------
function VM_BuildMergeBlock( previousBlock, action )
   let mergeBlock = {}

   let mergeBlock.buildAction = a:action
   let mergeBlock.action = a:previousBlock.action
   let mergeBlock.distance = 0
   let mergeBlock.posX = a:previousBlock.posX
   let mergeBlock.posY = a:previousBlock.posY
   let mergeBlock.width = a:previousBlock.width
   let mergeBlock.height = a:previousBlock.height
   let mergeBlock.listBlocks = []
   let mergeBlock.identifier = a:previousBlock.identifier

   call add( mergeBlock.listBlocks, a:previousBlock )

   return mergeBlock
endfunction

endif

if ( exists( "*VM_RestoreTab" ) == 0 )

" Fonction : VM_RestoreTab
"
" But : Create the list of command to execute to get the tab configuration
"
" Parametres :
"    currentTabDefinition - The current tab definition ( windows definitions list )
" Retour :
"    The list of the command used to restore the current tab
"-------------------------------------------------------------------------------
function VM_RestoreTab( currentTabDefinition )
   let blockDefinition = VM_ComputeBlock( a:currentTabDefinition )
   let commandList = VM_BuildOrderWin( 1, blockDefinition, [] )

   for currentWin in a:currentTabDefinition.windowList
      call add( commandList, currentWin.identifier . "wincmd w" )
      call add( commandList, "resize " . currentWin.height )
      call add( commandList, "vertical resize " . currentWin.width )
   endfor

   for currentWin in a:currentTabDefinition.windowList
      if ( exists( "currentWin.filePosition" ) != 0 )
         call add( commandList, currentWin.identifier . "wincmd w" )
         " call add( commandList, "cd " . currentWin.folder )
         call add( commandList, "edit " . currentWin.filename )
         call add( commandList, "call winrestview( " . string( currentWin.filePosition ) . " )" )
      endif
   endfor

   call add( commandList, a:currentTabDefinition.activeWin . "wincmd w" )

   return commandList
endfunction

endif

if ( exists( "*VM_BuildOrderWin" ) == 0 )

" Fonction : VM_BuildOrderWin
"
" But : Build the table used to get the strategy and the portfolio for the
"       Mobilis flows
"
" Parametres :
"    numberBaseWin - The base number of the left windows
"    blockDefinition - The current block to be used in the specified windows number
"    listCommands - The list of the commands to be used to build the windows for getting the windows of the current block
" Retour :
"    The list of the commands used to build all the windows to the current block and the commands to build the current block
"-------------------------------------------------------------------------------
function VM_BuildOrderWin( numberBaseWin, blockDefinition, listCommands )
   call add( a:listCommands, a:numberBaseWin . "wincmd w" )

   if ( exists( "a:blockDefinition.buildAction" ) != 0 )
      let currentListPosition = len( a:blockDefinition.listBlocks ) - 1

      while currentListPosition > 0
         call add( a:listCommands, "resize" )
         call add( a:listCommands, "vertical resize" )
         call add( a:listCommands, a:blockDefinition.buildAction )

         let currentListPosition -= 1
      endwhile

      let currentListPosition = len( a:blockDefinition.listBlocks ) - 1
      let currentWinNumber = a:numberBaseWin + currentListPosition

      while ( currentListPosition >= 0 )
         let currentBlock = a:blockDefinition.listBlocks[ currentListPosition ]

         call add( a:listCommands, currentWinNumber . "wincmd w" )

         call VM_BuildOrderWin( currentWinNumber, currentBlock, a:listCommands )

         let currentListPosition -= 1
         let currentWinNumber -= 1
      endwhile
   endif

   return a:listCommands
endfunction

endif

if ( exists( "*VM_RestoreProjectTab" ) == 0 )

" Fonction : VM_RestoreProjectTab
"
" But : Restore the project tabs
"
" Parametres :
"    tabDescription - The complete tab description
"-------------------------------------------------------------------------------
function VM_RestoreProjectTab( tabsDescription )
   for currentTab in a:tabsDescription.tabList
      tabnew

      call VM_ExecuteList( VM_RestoreTab( currentTab ) )
   endfor

   1tabnext
   tabclose

   call VM_RestoreTabSavePosition( a:tabsDescription )
endfunction

endif

if ( exists( "*VM_SaveProjectTab" ) == 0 )

" Fonction : VM_SaveProjectTab
"
" But : Build the file used to save and then to restore the dev environment.
"
" Buffer : 
"
" Parametres :
"    filename - The filename where the complete workspace description had to be saved
"-------------------------------------------------------------------------------
function VM_SaveProjectTab( filename )
   let tabDefinition = VM_SaveWorkspace()

   execute "tabnew " . a:filename

   %delete _

   call append( 0, "let s:tabDescription = " . string( tabDefinition ) )
   call append( 1, "call VM_RestoreProjectTab( s:tabDescription )" )

   write
   quit

   call VM_RestoreTabSavePosition( tabDefinition )
endfunction

endif

if ( exists( "*VM_RestoreTabSavePosition" ) == 0 )

" Fonction : VM_RestoreTabSavePosition
"
" But : Goto the last available tab and window before the save action.
"
" Parametres :
"    tabDescription - The tab description to be restored
"-------------------------------------------------------------------------------
function VM_RestoreTabSavePosition( tabDescription )
   call VM_GotoTabFile( a:tabDescription.tabOrigin, a:tabDescription.winOrigin )
endfunction

endif

if ( exists( "*VM_AutoWorkspaceSave" ) == 0 )

" Fonction : VM_AutoWorkspaceSave
"
" But : Save the workspace when leaving VIM
"-------------------------------------------------------------------------------
function VM_AutoWorkspaceSave( ... )
   if ( a:0 > 0 )
      call VM_SaveProjectTab( a:1 )

      let g:VM_projectUsedWorkspace = a:1
   elseif ( g:VM_workspaceSave != 0 )
      call VM_SaveProjectTab( g:VM_workspaceFilename )
   endif
endfunction

endif

if ( exists( "*VM_AutoWorkspaceQuit" ) == 0 )

" Fonction : VM_AutoWorkspaceQuit
"
" But : Save the current workspace then quit.
"-------------------------------------------------------------------------------
function VM_AutoWorkspaceQuit( ... )
   if ( a:0 > 0 )
      call VM_AutoWorkspaceSave( a:1 )
   elseif ( exists( "g:VM_projectUsedWorkspace" ) != 0 )
      call VM_AutoWorkspaceSave( g:VM_projectUsedWorkspace )
      call VM_AutoWorkspaceSave()
   else
      call VM_AutoWorkspaceSave()
   endif

   call VM_ExecuteList( g:VM_workspaceQuitCmd )
endfunction

endif

if ( exists( "*VM_AutoWorkspaceLoad" ) == 0 )

" Fonction : VM_AutoWorkspaceLoad
"
" But : Load the workspace on command.
"-------------------------------------------------------------------------------
function VM_AutoWorkspaceLoad( ... )
   let loaded = 0

   if ( a:0 > 0 )
      if ( filereadable( expand( a:1 ) ) != 0 )
         1tabnext
         tabonly
         only

         execute "source " . a:1

         let g:VM_projectUsedWorkspace = a:1
         let loaded = 1
      endif
   elseif ( ( g:VM_workspaceSave != 0 )&&( filereadable( expand( g:VM_workspaceFilename ) ) != 0 ) )
      1tabnext
      tabonly
      only

      execute "source " . g:VM_workspaceFilename
      let loaded = 1
   endif

   return loaded
endfunction

endif

if ( exists( "*VM_AddDictionary" ) == 0 )

" Fonction : VM_AddDictionary
"
" But : Add the specified file to the dictionary list
"
" Parametres :
"    fileToAdd - The dictionary file to add
"-------------------------------------------------------------------------------
function VM_AddDictionary( fileToAdd )
   let current = &dictionary

   if ( current > "" )
      let current .= ","
   endif

   execute "setlocal dictionary=" . current . a:fileToAdd
endfunction

endif

if ( exists( "*VM_CleanDictionary" ) == 0 )

" Fonction : VM_CleanDictionary
"
" But : Reset the dictionary value
"-------------------------------------------------------------------------------
function VM_CleanDictionary()
   let current = g:VM_projectDictionary

   if ( exists( "g:VM_projectLocalDictionary" ) != 0 )
      let current = g:VM_projectLocalDictionary
   endif

   execute "setlocal dictionary=" . current
endfunction

endif

if ( exists( "*VM_StartDebug" ) == 0 )

" Fonction : VM_StartDebug
"
" But : Start a debug session
"-------------------------------------------------------------------------------
function VM_StartDebug()
   let debugProgram = ""

   if ( exists( "g:VM_listDebugPrograms" ) != 0 )
      let debugProgram = g:VM_listDebugPrograms[ g:VM_currentDebugProgram ]
   elseif ( exists( "g:VM_selectDebugPrograms" ) != 0 )
      let debugProgramList = split( system( g:VM_selectDebugPrograms ), "\n" )
      let debugChoiceList = []
      let indexChoice = 0
      for prgName in debugProgramList
         call add( debugChoiceList, indexChoice . " > " . prgName )
         let indexChoice += 1
      endfor " End FOR all the debug program

      let entryList = inputlist( debugChoiceList )

      if ( ( entryList >= 0 )&&( entryList < indexChoice ) )
         let debugProgram = debugProgramList[ entryList ]
      endif " End IF a valid program to debug had been made
   endif

   if ( debugProgram > "" )
      tabnew
      execute "TermdebugCommand " . debugProgram
      1 wincmd w
      quit
      wincmd L
      execute g:VM_sizeOutputWindow . " wincmd >"
      wincmd h
      let b:VM_debugStart = 1
      let g:VM_debugModeActive = 1
      tmap <buffer> <silent> <F4> run<CR>
      tmap <buffer> <silent> <S-F4> <C-C>
      tmap <buffer> <silent> <C-F4> <C-\><C-N>:Source<CR>
      tmap <buffer> <silent> <F9> next<CR>
      tmap <buffer> <silent> <S-F9> step<CR>
      tmap <buffer> <silent> <C-F9> continue<CR>
   endif " End IF the program to debug had been selected
endfunction

endif

if ( exists( "*VM_SelectDebug" ) == 0 )

" Fonction : VM_SelectDebug
"
" But : Select the program to use for the debug session
"-------------------------------------------------------------------------------
function VM_SelectDebug()
   if ( exists( "g:VM_listDebugPrograms" ) != 0 )
      let listPrograms = []
      let indexProgram = 0
      for program in g:VM_listDebugPrograms
         if ( indexProgram == g:VM_currentDebugProgram )
            call add( listPrograms, indexProgram . " > ((" . program . "))" )
         else
            call add( listPrograms, indexProgram . " > [" . program . "]" )
         endif
         let indexProgram += 1
      endfor

      let programNumber = inputlist( listPrograms )

      if ( ( programNumber >= 0 ) && ( programNumber < indexProgram ) )
        let g:VM_currentDebugProgram = programNumber
      endif " End IF the program selected is the correct one
   endif
endfunction

endif

if ( exists( "*VM_CloseTerminal" ) == 0 )

" Fonction : VM_CloseTerminal
"
" But : Signal the end of the use of the terminal.
"-------------------------------------------------------------------------------
function VM_CloseTerminal()
   if ( exists( "b:VM_debugStart" ) != 0 )
      unlet g:VM_debugModeActive
   endif
   if ( exists( "g:VM_debugModeActive" ) != 0 )
      unlet g:VM_debugModeActive
   endif
endfunction

endif

if ( exists( "g:VM_sizeOutputWindow" ) == 0 )
  let g:VM_sizeOutputWindow = 64
endif

command Debug call VM_StartDebug()
command SelectDebug call VM_SelectDebug()

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Setting the variable defaults
"------------------------------
if ( exists( "g:VM_projectTagName" ) == 0 )
   let g:VM_projectTagName = "tags"
endif

if ( exists( "g:VM_projectBaseFolder" ) == 0 )
   let g:VM_projectBaseFolder = "~/PROJECTS"
endif

if ( exists( "g:VM_projectFileDefinition" ) == 0 )
   let g:VM_projectFileDefinition = "~/.vm_project_def"
endif

if ( exists( "g:VM_projectMkDir" ) == 0 )
   let g:VM_projectMkDir = "mkdir"
endif

if ( exists( "g:VM_projectDirSeparator" ) == 0 )
   let g:VM_projectDirSeparator = "/"
endif

if ( exists( "g:VM_projectMainFolder" ) == 0 )
   let g:VM_projectMainFolder = "~/.local/share/nvim/IDE/PROJECT"
endif

if ( exists( "g:VM_projectDirReference" ) == 0 )
   let g:VM_projectDirReference = g:VM_projectMainFolder . "/REFERENCES"
endif

if ( exists( "g:VM_projectDirComments" ) == 0 )
   let g:VM_projectDirComments = g:VM_projectMainFolder . "/COMMENTS"
endif

if ( exists( "g:VM_projectDirAlternate" ) == 0 )
   let g:VM_projectDirAlternate = g:VM_projectMainFolder . "/FUNCTIONS"
endif

if ( exists( "g:VM_projectDirLeaveFile" ) == 0 )
   let g:VM_projectDirLeaveFile = g:VM_projectMainFolder . "/LEAVING"
endif

if ( exists( "g:VM_projectDirEnterFile" ) == 0 )
   let g:VM_projectDirEnterFile = g:VM_projectMainFolder . "/ENTERING"
endif

if ( exists( "g:VM_projectDirDictionary" ) == 0 )
   let g:VM_projectDirDictionary = g:VM_projectMainFolder . "/DICTIONARY"
endif

if ( exists( "g:VM_projectDictionary" ) == 0 )
   let g:VM_projectDictionary = ""
endif

if ( exists( "g:VM_projectDirInit" ) == 0 )
   let g:VM_projectDirInit = g:VM_projectMainFolder . "/INIT"
endif

if ( exists( "g:VM_projectDirShell" ) == 0 )
   let g:VM_projectDirShell = "~/.vim/SHELL"
endif

if ( exists( "g:VM_projectDirClasses" ) == 0 )
   let g:VM_projectDirClasses = g:VM_projectMainFolder . "/CLASSES"
endif

if ( exists( "g:VM_projectCompletionFile" ) == 0 )
   let g:VM_projectCompletionFile = g:VM_projectMainFolder . "/COMPLETION"
endif

if ( exists( "g:VM_projectDirTagsLanguage" ) == 0 )
   let g:VM_projectDirTagsLanguage = g:VM_projectMainFolder . "/TAGS_LANGUAGE"
endif

if ( exists( "g:VM_projectIndentation" ) == 0 )
   let g:VM_projectIndentation = "	"
endif

if ( exists( "g:SQL_projectIndentation" ) == 0 )
   let g:SQL_projectIndentation = "	"
endif

if ( exists( "g:VM_projectCTags" ) == 0 )
   let g:VM_projectCTags = "ctags --fields=+l --langmap=SQL:+.TAB.PRC --c-kinds=+p --c++-kinds=+p --extra=+q -R"
endif

if ( exists( "g:VM_projectDBExtension" ) == 0 )
   let g:VM_projectDBExtension = "sql"
endif

if ( exists( "g:VM_pathBuildBase" ) == 0 )
   let g:VM_pathBuildBase = ""
endif

if ( exists( "g:VM_beforePath" ) == 0 )
   let g:VM_beforePath = ""
endif

if ( exists( "g:VM_finalPath" ) == 0 )
   let g:VM_finalPath = ""
endif

if ( exists( "g:VM_ctagsFolders" ) == 0 )
   let g:VM_ctagsFolders = ""
endif

if ( exists( "g:VM_listCmdPathBuild" ) == 0 )
   let g:VM_listCmdPathBuild = ["let s:dirList = split( system( \"ls -R\" . g:VM_pathBuildBase ), expand( \"<CR>\" ) )", "call filter( s:dirList, 'v:val =~ \":\"' )", "call filter( s:dirList, 'v:val !~ \"\\\\.[a-zA-Z]\\\\+\"' )", "let g:VM_globalPath = substitute( substitute( substitute( substitute( join( s:dirList ), \"\\\\\", \"/\", \"g\" ), \": \", \",\", \"g\" ), \":$\", \"\", \"\" ), \"\\\\./\", \"\", \"g\" )"]
endif

if ( exists( "g:VM_projectListDirStart" ) == 0 )
   let g:VM_projectListDirStart = "ls -l "
endif

if ( exists( "g:VM_projectListDirEnd" ) == 0 )
   let g:VM_projectListDirEnd = " | grep \"^d\""
endif

if ( exists( "g:VM_projectListFileEnd" ) == 0 )
   let g:VM_projectListFileEnd = " | grep \"^-\""
endif

if ( exists( "g:VM_distantListDirStart" ) == 0 )
   let g:VM_distantListDirStart = "ls -l "
endif

if ( exists( "g:VM_distantListDirEnd" ) == 0 )
   let g:VM_distantListDirEnd = "' | grep \"^d\""
endif

if ( exists( "g:VM_projectBaseProjects" ) == 0 )
   let g:VM_projectBaseProjects = "~/PROJECTS"
endif

if ( exists( "g:VM_extractProjectNameBegin" ) == 0 )
   let g:VM_extractProjectNameBegin = "^[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+[^ ]\\+ \\+"
endif

if ( exists( "g:VM_extractProjectNameEnd" ) == 0 )
   let g:VM_extractProjectNameEnd = ""
endif

if ( exists( "g:VM_distantMachineName" ) == 0 )
   let g:VM_distantMachineName = "thrash"
endif

if ( exists( "g:VM_distantUserName" ) == 0 )
   let g:VM_distantUserName = "anonymous"
endif

if ( exists( "g:VM_distantFolderBase" ) == 0 )
   let g:VM_distantFolderBase = "/home/ARCHIVE/"
endif

if ( exists( "g:VM_projectGlobalCreation" ) == 0 )
   let g:VM_projectGlobalCreation = ["echo system( \"ssh \" . g:VM_distantMachineName . \" git init --bare \" . g:VM_distantFolderBase . projectName )", "echo system( \"cd \" . g:VM_projectBaseProjects . \" & git clone ssh://\" . g:VM_distantUserName . \"@\" . g:VM_distantMachineName . g:VM_distantFolderBase . s:projectName )"]
endif

if ( exists( "g:VM_bufferKeepAttribute" ) == 0 )
   let g:VM_bufferKeepAttribute = "ext"
endif

if ( exists( "g:VM_bufferRejectAttribute" ) == 0 )
   let g:VM_bufferRejectAttribute = ""
endif

if ( exists( "g:VM_bufferListKeep" ) == 0 )
   let g:VM_bufferListKeep = []
endif

if ( exists( "g:VM_bufferListReject" ) == 0 )
   let g:VM_bufferListReject = []
endif

if ( exists( "g:VM_bufferSortAttribute" ) == 0 )
   let g:VM_bufferSortAttribute = "file"
endif

if ( exists( "g:VM_projectSizeBufferName" ) == 0 )
   let g:VM_projectSizeBufferName = 64
endif

if ( exists( "g:VM_classesDisplayToOpen" ) == 0 )
   let g:VM_classesDisplayToOpen = g:VM_projectMainFolder . "/CLASSES_OPEN"
endif

if ( exists( "g:VM_classOpenDefault" ) == 0 )
   let g:VM_classOpenDefault = "vsplit"
endif

if ( exists( "g:VM_classesTabAutoClose" ) == 0 )
   let g:VM_classesTabAutoClose = 0
endif

if ( exists( "g:VM_forbidTabNumber" ) == 0 )
   let g:VM_forbidTabNumber = 1
endif

if ( exists( "g:VM_largeFileLimit" ) == 0 )
   let g:VM_largeFileLimit = 0
endif

if ( exists( "g:VM_largeFileReloadAction" ) == 0 )
   let g:VM_largeFileReloadAction = "echo \"File changed ...\""
endif

if ( exists( "g:VM_listProjectFolders" ) == 0 )
   let g:VM_listProjectFolders = [{"folder":"ANALYZER", "fileIntro":"anlz"},{"folder":"BASE", "fileIntro":"base"},{"folder":"BUILDER", "fileIntro":"bldr"},{"folder":"COMMAND", "fileIntro":"cmd"},{"folder":"DATA", "fileIntro":"data"},{"folder":"DESCRIPTION", "fileIntro":"desc"},{"folder":"EXCEPTION", "fileIntro":"excp"},{"folder":"FACTORY", "fileIntro":"fact"},{"folder":"FUNCTIONS", "fileIntro":"fct"}, {"folder":"HEAP", "fileIntro":"heap"}, {"folder":"INTERFACE", "fileIntro":"int"}, {"folder":"IO_OBJECTS", "fileIntro":"io"}, {"folder":"ITERATOR", "fileIntro":"iter"}, {"folder":"MESSAGE", "fileIntro":"msg"}, {"folder":"POOL", "fileIntro":"pool"}, {"folder":"SORTER", "fileIntro":"sort"}, {"folder":"STREAM", "fileIntro":"stream"}, {"folder":"SYSTEM", "fileIntro":"sys"}, {"folder":"TEST", "fileIntro":"tst"}, {"folder":"UTILS", "fileIntro":"util"}]
endif

if ( exists( "g:VM_workspaceSave" ) == 0 )
   let g:VM_workspaceSave = 1
endif

if ( exists( "g:VM_workspaceFilename" ) == 0 )
   let g:VM_workspaceFilename = ".workspace"
endif

if ( exists( "g:VM_projectShellExecute" ) == 0 )
   let g:VM_projectShellExecute = "$SHELL --login -c"
endif

if ( exists( "g:VM_workspaceQuitCmd" ) == 0 )
   let g:VM_workspaceQuitCmd = [ "quitall" ]
endif

if ( exists( "g:VM_projectShiftEnter" ) == 0 )
   let g:VM_projectShiftEnter = "<S-CR>"
endif

if ( exists( "g:VM_projectCtrlEnter" ) == 0 )
   let g:VM_projectCtrlEnter = "<C-^>"
endif

if ( exists( "g:VM_tabIntro" ) == 0 )
   redir => lstTabs
   silent tabs
   redir END
   let g:VM_tabIntro = substitute( split( lstTabs, '\n' )[ 0 ], " \\+[0-9]\\+", "", "" )
   unlet lstTabs
endif

" Setting the auto commands
"--------------------------
autocmd BufReadPre * call VM_DetermineFileSize( expand( "<afile>" ) )
autocmd BufReadPost * call VM_DeterminePostFileSize()
autocmd BufEnter * call VM_ProjectEnterFile()
autocmd BufLeave * call VM_ProjectLeaveFile()
" autocmd TerminalWinopen * call VM_ProjectExecuteEnteringFile( "terminal" )

" Setting the commands
"---------------------
command! -nargs=? -complete=file Q call VM_AutoWorkspaceQuit( <f-args> )
command! -nargs=? -complete=file W call VM_AutoWorkspaceSave( <f-args> )
command! -nargs=? -complete=file L call VM_AutoWorkspaceLoad( <f-args> )

"---< Fin de fichier >----------------------------------------------------------

