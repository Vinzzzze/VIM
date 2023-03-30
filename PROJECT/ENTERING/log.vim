" Fichier : setting_log.vim
"
" But : Définition des settings des fichiers de syntaxe log
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

if ( exists( "*LogFoldLevel" ) == 0 )

" Fonction : LogFoldLevel
"
" But : Calculate the folder level for the PHP language.
"
" Buffer : 
"    Texte du source
" Parametres :
"    lineNumber - Numéro de ligne actuellement analysée
" Retour :
"    Fold expression ( cf help fold )
"-------------------------------------------------------------------------------
function LogFoldLevel( lineNumber )
   let retValue = "="

   if ( a:lineNumber == 1 )
      let retValue = ">1"
      let g:insidePDLList = 1
   elseif ( g:insidePDLList != 0 )
      let nextLine = getline( a:lineNumber + 1 )

      if ( match( nextLine, "^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\\.[0-9][0-9][0-9]$" ) > -1 )
         let retValue = "<1"
         let g:insidePDLList = 0
      endif
   else
      let currentLine = getline( a:lineNumber )
      let prevLine = getline( a:lineNumber - 1 )
      let nextLine = getline( a:lineNumber + 1 )

      if ( match( prevLine, "^[0-9][0-9]:[0-9][0-9]:[0-9][0-9]\\.[0-9][0-9][0-9]$" ) > -1 )
         let retValue = "a1"
      elseif ( match( nextLine, "^-----------------------------" ) > -1 )
         let retValue = "s1"
      endif
   endif

   return retValue
endfunction

endif

if ( exists( "*LogFoldText" ) == 0 )

" Fonction : LogFoldText
"
" But : Print the line for displaying a fold closed
"
" Buffer : 
"    Texte du PDL
" Retour :
"    Line to print
"-------------------------------------------------------------------------------
function LogFoldText()
   if ( v:foldstart == 1 )
      let fileName = "PDL list"
   else
      let currentLine = getline( v:foldstart )
      if ( v:foldend == line( "$" ) )
         let fileName = "End of file"
      elseif ( currentLine == "" )
         let fileName = getline( v:foldend )
      else
         let fileName = substitute( currentLine, "\.* ", "", "" )
      endif
   endif
   return "\-< " . fileName . " >"
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Do the fold mapping only for a PDL file
"----------------------------------------
if ( match( getline( 1 ), "[0-9]\\+ PDL found" ) > -1 )
   if ( &diff == 0 )
      " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
      "---------------------------------------------------------------------
      nmap <buffer> <C-F6> :setlocal foldexpr=LogFoldLevel(v:lnum)<CR>:setlocal foldmethod=expr<CR>:setlocal foldenable<CR>
      nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

      if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
         " Auto launch the fold options
         "-----------------------------
         setlocal foldexpr=LogFoldLevel(v:lnum)
         setlocal foldtext=LogFoldText()
         setlocal foldmethod=expr
         setlocal foldenable

         let b:foldSet = 1
      endif
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

