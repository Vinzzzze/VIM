" Fichier : setting_pdl.vim
"
" But : Setting pour les fichiers de PDL.
"
" Auteur : Vini "Cool Coyote"
" Date : 05/11/2003
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*PDLFoldLevel" ) == 0 )

" Fonction : PDLFoldLevel
"
" But : Calculate the folder level in a PDL
"
" Buffer : 
"    Texte du PDL
" Parametres :
"    lineNumber - Numéro de ligne actuellement analysée
" Retour :
"    Fold expression ( cf help fold )
"-------------------------------------------------------------------------------
function PDLFoldLevel( lineNumber )
   let retValue = 0
   let currentLineNumber = a:lineNumber

   if ( currentLineNumber == 1 )
      let g:insideVector = 0
   endif

   let currentLine = getline( currentLineNumber )

   if ( currentLine != "" )
      if ( g:insideVector != 0 )
         let retValue = "="

         if ( match( currentLine, ");" ) > -1 )
            let retValue = "<1"
            let g:insideVector = 0
         endif
      elseif ( ( match( currentLine, "\:=[ 	]*(" ) > -1 )&&( match( currentLine, ");" ) == -1 ) )
         let g:insideVector = 1
         let retValue = ">1"
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*PDLFoldText" ) == 0 )

" Fonction : PDLFoldText
"
" But : Print the line for displaying a fold closed
"
" Buffer : 
"    Texte du PDL
" Retour :
"    Line to print
"-------------------------------------------------------------------------------
function PDLFoldText()
   let objectName = substitute( substitute( getline( v:foldstart ), "^ \+", "", "" ), "\:=[ 	]*(.*", "\:= ( ... );", "" )

   return objectName
endfunction

endif

if ( exists( "*PDLConvertFile" ) == 0 )

" Fonction : PDLConvertFile
"
" But : Convert the file if needed to the appropriate name
"
" Retour :
"    The real filename to use
"-------------------------------------------------------------------------------
function PDLConvertFile()
   let retValue = expand( "%:p" )

   if ( expand( "%:e" ) != "pdl" )
      let retValue = g:PDL_ConvertFilename
      execute "silent! write! " . retValue
   elseif ( &modified != 0 )
      write
   endif

   return retValue
endfunction

endif

if ( exists( "*PDLBuildExec" ) == 0 )

" Fonction : PDLBuildExec
"
" But : Build the order to execute on the specified environment
"
" Buffer : 
"
" Parametres :
"    env : The environment name to use
" Marks :
"
" Retour :
"    The command to execute
"-------------------------------------------------------------------------------
function PDLBuildExec( env )
   let commandExec = ""
   let varCommandName = "g:PDL_Command_" . a:env

   if ( exists( varCommandName ) == 0 )
      execute "let " . varCommandName . " = input( \"Command ( gprime | gnp ) : \" )"
   endif

   if ( exists( "g:PDL_ActionOpen_" . a:env ) == 0 )
      execute "let g:PDL_ActionOpen_" . a:env . " = input( \"Action : \" )"
   endif

   execute "let commandName = " . varCommandName

   if ( commandName == "gprime" )
      let commandExec = g:PDL_GPrimeCommand . " -primel -i \"" . PDLConvertFile() . "\" -s \"" . g:PDL_StatusName . "\" -e"
   elseif ( commandName == "gnp" )
      let varMachineName = "g:PDL_MachineName_" . a:env

      if ( exists( varMachineName ) == 0 )
         execute "let " . varMachineName . " = input( \"Machine name : \" )"
      endif

      let varMachinePort = "g:PDL_MachinePort_" . a:env

      if ( exists( varMachinePort ) == 0 )
         execute "let " . varMachinePort . " = input( \"Machine port : \" )"
      endif

      execute "let machineName = " . varMachineName
      execute "let machinePort = " . varMachinePort

      let commandExec = g:PDL_GNPCommand . " \"" . PDLConvertFile() . "\" " . machineName . " " . machinePort
   else
      echo "ERROR : command [" . commandName . "] is unknown.\n\n";
   endif

   return commandExec
endfunction

endif

if ( exists( "*PDLSortFile" ) == 0 )

" Fonction : PDLSortFile
"
" But : Sort the current PDL file
"
" Buffer : 
"    The current buffer will be deleted and then rebuilt
"-------------------------------------------------------------------------------
function PDLSortFile()
   let commandExec = ".!" . g:PDL_GNPCommand . " \"" . PDLConvertFile() . "\" localhost 8000 test -n"
   %delete
   execute commandExec
endfunction

endif

if ( exists( "*PDLExec" ) == 0 )

" Fonction : PDLExec
"
" But : Execute the specified object on the specified environment.
"
" Buffer : 
"
" Parametres :
"    request : The request object name to use
"    env : The environment name to use
"-------------------------------------------------------------------------------
function PDLExec( request, env )
   let commandExec = PDLBuildExec( a:env )

   if ( commandExec > "" )
      let commandExec = commandExec . " " . a:request . " -o " . g:PDL_OutputFilename

      call system( commandExec )

      if ( bufloaded( g:PDL_OutputFilename ) != 0 )
         execute "bdelete " . g:PDL_OutputFilename
      endif

      execute "let actionOpen = g:PDL_ActionOpen_" . a:env
      execute actionOpen . " " . g:PDL_OutputFilename
   else
      echo "Unable to get the command...\n"
   endif
endfunction

endif

if ( exists( "*PDLExecRequestEnv" ) == 0 )

" Fonction : PDLExecRequestEnv
"
" But : Execute the request on the asked environment.
"
" Buffer : 
"
" Parametres :
"    request : The request object name to use
"-------------------------------------------------------------------------------
function PDLExecRequestEnv(request)
   let environment = input( "Environment to run : " )

   if ( environment > "" )
      call PDLExec( a:request, environment )
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer><silent> <C-F6> :setlocal foldtext=PDLFoldText()<CR>:setlocal foldexpr=PDLFoldLevel(v:lnum)<CR>:setlocal foldmethod=expr<CR>:setlocal foldenable<CR>
   nmap <buffer><silent> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldtext=PDLFoldText()
      setlocal foldexpr=PDLFoldLevel(v:lnum)
      setlocal foldenable
      setlocal foldmethod=expr

      let b:foldSet = 1
   endif
else
   highlight pdlNumber guifg=white
endif

setlocal cursorline

" Les PDLs ne sont pas case sensitive : option non locale
"--------------------------------------------------------
call VM_SetIgnoreCase()

" Pour commenter / decommenter une zone
"--------------------------------------
vmap <buffer><silent> <F2> :substitute /^./-- &/<CR>
vmap <buffer><silent> <S-F2> :substitute /^-- //<CR>

" The global variable definition
"-------------------------------
if ( exists( "g:PDL_GPrimeCommand" ) == 0 )
   let g:PDL_GPrimeCommand = "C:\\WORKSPACE\\GPRIME\\gprime.exe"
endif

if ( exists( "g:PDL_GNPCommand" ) == 0 )
   let g:PDL_GNPCommand = "C:\\WORKSPACE\\GPRIME\\gnp.exe"
endif

if ( exists( "g:PDL_StatusName" ) == 0 )
   let g:PDL_StatusName = "C:\\WORKSPACE\\GPRIME\\status.txt"
endif

if ( exists( "g:PDL_OutputFilename" ) == 0 )
   let g:PDL_OutputFilename = "C:\\WORKSPACE\\GPRIME\\out.pdl"
endif

if ( exists( "g:PDL_ConvertFilename" ) == 0 )
   let g:PDL_ConvertFilename = "C:\\WORKSPACE\\GPRIME\\update.pdl"
endif

" Define the environment that we can use
"---------------------------------------
let g:PDL_ActionOpen_MDD = "vsplit"
let g:PDL_Command_MDD = "gnp"
let g:PDL_MachineName_MDD = "gnp-histo.equities.net.intra"
let g:PDL_MachinePort_MDD = "8000"

let g:PDL_ActionOpen_MDDUAT = "vsplit"
let g:PDL_Command_MDDUAT = "gnp"
let g:PDL_MachineName_MDDUAT = "cgr-sf-010.equities.net.intra"
let g:PDL_MachinePort_MDDUAT = "8100"

let g:PDL_ActionOpen_CIPRD = "vsplit"
let g:PDL_Command_CIPRD = "gnp"
let g:PDL_MachineName_CIPRD = "customindices-cinergy-core.cib.echonet "
let g:PDL_MachinePort_CIPRD = "2012"

let g:PDL_ActionOpen_CIUAT = "vsplit"
let g:PDL_Command_CIUAT = "gnp"
let g:PDL_MachineName_CIUAT = "customindices-cinergy-core.staging.echonet"
let g:PDL_MachinePort_CIUAT = "2012"

let g:PDL_ActionOpen_CIINT = "vsplit"
let g:PDL_Command_CIINT = "gnp"
let g:PDL_MachineName_CIINT = "eqdg3dprm001"
let g:PDL_MachinePort_CIINT = "2012"

let g:PDL_ActionOpen_CIDEV = "vsplit"
let g:PDL_Command_CIDEV = "gnp"
let g:PDL_MachineName_CIDEV = "localhost"
let g:PDL_MachinePort_CIDEV = "2012"

let g:PDL_ActionOpen_TSS = "vsplit"
let g:PDL_Command_TSS = "gnp"
let g:PDL_MachineName_TSS = "gnp-histo.equities.net.intra"
let g:PDL_MachinePort_TSS = "12002"

let g:PDL_ActionOpen_local = "split"
let g:PDL_Command_local = "gprime"

nmap <buffer><silent> <S-CR> :call PDLExec( expand( "<cword>" ), "MDD" )<CR>
nmap <buffer><silent> <C-CR> :call PDLExecRequestEnv( expand( "<cword>" ) )<CR>
nmap <buffer><silent> <S-C-CR> :call PDLExec( expand( "<cword>" ), "local" )<CR>
vmap <buffer><silent> <S-CR> y:call PDLExec( @0, "MDD" )<CR>
vmap <buffer><silent> <C-CR> y:call PDLExecRequestEnv( @0 )<CR>
vmap <buffer><silent> <S-C-CR> y:call PDLExec( @0, "local" )<CR>
nmap <buffer><silent> <F6> :call PDLSortFile()<CR>

"---< Fin de fichier >----------------------------------------------------------

