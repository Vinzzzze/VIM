" Fichier : setting_php.vim
"
" But : Définition des settings des fichiers de syntaxe php
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

if ( exists( "*PhpFoldLevel" ) == 0 )

" Fonction : PhpFoldLevel
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
function PhpFoldLevel( lineNumber )
   let retValue = "="
   let currentLine = getline( a:lineNumber )

   if ( ( match( currentLine, "{" ) > -1 )||( match( currentLine, "^/\\*" ) > -1 ) )
      if ( ( ( match( currentLine, "{" ) > -1 )&&( match( currentLine, "}" ) == -1 ) )||( ( match( currentLine, "^/\\*" ) > -1 )&&( match( currentLine, "\\*/" ) == -1 ) ) )
         let retValue = "a1"
      endif
   elseif ( ( match( currentLine, "}" ) > -1 )||( match( currentLine, "^\\*/" ) > -1 ) )
      let retValue = "s1"
   endif

   return retValue
endfunction

endif

if ( exists( "*PhpFoldText" ) == 0 )

" Fonction : PhpFoldText
"
" But : Print the line for displaying a fold closed
"
" Buffer : 
"    Texte du PDL
" Retour :
"    Line to print
"-------------------------------------------------------------------------------
function PhpFoldText()
   let lengthCompressed = "     " . ( v:foldend - v:foldstart )
   return "\-< " . strpart( lengthCompressed, strlen( lengthCompressed ) - 5 ) . " lines >"
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Pour la création des accolades
"-------------------------------
imap <buffer> <C-M-{> {<cr>} // End <esc>O<tab>

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   nmap <buffer> <C-F6> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=syntax

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

