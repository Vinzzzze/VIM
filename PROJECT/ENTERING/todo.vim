" Fichier : todo.vim
"
" But : Définition des settings des fichiers de syntaxe todo
"
" Auteur : Vini "Cool Coyote"
" Date : 10 Sep 2013
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*TD_StartTaskDev" ) == 0 )

" Fonction : TD_StartTaskDev
"
" But : Signal the start of the task development.
"-------------------------------------------------------------------------------
function TD_StartTaskDev()
   let numLine = search( "^Author : " )
   call append( numLine, "Started : " . strftime( "%d %b %Y" ) )
   call append( numLine + 1, "Executor : " . $USER_NAME )
endfunction

endif

if ( exists( "*TD_EndTaskDev" ) == 0 )

" Fonction : TD_EndTaskDev
"
" But : Signal the end of a task
"-------------------------------------------------------------------------------
function TD_EndTaskDev()
   let numLine = search( "^Executor : " )
   call append( numLine, "Terminated : " . strftime( "%d %b %Y" ) )
endfunction

endif

if ( exists( "*TD_DeleteTask" ) == 0 )

" Fonction : TD_DeleteTask
"
" But : Delete the current task
"-------------------------------------------------------------------------------
function TD_DeleteTask()
   let endLineSearched = "^" . substitute( substitute( getline( "." ), "< .*", "<>", "" ), "\\*", "\\\\*", "g" )
   execute ",/" . endLineSearched . "/ delete"
endfunction

endif

if ( exists( "*TD_AddTaskParagraph" ) == 0 )

" Fonction : TD_AddTaskParagraph
"
" But : Add a paragraph to the current task.
"-------------------------------------------------------------------------------
function TD_AddTaskParagraph()
   let paragraph = input( "Paragraph type ( Summary|Subject|Technical ) : " )
   echo "\n"
   let text = input( "Text : " )
   echo "\n"
   let valid = input( "Valid ( Y or N ) : " )
   echo "\n"

   if ( valid == "Y" )
      let numLine = search( "^" . substitute( substitute( getline( "." ), "< .*", "<>", "" ), "\\*", "\\\\*", "g" ) )

      call append( numLine - 1, "" )
      call append( numLine, "" )
      call append( numLine, paragraph )
      call VM_PrintLimitedLengthLine( g:VM_todoIndentation, g:VM_todoIndentation, numLine + 2, text, 87 )
   endif
endfunction

endif

if ( exists( "*TD_TodoFoldLevel" ) == 0 )

" Fonction : TD_TodoFoldLevel
"
" But : Determine if we are entering/leaving a folder.
"
" Parametres :
"     The line analyzed
" Retour :
"     Fold expression ( cf help folder )
"-------------------------------------------------------------------------------
function TD_TodoFoldLevel( lineNumber )
   let retValue = "="
   let currentLine = getline( a:lineNumber )

   if ( match( currentLine, "^\\*[+-][+-]< .* >[+-]\\+$" ) > -1 )
      let retValue = "a1"
   elseif ( match( currentLine, "^\\*[+-][+-]<>[+-]\\+$" ) > -1 )
      let retValue = "s1"
   endif

   return retValue
endfunction

endif

if ( exists( "*TD_TodoFoldText" ) == 0 )

" Fonction : TD_TodoFoldText
"
" But : Print the line displayed on a closed folder.
"
" Retour :
"     Line to print
"-------------------------------------------------------------------------------
function TD_TodoFoldText()
   let currentLine = getline( v:foldstart )
   let textFold = strpart( currentLine, 1, 2 ) . " " . substitute( substitute( currentLine, "^\\*[+-][+-]< ", "", "" ), " >[-+]\\+", "", "" )
   let baseString = strpart( "\----------------------------------------------------------------", 0, ( foldlevel( v:foldstart ) * 3 ) ) . "< "

   return baseString . textFold . " >"
endfunction

endif

if ( exists( "*TD_OpenFileTask" ) == 0 )

" Fonction : TD_OpenFileTask
"
" But : Open the specified files with the given name and class definition.
"
" Buffer : 
"
" Parametres :
"     fileName - The filename under the following format : #file without extention#[class]
"                Where class is either a class or the file extention
"-------------------------------------------------------------------------------
function TD_OpenFileTask( filename )
   let usedFilename = substitute( a:filename, "^[^#]*", "", "" )
   if ( strpart( usedFilename, 0, 1 ) == "#" )
      let extention = substitute( substitute( usedFilename, "\.*#\\[", "", "" ), "\].*", "", "" )

      if ( extention == "" )
         " There is no extention, open the file
         "-------------------------------------
         tabnew
         execute "edit " . substitute( strpart( usedFilename, 1 ), "\#.*", "", "" )
      elseif ( ( exists( "g:VM_todoLocalClassOpen" ) != 0 )&&( filereadable( expand( g:VM_todoLocalClassOpen . "/" . extention . ".vim" ) ) != 0 ) )
         " Execute the command file to open all the required files
         "--------------------------------------------------------
         execute "source " . g:VM_todoLocalClassOpen . "/" . extention . ".vim"
      elseif ( filereadable( expand( g:VM_todoClassOpen . "/" . extention . ".vim" ) ) != 0 )
         " Execute the command file to open all the required files
         "--------------------------------------------------------
         execute "source " . g:VM_todoClassOpen . "/" . extention . ".vim"
      else
         " There is no class for opening the file, use the extention to complete the filename
         "-----------------------------------------------------------------------------------
         tabnew
         execute "edit " . substitute( strpart( usedFilename, 1 ), "\#.*", "", "" ) . "." . extention
      endif
   else
      echo "The file format is not valid\n"
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Mapping sur les gestion de tâches
"----------------------------------
nmap <buffer> <S-F5> :tabnew<CR>:call VM_ProjectBuildClass()<CR>
nmap <buffer> <C-F5> :call TD_DeleteTask()<CR>
nmap <buffer> <CR> :call TD_OpenFileTask( expand( "<cWORD>" ) )<CR>
nmap <buffer> § :only<CR>:tabonly<CR>
nmap <buffer> Â§ :only<CR>:tabonly<CR>
nmap <buffer> <F8> :tabnew<CR>:Explore<CR>
nmap <buffer> <C-F1> :execute ":tabnew<CR>:vsplit " . expand( "<cWORD>" )<CR>
nmap <buffer> <S-C-F1> :tabnew<CR>:execute "split " . expand( "<cWORD>" )<CR>
nmap <buffer> <F3> :execute ":let VM_fileExec = \"" . expand( "<cword>" ) . "\""<CR>:tabnew<CR>:execute "tjump " . VM_fileExec<CR>
nmap <buffer> <S-F3> :execute ":let VM_fileExec = \"" . expand( "<cWORD>" ) . "\""<CR>:tabnew<CR>:execute "tjump " . VM_fileExec<CR>
nmap <buffer> <C-F3> :execute ":let VM_fileExec = \"" . expand( "<cword>" ) . "\""<CR>:tabnew<CR>:execute "tjump /" . VM_fileExec<CR>
nmap <buffer> <C-S-F3> :execute ":let VM_fileExec = \"" . expand( "<cWORD>" ) . "\""<CR>:tabnew<CR>:execute "tjump /" . VM_fileExec<CR>
vmap <buffer> <F3> y:tabnew<CR>:tjump <C-R>+<CR>
vmap <buffer> <S-F3> y:tabnew<CR>:tag <C-R>+<CR>
vmap <buffer> <C-F3> y:tabnew<CR>:tjump /<C-R>+<Tab>
vmap <buffer> <C-S-F3> y:tabnew<CR>:tag /<C-R>+<Tab>
nmap <buffer> <M-F8> :tabnew<CR>:find 
nmap <buffer> <C-S-F8> :call VM_BuildPath()<CR>
vmap <buffer> <F8> y:tabnew<CR>:find <C-R>+<Tab>
vmap <buffer> <C-S-F8> y:tabnew<CR>:find <C-R>+<CR>
nmap <buffer> <F2> :tabnew<CR>:vimgrep /
nmap <buffer> <S-F2> :tabnew<CR>:vimgrep /<C-R>// 
nmap <buffer> <M-F2> :tabnew<CR>:vimgrep /<C-R>*/ 
nmap <buffer> ò :tabnew<CR>:tjump 
nmap <buffer> Ã² :tabnew<CR>:tjump 
" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <C-F6> :setlocal foldtext=TD_TodoFoldText()<CR>:setlocal foldexpr=TD_TodoFoldLevel(v:lnum)<CR>:setlocal foldmethod=expr<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldexpr=TD_TodoFoldLevel(v:lnum)
      setlocal foldtext=TD_TodoFoldText()
      setlocal foldmethod=expr
      setlocal foldenable

      let b:foldSet = 1
   endif
endif
" Note the current project to avoid too many initialisation
"----------------------------------------------------------
let s:projectToInitialize = substitute( expand( "%:p:h" ), g:VM_projectDirSeparator . g:VM_projectDirSeparator, "/", "g" )
setlocal textwidth=90

if ( exists( "g:VM_todoCurrentProject" ) == 0 )
   let g:VM_todoCurrentProject = ""
endif

if ( s:projectToInitialize != g:VM_todoCurrentProject )
   let g:VM_todoCurrentProject = s:projectToInitialize
   call VM_ProjectInitialize()
endif

" Note the default indentation
"-----------------------------
if ( exists( "g:VM_todoIndentation" ) == 0 )
   let g:VM_todoIndentation = "   "
endif
" The repository where the class open command can be found
"---------------------------------------------------------
if ( exists( "g:VM_todoClassOpen" ) == 0 )
   let g:VM_todoClassOpen = "~/.VIM/TODO_CLASS"
endif

"---< Fin de fichier >----------------------------------------------------------

