" Fichier : VM_classes_display.vim
"
" But : The mapping and fold on the class display buffer.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 05 Jan 2015
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*CLASS_ComputeFoldLevel" ) == 0 )

" Fonction : CLASS_ComputeFoldLevel
"
" But : Compute the fold level value
"
" Parametres :
"    lineNumber - The line number for which the fold level had to be computed
" Retour :
"    The number of the foldlevel
"-------------------------------------------------------------------------------
function CLASS_ComputeFoldLevel( lineNumber )
   let currentLine = getline( a:lineNumber )
   let retValue = stridx( currentLine, "+" )

   if ( retValue < 0 )
      let retValue = stridx( currentLine, "{" )
   endif

   if ( retValue < 0 )
      let retValue = 0
   else
      let retValue = retValue / 2
   endif

   return retValue
endfunction

endif

if ( exists( "*CLASS_OpenCurrentLine" ) == 0 )

" Fonction : CLASS_OpenCurrentLine
"
" But : Open the file under the current line
"
" Parameter :
"    useNewTab - false if continue in the same tab, another value otherwise
"-------------------------------------------------------------------------------
function CLASS_OpenCurrentLine( useNewTab )
   let lineNumber = line( "." )
   let currentLine = g:VM_classesAllLines[ lineNumber - 1 ]

   if ( currentLine.file != "" )
      if ( a:useNewTab != 0 )
         tabnew
         call VM_ShowTags( "", "" )
         execute lineNumber
      endif

      call VM_ClassOpenDefinition( currentLine )
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

call VM_ProjectExecuteEnteringFile( "VM_project_internal" )

if ( exists( "g:VM_searchedText" ) == 0 )
   let g:VM_searchedText = ""
endif
if ( exists( "g:VM_searchedIntro" ) == 0 )
   let g:VM_searchedIntro = ""
endif

setlocal winfixwidth
setlocal cursorline
setlocal nomodifiable
setlocal readonly

mapclear

nmap <buffer> <Esc> :close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> § :close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> Â§ :close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> <C-F7> :call VM_BackToOriginalWindow()<CR>
nmap <buffer> ã :tabclose<CR>
nmap <buffer> Ã£ :tabclose<CR>
nmap <buffer> <kPlus> :foldopen<CR>
nmap <buffer> <kMinus> :foldclose<CR>
nmap <buffer> <S-kPlus> :foldopen!<CR>
nmap <buffer> <S-kMinus> :foldclose!<CR>
nmap <buffer> <C-Up> :call search( "+\\(Class\\\|Enum\\) ", "bw" )<CR>
nmap <buffer> <C-Left> :foldclose<CR><Up>
nmap <buffer> <C-Down> :call search( "+\\(Class\\\|Enum\\) ", "w" )<CR>
nmap <buffer> <C-Right> <C-W><Right>
nmap <buffer> <C-T> :tabnew<CR>
nmap <buffer> <C-TAB> :tabnext<CR>
nmap <buffer> <S-C-TAB> :tabprevious<CR>
nmap <buffer> <CR> :call CLASS_OpenCurrentLine( 0 )<CR>
nmap <buffer> <S-CR> :call CLASS_OpenCurrentLine( 1 )<CR>
nmap <buffer> ô :tabnew<CR>:tjump 
nmap <buffer> Ã´ :tabnew<CR>:tjump 

" Auto launch the fold options
"-----------------------------
setlocal foldmethod=expr
setlocal foldexpr=CLASS_ComputeFoldLevel(v:lnum)
setlocal foldenable

call VM_AutoSearchMapping()

"---< Fin de fichier >----------------------------------------------------------

