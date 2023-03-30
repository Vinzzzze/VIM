" Fichier : setting_xml.vim
"
" But : Définition des settings des fichiers de syntaxe XML
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

if ( exists( "*XmlFoldLevel" ) == 0 )

" Fonction : XmlFoldLevel
"
" But : Calculate the folder level for the C/C++ language.
"
" Buffer : 
"    Texte du source
" Parametres :
"    lineNumber - Numéro de ligne actuellement analysée
" Retour :
"    Fold expression ( cf help fold )
"-------------------------------------------------------------------------------
function XmlFoldLevel( lineNumber )
   let retValue = "="
   let currentLine = getline( a:lineNumber )

   if ( ( match( currentLine, "<[A-Za-z_0-9]" ) > -1 )||( match( currentLine, "<!--" ) > -1 ) )
      if ( ( ( match( currentLine, "<[A-Za-z_0-9]" ) > -1 )&&( match( currentLine, "\/>" ) == -1 )&&( match( currentLine, "</[A-Za-z_0-9]" ) == -1 ) )||( ( match( currentLine, "<!--" ) > -1 )&&( match( currentLine, "\-->" ) == -1 ) ) )
         let retValue = "a1"
      endif
   elseif ( ( match( currentLine, "\-->" ) > -1 )||( match( currentLine, "/>" ) > -1 )||( match( currentLine, "</[A-Za-z_0-9]" ) > -1 ) )
      let retValue = "s1"
   endif

   return retValue
endfunction

endif

if ( exists( "*XmlFoldText" ) == 0 )

" Fonction : XmlFoldText
"
" But : Print the line for displaying a fold closed
"
" Buffer : 
"    Texte du PDL
" Retour :
"    Line to print
"-------------------------------------------------------------------------------
function XmlFoldText()
   let currentLine = substitute( getline( v:foldstart ), "^ \\+", "", "" )
   let baseString = strpart( "\----------------------------------------------------------------", 0, ( ( foldlevel( v:foldstart ) - 1 ) * 2 ) ) . "< "
   if ( match( currentLine, "<[A-Za-z_0-9]" ) > -1 )
      if ( match( currentLine, "name=\"" ) > -1 )
         let currentLine = substitute( substitute( currentLine, " *name=\"", " ", "" ), "\".*", "", "" )
      else
         let currentLine = substitute( substitute( currentLine, " .*", "", "" ), ">.*", "", "" )
      endif
      let retValue = substitute( currentLine, "<", baseString, "" ) . " >"
   else
      let retValue = baseString . "********************** ++ COMMENTS ++ ********************** >"
   endif
    return retValue
endfunction

endif

if ( exists( "*XmlCommentArea" ) == 0 )

" Fonction : XmlCommentArea
"
" But : Comment a global area.
"-------------------------------------------------------------------------------
function XmlCommentArea()
   let currentLineNum = line( "'<" )
   let endCurrentLineNum = line( "'>" )

   if ( currentLineNum == endCurrentLineNum )
      call setline( currentLineNum, substitute( getline( currentLineNum ), "[^ 	].*", "<!-- & -->", "" ) )
   else
      let indentLine = substitute( getline( currentLineNum ), "[^ 	].*", "", "" )
      call append( currentLineNum - 1, indentLine . "<!--" )
      call append( endCurrentLineNum + 1, indentLine . "-->" )
   endif
endfunction

endif

if ( exists( "*XmlUncommentArea" ) == 0 )

" Fonction : XmlUncommentArea
"
" But : Uncomment a global area.
"-------------------------------------------------------------------------------
function XmlUncommentArea()
   let currentLineNum = line( "'<" )
   let currentLine = substitute( getline( currentLineNum ), "<!--\\( \\|\\)", "", "" )

   if ( substitute( currentLine, "^[ 	]*$", "", "" ) == "" )
      execute currentLineNum . " delete"
   else
      call setline( currentLineNum, currentLine )
   endif

   let currentLineNum = line( "'>" )
   let currentLine = substitute( getline( currentLineNum ), "\\( \\|\\)-->", "", "" )

   if ( substitute( currentLine, "^[ 	]*$", "", "" ) == "" )
      execute currentLineNum . " delete"
   else
      call setline( currentLineNum, currentLine )
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Encodage par défaut des fichiers XML
"-------------------------------------
if ( &modifiable != 0 )
   let s:fileModified = &modified
   % substitute /\(Ä\|Â\|Ã\)\(‚\|ƒ\)//ge
   let &modified = s:fileModified
endif
setlocal matchpairs=(:),{:},[:],<:>

" The mapping for a good completion
"----------------------------------
vmap <buffer> <CR> dA§<C-CR>
vmap <buffer> <F2> <Esc>:call XmlCommentArea()<CR>

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   vmap <buffer> <Esc><CR> dA@<C-CR>
   vmap <buffer> <Esc>[1;2Q <Esc>:call XmlUncommentArea()<CR>
else " End IF we are in a terminal window
   vmap <buffer> <C-CR> dA@<C-CR>
   vmap <buffer> <S-F2> <Esc>:call XmlUncommentArea()<CR>
endif " End IF we are in a GUI window

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <C-F6> :setlocal foldtext=XmlFoldText()<CR>:setlocal foldexpr=XmlFoldLevel(v:lnum)<CR>:setlocal foldmethod=expr<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldexpr=XmlFoldLevel(v:lnum)
      setlocal foldtext=XmlFoldText()
      setlocal foldmethod=expr
      setlocal foldenable

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

