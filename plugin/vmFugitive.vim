" Fichier : vmFugitive.vim
"
" But : The branch management that is not in fugitive.
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 14 Aug 2017
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_BuildIntroBranch" ) == 0 )

" Fonction : VM_BuildIntroBranch
"
" But : Build the intro associated to the branch
"
" Parametres :
"     currentBranch - The current branch definition
" Retour :
"     The intro to use to display the branch name
"-------------------------------------------------------------------------------
function VM_BuildIntroBranch( currentBranch )
   if ( a:currentBranch.isCurrent != 0 )
      let intro = "> "
   else
      let intro = "  "
   endif

   return intro . a:currentBranch.name
endfunction

endif

if ( exists( "*VM_DisplayBranches" ) == 0 )

" Fonction : VM_DisplayBranches
"
" But : Display the branches list in the buffer
"
" Parametres :
"     currentBranch - The current branch definition
"-------------------------------------------------------------------------------
function VM_DisplayBranches( currentBranch )
   if ( a:currentBranch.comment > "" )
      let comment = g:VM_gitCommentSeparator . a:currentBranch.comment
   else
      let comment = ""
   endif

   call append( line( "$" ), VM_BuildIntroBranch( a:currentBranch ) . comment )
endfunction

endif

if ( exists( "*VM_GetIntroBranchFile" ) == 0 )

" Fonction : VM_GetIntroBranchFile
"
" But : Get the intro for the branch linked files
"
" Parametres :
"     branchName - The branch name to be converted
"-------------------------------------------------------------------------------
function VM_GetIntroBranchFile( branchName )
   if ( g:VM_baseWorkspace > "" )
      let intro = g:VM_baseWorkspace . "/"
   else
      let intro = ""
   endif

   return intro . substitute( tolower( a:branchName ), "[ /\\\\#\\.;,:!]", "_", "g" )
endfunction

endif

if ( exists( "*VM_GetBranchWorkspace" ) == 0 )

" Fonction : VM_GetBranchWorkspace
"
" But : Convert the branch name in the workspace filename.
"
" Parametres :
"     branchName - The branch name to be converted
"-------------------------------------------------------------------------------
function VM_GetBranchWorkspace( branchName )
   return VM_GetIntroBranchFile( a:branchName ) . ".workspace"
endfunction

endif

if ( exists( "*VM_GetBranchComment" ) == 0 )

" Fonction : VM_GetBranchComment
"
" But : Get the comment filename associated to the branch
"
" Parametres :
"     branchName - The branch name to be converted
"-------------------------------------------------------------------------------
function VM_GetBranchComment( branchName )
   return VM_GetIntroBranchFile( a:branchName ) . ".txt"
endfunction

endif

if ( exists( "*VM_BuildBranchList" ) == 0 )

" Fonction : VM_BuildBranchList
"
" But : Build the complete branch list definition
"
" Parametres :
"     commandList - The branch list returned by the command call
" Retour :
"     The branch list objects
"-------------------------------------------------------------------------------
function VM_BuildBranchList( commandList )
   let branchesList = []
   for currentBranch in a:commandList
      let branch = {}
      let branch.name = strpart( currentBranch, 2 )
      let branch.isCurrent = ( strpart( currentBranch, 0, 1 ) != " " )
      let branch.isModified = 0

      let branchCommentFile = VM_GetBranchComment( branch.name )

      if ( filereadable( branchCommentFile ) != 0 )
         let branch.comment = join( readfile( branchCommentFile ), " " )
      else
         let branch.comment = ""
      endif

      if ( branch.isCurrent != 0 )
         let s:activeIndex = len( branchesList )
      endif

      call add( branchesList, branch )
   endfor

   return branchesList
endfunction

endif

if ( exists( "*VM_GitBranchSelect" ) == 0 )

" Fonction : VM_GitBranchSelect
"
" But : Select the git branch between all the available branches.
"
" Parametres :
"     updateBaseFolder - 0 to keep the current folder, another value to move to the current file folder
"-------------------------------------------------------------------------------
function VM_GitBranchSelect( updateBaseFolder )
   if ( a:updateBaseFolder != 0 )
      let localFolder = expand( "%:h" )
   else
      let localFolder = ""
   endif

   if ( localFolder > "" )
      execute "cd " . localFolder
   endif

   let branchList = split( system( g:VM_gitBranches ), "\n" )

   if ( localFolder > "" )
      cd -
   endif

   if ( len( branchList ) == 0 )
      echo "No branches found.\n"
   elseif ( ( len( branchList ) == 1 ) && ( substitute( branchList[ 0 ], g:VM_gitErrorIntro, "", "" ) != branchList[ 0 ] ) )
      echo "GIT error : " . branchList[ 0 ] . "\n"
   else
      let branchesList = VM_BuildBranchList( branchList )

      if ( ( g:VM_gitWorkspaceAutoSave != 0 ) || ( input( "Save branch workspace ( Y to save it ) : " ) == "Y" ) )
         call VM_AutoWorkspaceSave( VM_GetBranchWorkspace( branchesList[ s:activeIndex ].name ) )
      endif

      call VM_RemindsOriginalWindow()

      call VM_DisplayInternalWindow( "[Branches]", "botright 10 sview", "VM_git_branches", branchesList, "VM_DisplayBranches" )

      let b:branches = branchesList
      let b:folder = localFolder
      execute s:activeIndex + 1

      if ( localFolder > "" )
         execute "cd " . localFolder
      endif
   endif
endfunction

endif

if ( exists( "*VM_GitListRemoteBranches" ) == 0 )

" Fonction : VM_GitListRemoteBranches
"
" But : List all the remote branches
"-------------------------------------------------------------------------------
function VM_GitListRemoteBranches()
   return split( system( g:VM_gitListRemoteBranch ), "\n" )
endfunction

endif

if ( exists( "*VM_CloseBranchWindow" ) == 0 )

" Fonction : VM_CloseBranchWindow
"
" But : Close the branch window
"
" Parametres :
"     forced - 0 to ask before saving updates, another value otherwise
"-------------------------------------------------------------------------------
function VM_CloseBranchWindow( forced )
   let lineNumber = 1

   for currentBranch in b:branches
      let startLine = VM_BuildIntroBranch( currentBranch )
      let currentLine = getline( lineNumber )
      let commentEliminate = substitute( currentLine, startLine, "", "" )

      if ( commentEliminate == currentLine )
         echo "Branch " . currentBranch.name . " line value is not correct, value ignored : " . currentLine . " instead of " . startLine . ".\n"
      elseif ( commentEliminate == "" )
         if ( currentBranch.comment > "" )
            let currentBranch.comment = ""
            let currentBranch.isModified = 1
         endif
      else
         let commentEliminate = substitute( commentEliminate, "^ *:* *", "", "" )

         if ( currentBranch.comment != commentEliminate )
            let currentBranch.comment = commentEliminate
            let currentBranch.isModified = 1
         endif
      endif

      let lineNumber += 1
   endfor

   call VM_SaveBranches( a:forced )
   set nomodified
   close
endfunction

endif

if ( exists( "*VM_UseBranch" ) == 0 )

" Fonction : VM_UseBranch
"
" But : Signal the branch to be used
"
" Parametres :
"     indexBranch - The index of the branch to be used
"     forced - 0 to ask before saving updates, another value otherwise
"-------------------------------------------------------------------------------
function VM_UseBranch( indexBranch, forced )
   let localBranch = b:branches[ a:indexBranch ]

   call VM_CloseBranchWindow( a:forced )

   if ( localBranch.isCurrent != 0 )
      call VM_BackToOriginalWindow()
   else
      let response = system( g:VM_gitUseBranch . " " . localBranch.name )

      if ( substitute( substitute( response, "\n$", "", "" ), ".*\n", "", "" ) == "Aborting" )
         echo response . "*** Branch switch canceled ****\n"
      else
         call VM_SwitchBranch( localBranch.name )

         if ( ( g:VM_gitWorkspaceAutoLoad != 0 ) || ( input( "Loading branch workspace ( Y to load ) : " ) == "Y" ) )
            call VM_AutoWorkspaceLoad( g:VM_workspaceFilename )
         endif
      endif
   endif
endfunction

endif

if ( exists( "*VM_UpdateBranch" ) == 0 )

" Fonction : VM_UpdateBranch
"
" But : Update the comment of the specified branch
"
" Parametres :
"     lineNumber - The line number in the current branch buffer
"-------------------------------------------------------------------------------
function VM_UpdateBranch( lineNumber )
   let completeLine = getline( a:lineNumber )
   let commentLine = substitute( completeLine, "^[^:]\\+:: \\+", "", "" )

   if ( commentLine != completeLine )
      let currentBranch = b:branches[ a:lineNumber - 1 ]

      let currentBranch.isModified = 1
      let currentBranch.comment = commentLine
   elseif ( substitute( completeLine, "[ >] [^ ]\\+ *$", "", "" ) == "" )
      let currentBranch = b:branches[ a:lineNumber - 1 ]

      let currentBranch.isModified = 1
      let currentBranch.comment = ""
   endif
endfunction

endif

if ( exists( "*VM_DeleteBranch" ) == 0 )

" Fonction : VM_DeleteBranch
"
" But : Delete the specified branch
"
" Parametres :
"     lineNumber - The line number for the specified branch
"     forced - 0 to delete the branch in a normal way, another value to force the deletion
"-------------------------------------------------------------------------------
function VM_DeleteBranch( lineNumber, forced )
   let deleteBranch = b:branches[ a:lineNumber - 1 ]

   if ( deleteBranch.isCurrent == 0 )
      if ( a:forced == 0 )
         let executeResult = system( g:VM_gitDeleteBranch . " " . deleteBranch.name )
      else
         let executeResult = system( g:VM_gitForceDeleteBranch . " " . deleteBranch.name )
      endif

      echo executeResult . "\n"

      if ( substitute( executeResult, g:VM_gitDeleteError, "", "" ) == executeResult )
         execute a:lineNumber . " delete"
         call remove( b:branches, a:lineNumber - 1 )

         let fileToDelete = VM_GetBranchWorkspace( deleteBranch.name )

         if ( filewritable( fileToDelete ) == 1 )
            call delete( fileToDelete )
         endif

         let fileToDelete = VM_GetBranchComment( deleteBranch.name )

         if ( filewritable( fileToDelete ) == 1 )
            call delete( fileToDelete )
         endif

         if ( ( exists( "g:VM_fugitiveDeleteBranch" ) != 0 )&&( exists( "*" . g:VM_fugitiveDeleteBranch ) != 0 ) )
           execute "call " . g:VM_fugitiveDeleteBranch . "( deleteBranch.name )"
         endif
      endif
   else
      echo "Unable to delete the active branch.\n"
   endif
endfunction

endif

if ( exists( "*VM_SaveBranches" ) == 0 )

" Fonction : VM_SaveBranches
"
" But : Save the comments of the branch in files
"
" Parametres :
"     forced - 0 to ask before saving updates, another value otherwise
"-------------------------------------------------------------------------------
function VM_SaveBranches( forced )
   let toBeSaved = 0

   for currentBranch in b:branches
      let toBeSaved += currentBranch.isModified
   endfor

   if ( ( toBeSaved != 0 ) && ( ( a:forced != 0 ) || ( input( "Save branches comments ( Y to save ) : " ) == "Y" ) ) )
      for currentBranch in b:branches
         if ( currentBranch.isModified != 0 )
            let saveFile = VM_GetBranchComment( currentBranch.name )

            if ( ( filewritable( saveFile ) == 1 ) || ( filewritable( substitute( saveFile, "\/[^/]*$", "", "" ) ) == 2 ) )
               if ( currentBranch.comment == "" )
                  call delete( saveFile )

                  let currentBranch.isModified = 0
                  let toBeSaved -= 1
               else
                  let fileContent = []
                  call add( fileContent, currentBranch.comment )

                  call writefile( fileContent, saveFile )

                  let currentBranch.isModified = 0
                  let toBeSaved -= 1
               endif
            else
               echo "Unable to save the comment for branch " . currentBranch.name . "\n"
            endif
         endif
      endfor
   endif

   if ( toBeSaved == 0 )
      set nomodified
   endif
endfunction

endif

if ( exists( "*VM_ValidateBranchUpdate" ) == 0 )

" Fonction : VM_ValidateBranchUpdate
"
" But : Validate the update done on the branch definition
"-------------------------------------------------------------------------------
function VM_ValidateBranchUpdate()
   if ( line( "$" ) != len( b:branches ) )
      undo
      echo "Line number is no more valid, undo the changes.\n"
   else
      let currentBranch = b:branches[ line( "." ) - 1 ]
      let startLine = VM_BuildIntroBranch( currentBranch )
      let lineNumber = line( "." )
      let currentLine = getline( lineNumber )
      let commentEliminate = substitute( currentLine, startLine, "", "" )

      if ( commentEliminate == currentLine )
         undo
         echo "The begining of the line should not been updated.\n"
      elseif ( commentEliminate == "" )
         call VM_UpdateBranch( lineNumber )
      elseif ( substitute( currentLine, startLine . g:VM_gitCommentSeparator, "", "" ) == currentLine )
         echo "The comment separator is not well formatted, the line had been updated.\n"
         call setline( lineNumber, substitute( currentLine, startLine . " *", startLine . g:VM_gitCommentSeparator, "" ) )
         call VM_UpdateBranch( lineNumber )
      else
         call setline( lineNumber, substitute( currentLine, startLine . g:VM_gitCommentSeparator . "*", startLine . g:VM_gitCommentSeparator, "" ) )
         call VM_UpdateBranch( lineNumber )
      endif
   endif
endfunction

endif

if ( exists( "*VM_ExecBranchCreation" ) == 0 )

" Fonction : VM_ExecBranchCreation
"
" But : Create the GIT branch
"
" Parametres :
"     currentBranch - The branch definition to create
" Retour :
"     0 if everything went ok, another value otherwise
"-------------------------------------------------------------------------------
function VM_ExecBranchCreation( currentBranch )
   if ( exists( "a:currentBranch.origin" ) == 0 )
      let execReturn = system( g:VM_gitCreateBranch . " " . a:currentBranch.name . " " . g:VM_gitTrackBranch )
   else " End IF there is no existing branch
      let execReturn = system( g:VM_gitCreateBranch . " " . a:currentBranch.name . " " . a:currentBranch.origin . " " . g:VM_gitTrackBranch )
   endif " End IF there is a remote branch to be linked to

   echo execReturn

   return ( substitute( execReturn, g:VM_gitErrorIntro, "", "" ) != execReturn )
endfunction

endif

if ( exists( "*VM_CreateBranch" ) == 0 )

" Fonction : VM_CreateBranch
"
" But : Create a new branch
"
" Parametres :
"     forced - 0 to ask before saving updates, another value otherwise
"     linkToExistimg - 0 to create a local branch, annother value to link it to an existing remote branch
"-------------------------------------------------------------------------------
function VM_CreateBranch( forced, linkToExisting )
   let newBranch = {}

   if ( a:linkToExisting == 0 )
      let newBranch.name = input( "Branch name : " )
   else " End IF we want to create a local branch
      let listBranch = VM_GitListRemoteBranches()
      let displayBranch = [ "Remote branches :" ]
      let branchNum = 1

      for currentBranchName in listBranch
         call add( displayBranch, branchNum . currentBranchName )

         let branchNum += 1
      endfor " End FOR all the branches name

      let response = inputlist( displayBranch )

      let newBranch.name = ""

      if ( ( response > 0 ) && response <= len( listBranch ) )
         let newBranch.origin = listBranch[ response - 1 ]
         let newBranch.name = substitute( newBranch.origin, "[^/]*/", "", "" )
      endif " End IF we select a valid index in the branch list
   endif " End IF we want to be linked to an existing remote branch

   if ( newBranch.name > "" )
      let newBranch.comment = input( "Branch comment : " )
      let newBranch.isModified = ( newBranch.comment > "" )
      let newBranch.isCurrent = 0

      if ( ( input( "Branch [" . newBranch.name . "] to create ( Y to create ) : " ) == "Y" ) && ( VM_ExecBranchCreation( newBranch ) == 0 ) )
         call insert( b:branches, newBranch, 0 )
         " call VM_UseBranch( 0, a:forced )
         " call VM_CloseBranchWindow( a:forced )
         call VM_SaveBranches( a:forced )
         set nomodified
         call VM_SwitchBranch( newBranch.name )
         close
      else
         echo "Unable to create the branch " . newBranch.name . "\n"
      endif
   endif
endfunction

endif

if ( exists( "*VM_GetCurrentBranchName" ) == 0 )

" Fonction : VM_GetCurrentBranchName
"
" But : Get the current branch name
"
" Retour :
"     The current branch name
"-------------------------------------------------------------------------------
function VM_GetCurrentBranchName()
   return fugitive#head()
endfunction

endif

if ( exists( "*VM_SwitchBranch" ) == 0 )

" Fonction : VM_SwitchBranch
"
" But : The function executed when switching to a new branch.
"
" Parametres :
"    branchName - The name of the new branch to use
"-------------------------------------------------------------------------------
function VM_SwitchBranch( branchName )
   let g:VM_workspaceFilename = VM_GetBranchWorkspace( a:branchName )

   if ( ( exists( "g:VM_fugitiveSwitchBranch" ) != 0 )&&( exists( "*" . g:VM_fugitiveSwitchBranch ) != 0 ) )
     execute "call " . g:VM_fugitiveSwitchBranch . "( a:branchName )"
   endif
endfunction

endif

if ( exists( "*VM_SwitchBranchTag" ) == 0 )

" Fonction : VM_SwitchBranchTag
"
" But : Update the tag name
"
" Parametres :
"    branchName - The branch name to switch to
"-------------------------------------------------------------------------------
function VM_SwitchBranchTag( branchName )
   let g:VM_projectTagName = VM_ComputeTagFilename( a:branchName )

   call VM_ResetTagName()
endfunction

endif

if ( exists( "*VM_DeleteBranchTag" ) == 0 )

" Fonction : VM_DeleteBranchTag
"
" But : Delete the tag file
"
" Parametres :
"    branchName - The branch to be deleted
"-------------------------------------------------------------------------------
function VM_DeleteBranchTag( branchName )
   let fileToDelete = g:VM_baseWorkspace . "/" . VM_ComputeTagFilename( a:branchName )

   if ( filewritable( fileToDelete ) == 1 )
      call delete( fileToDelete )
   endif
endfunction

endif

if ( exists( "*VM_ComputeTagFilename" ) == 0 )

" Fonction : VM_ComputeTagFilename
"
" But : Convert the branch name into a tag name
"
" Parametres :
"    branchName - The branch to be deleted
" Retour :
"    The tag filename to use
"-------------------------------------------------------------------------------
function VM_ComputeTagFilename( branchName )
   return "tags-" . substitute( a:branchName, "/", "_", "g" )
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "g:VM_gitBranches" ) == 0 )
   let g:VM_gitBranches = "git branch"
endif

if ( exists( "g:VM_gitUseBranch" ) == 0 )
   let g:VM_gitUseBranch = "git checkout"
endif

if ( exists( "g:VM_gitDeleteBranch" ) == 0 )
   let g:VM_gitDeleteBranch = "git branch -d"
endif

if ( exists( "g:VM_gitForceDeleteBranch" ) == 0 )
   let g:VM_gitForceDeleteBranch = "git branch -D"
endif

if ( exists( "g:VM_gitCreateBranch" ) == 0 )
   let g:VM_gitCreateBranch = "git checkout -b"
endif

if ( exists( "g:VM_gitTrackBranch" ) == 0 )
   let g:VM_gitTrackBranch = "--track"
endif

if ( exists( "g:VM_gitErrorIntro" ) == 0 )
   let g:VM_gitErrorIntro = "^fatal:"
endif

if ( exists( "g:VM_baseWorkspace" ) == 0 )
   let g:VM_baseWorkspace = ""
endif

if ( exists( "g:VM_gitDeleteError" ) == 0 )
   let g:VM_gitDeleteError = "^error:"
endif

if ( exists( "g:VM_gitCommentSeparator" ) == 0 )
   let g:VM_gitCommentSeparator = " :: "
endif

if ( exists( "g:VM_gitWorkspaceAutoSave" ) == 0 )
   let g:VM_gitWorkspaceAutoSave = 0
endif

if ( exists( "g:VM_gitWorkspaceAutoLoad" ) == 0 )
   let g:VM_gitWorkspaceAutoLoad = 1
endif

if ( exists( "g:VM_gitListRemoteBranch" ) == 0 )
   let g:VM_gitListRemoteBranch = "git branch -r"
endif

"---< Fin de fichier >----------------------------------------------------------

