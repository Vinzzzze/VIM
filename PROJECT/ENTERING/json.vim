" Fichier : json.vim
"
" But : Actions to do when entrering in a JSON file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 15 févr. 2016
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*JSON_EliminateEmptyArray" ) == 0 )
 
" Fonction : JSON_EliminateEmptyArray
"
" But : Reduce the empty arrays on a single line.
"
"-------------------------------------------------------------------------------
function JSON_EliminateEmptyArray()
   let currentLine = 1
   let lastLine = line( "$" )
 
   while ( currentLine <= lastLine )
      if ( ( match( getline( currentLine ), "^[            ]*\\[$" ) == 0 )&&( match( getline( currentLine + 1 ), "^[    ]*\\]" ) == 0 ) )
         execute currentLine . " join"
         let lastLine -= 1
      endif
 
      let currentLine += 1
   endwhile
 
   % substitute /\[ \+\]/[]/ge
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

