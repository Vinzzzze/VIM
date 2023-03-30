" Fichier : VM_tab_buffers_internal.vim
"
" But : Describe the actions associated to the buffer display.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 22 sept. 2014
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_GetInternalClass" ) == 0 )

" Fonction : VM_GetInternalClass
"
" But : Get the associated class and open it when needed
"
" Parametres :
"    className - The class name to be opened
"-------------------------------------------------------------------------------
function VM_GetInternalClass( className )
   let classFound = VM_ClassChooseClassDefinition( a:className )

   if ( empty( classFound ) == 0 )
      call VM_ClassOpenDefinition( classFound )
   else
      call VM_BackToOriginalWindow()
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
   let g:VM_searchedIntro = "^\\(\\|+ \\)[^ ]*"
endif

setlocal winfixheight
setlocal cursorline
setlocal nomodifiable
setlocal readonly

mapclear

let position = getpos( "." )
let position[ 1 ] = 1
let position[ 2 ] = 1
let position[ 3 ] = 0
call setpos( ".", position )

nmap <buffer> <BS> :call VM_SearchDelete( 1 )<CR>
nmap <buffer> <Del> :call VM_SearchDelete( 0 )<CR>
nmap <buffer> <CR> :call VM_TabSelected( 0 )<CR>
nmap <buffer> <S-CR> :call VM_TabSelected( -1 )<CR>
nmap <buffer> <C-CR> :let tempName = g:VM_searchedText<CR>ง:call VM_GetInternalClass( tempName )<CR>
nmap <buffer> ง :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> ยง :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> <C-Right> <C-L>
nmap <buffer> <C-Left> :wincmd h<CR>
nmap <buffer> <Right> <C-L>
nmap <buffer> <Left> :wincmd h<CR>

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> <Esc><Esc> :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
endif " End IF we are using a gui version

call VM_AutoSearchMapping()

"---< Fin de fichier >----------------------------------------------------------

