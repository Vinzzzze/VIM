" Fichier : setting_c.vim
"
" But : Définition des settings des fichiers de syntaxe C.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*COpenAlternate" ) == 0 )

" Fonction : COpenAlternate
"
" But : Open the alternate file, on the header we open the body,
"       on the body, open the header
"
" Parametres :
"     modeOpen - The command used to open the file
"     expectedExt - The expected extention to open
"-------------------------------------------------------------------------------
function COpenAlternate( modeOpen, expectedExt )
   " Get the current extention
   "--------------------------
   let extention = expand( "%:e" )
   let opened = 0

   if ( a:expectedExt > "" && extention != a:expectedExt )
      let fileToOpen = expand( "%:r" ) . "." . a:expectedExt
      let opened = filereadable( fileToOpen )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . fileToOpen
      endif
   elseif ( extention == "h" )
      let fileToOpen = expand( "%:r" ) . ".str"
      let opened = filereadable( fileToOpen )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . fileToOpen
      else
         let fileToOpen = expand( "%:r" ) . ".mac"
         let opened = filereadable( fileToOpen )

         if ( opened != 0 )
            " Open the alternate file
            "------------------------
            execute a:modeOpen . " " . fileToOpen
         else
            let fileToOpen = expand( "%:r" ) . ".typ"
            let opened = filereadable( fileToOpen )

            if ( opened != 0 )
               " Open the alternate file
               "------------------------
               execute a:modeOpen . " " . fileToOpen
            else
               let fileToOpen = expand( "%:r" ) . ".c"
               let opened = filereadable( fileToOpen )

               if ( opened != 0 )
                  " Open the alternate file
                  "------------------------
                  execute a:modeOpen . " " . fileToOpen
               endif
            endif
         endif
      endif
   elseif ( extention == "str" )
      let fileToOpen = expand( "%:r" ) . ".mac"
      let opened = filereadable( fileToOpen )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . fileToOpen
      else
         let fileToOpen = expand( "%:r" ) . ".typ"
         let opened = filereadable( fileToOpen )

         if ( opened != 0 )
            " Open the alternate file
            "------------------------
            execute a:modeOpen . " " . fileToOpen
         else
            let fileToOpen = expand( "%:r" ) . ".c"
            let opened = filereadable( fileToOpen )

            if ( opened != 0 )
               " Open the alternate file
               "------------------------
               execute a:modeOpen . " " . fileToOpen
            endif
         endif
      endif
   elseif ( extention == "mac" )
      let fileToOpen = expand( "%:r" ) . ".typ"
      let opened = filereadable( fileToOpen )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . fileToOpen
      else
         let fileToOpen = expand( "%:r" ) . ".c"
         let opened = filereadable( fileToOpen )

         if ( opened != 0 )
            " Open the alternate file
            "------------------------
            execute a:modeOpen . " " . fileToOpen
         endif
      endif
   elseif ( extention == "c" )
      let fileToOpen = expand( "%:r" ) . ".h"
      let opened = filereadable( fileToOpen )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . fileToOpen
      else
         let fileToOpen = expand( "%:r" ) . ".str"
         let opened = filereadable( fileToOpen )

         if ( opened != 0 )
            " Open the alternate file
            "------------------------
            execute a:modeOpen . " " . fileToOpen
         else
            let fileToOpen = expand( "%:r" ) . ".mac"
            let opened = filereadable( fileToOpen )

            if ( opened != 0 )
               " Open the alternate file
               "------------------------
               execute a:modeOpen . " " . fileToOpen
            else
               let fileToOpen = expand( "%:r" ) . ".typ"
               let opened = filereadable( fileToOpen )

               if ( opened != 0 )
                  " Open the alternate file
                  "------------------------
                  execute a:modeOpen . " " . fileToOpen
               endif
            endif
         endif
      endif
   endif

   return opened
endfunction

endif

if ( exists( "*BuildFunctionComment" ) == 0 )

" Fonction : BuildFunctionComment
"
" But : Build the header of a function.
"
" Parametres :
"     numLine - The line number where the comment had to been added
"     functionName - The function name
"     comment - The comment of the function
"     voidFct - To know if the current function is void function
" Retour :
"     The last number of line where the last line had been added
"-------------------------------------------------------------------------------
function BuildFunctionComment( numLine, functionName, comment, voidFct )
   call append( a:numLine, "" )
   let numLineRet = a:numLine + 1
   call append( numLineRet, "\/**" )
   let numLineRet = VM_PrintLimitedLengthLine( " * ", " * ", numLineRet + 1, a:comment, 90 )
   call append( numLineRet, " *" )
   let numLineRet = numLineRet + 1
   call append( numLineRet, " * @param " )
   let numLineRet = numLineRet + 1

   if ( a:voidFct == 0 )
      call append( numLineRet, " *" )
      let numLineRet = numLineRet + 1
      call append( numLineRet, " * @return " )
      let numLineRet = numLineRet + 1
   endif

   call append( numLineRet, "*/" )
   let numLineRet = numLineRet + 1

   return numLineRet
endfunction

endif

if ( exists( "*ComputeFunctionName" ) == 0 )

" Fonction : ComputeFunctionName
"
" But : Compute the function name by adding the class name after the name given.
"
" Parametres :
"     functionName - The function name to use
" Retour :
"     The composed function name
"-------------------------------------------------------------------------------
function ComputeFunctionName( functionName )
   let currentClassName = expand( "%:t:r" )

   return a:functionName . "_" . currentClassName
endfunction

endif

if ( exists( "*BuildFunctionBody" ) == 0 )

" Fonction : BuildFunctionBody
"
" But : Build the function body.
"
" Parametres :
"     numLine - The line number where the comment had to been added
"     typeReturned - The type returned
"     functionName - The function name
"     comment - The comment of the function
"     voidFct - To know if the current function is void function
"-------------------------------------------------------------------------------
function BuildFunctionBody( numLine, typeReturned, functionName, comment, voidFct )
   let numLineRet = BuildFunctionComment( a:numLine, a:functionName, a:comment, a:voidFct )
   call append( numLineRet, a:typeReturned . " " . ComputeFunctionName( a:functionName ) . "()" )
   let numLineRet = numLineRet + 1
   call append( numLineRet, "{" )
   let numLineRet = numLineRet + 1

   if ( a:voidFct == 0 )
      call append( numLineRet, g:VM_projectIndentation . "return <@RETURNED_VALUE@>;" )
      let numLineRet = numLineRet + 1
   endif

   call append( numLineRet, "}" )
endfunction

endif

if ( exists( "*ConvertNumToCommand" ) == 0 )

" Fonction : ConvertNumToCommand
"
" But : Convert the number into a command name.
"
" Parametres :
"     commandNum - The number of the command
"-------------------------------------------------------------------------------
function ConvertNumToCommand( commandNum )
   if ( a:commandNum < 2 )
      return "vsplit"
   endif

   return "split"
endfunction

endif

if ( exists( "*CCompleteOpen" ) == 0 )

" Fonction : CCompleteOpen
"
" But : Open all the associated files
"-------------------------------------------------------------------------------
function CCompleteOpen()
   let currentCommandNum = 0
   let changeWindow = 0
   let gotoLeft = 0

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "mac" ) != 0 )
      let currentCommandNum += 1
      let gotoLeft += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "h" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "typ" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "str" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( gotoLeft > 0 )
      execute gotoLeft . " wincmd h"
   endif " End IF we have to go back to the main window

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "cflt" ) != 0 )
      let currentCommandNum += 1
   endif

   wincmd =
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Pour l'utilisation de la fonction qui permet de passer du header au body et reciproquement
"-------------------------------------------------------------------------------------------
if ( exists( "g:VM_terminalUsage" ) == 0 )
   if ( expand( "%:e" ) == "c" )
      nmap <buffer> <S-F8> :call CCompleteOpen()<CR>
   else
      nmap <buffer> <S-F8> :call COpenAlternate( "vsplit", "" )<CR>
   endif

   nmap <buffer> <C-F8> :call COpenAlternate( "split", "" )<CR>
   nmap <buffer> <M-F8> :call COpenAlternate( "edit", "" )<CR>

   if ( exists( "g:VM_debugModeActive" ) == 0 )
      nmap <buffer> <silent> <F4> :Debug<CR>
      nmap <buffer> <silent> <M-F1> :SelectDebug<CR>
      if ( exists( "b:VM_localDebugMapping" ) != 0 )
         unlet b:VM_localDebugMapping

         nunmap <buffer> <S-F4>
         nunmap <buffer> <C-F4>
         nunmap <buffer> <C-F9>
         nunmap <buffer> <F1>
         nunmap <buffer> <S-F1>
      endif
   else " End IF the debug mode is not active
      " Pour commenter / décommenter une zone
      "--------------------------------------
      nmap <buffer> <silent> <F4> :Run<CR>
      nmap <buffer> <silent> <S-F4> :Stop<CR>
      nmap <buffer> <silent> <C-F4> :Gdb<CR>
      nmap <buffer> <silent> <F9> :Over<CR>
      nmap <buffer> <silent> <S-F9> :Step<CR>
      nmap <buffer> <silent> <C-F9> :Continue<CR>
      nmap <buffer> <silent> <F1> :Break<CR>
      nmap <buffer> <silent> <S-F1> :Clear<CR>
   endif " End IF the debug mode is active
else
   call VM_ProjectTerminalMappingFile( "termCMapping" )
endif

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   if ( exists( "g:VM_terminalUsage" ) == 0 )
      nmap <buffer> <C-F6> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
      nmap <buffer> <S-F6> :setlocal nofoldenable<CR>
   else
      call VM_ProjectTerminalMappingFile( "termFoldMapping" )
   endif

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=syntax

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

