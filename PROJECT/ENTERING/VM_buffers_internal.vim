" Fichier : VM_buffers_internal.vim
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

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

call VM_ProjectExecuteEnteringFile( "VM_project_internal" )

setlocal winfixheight
setlocal cursorline
setlocal nomodifiable
setlocal readonly

mapclear

if ( exists( "g:VM_searchedText" ) == 0 )
   let g:VM_searchedText = ""
endif
if ( exists( "g:VM_searchedIntro" ) == 0 )
   let g:VM_searchedIntro = "^ \\+\\(active\\|hidden\\) \\(\\[RO\\]\\|\\) \\+"
endif

call VM_AutoSearchMapping()

nmap <buffer> <CR> :call VM_BufferOpen( "buffer" )<CR>
nmap <buffer> <S-CR> :call VM_BufferOpen( "sbuffer" )<CR>
nmap <buffer> <C-CR> :call VM_BufferOpen( "vert sbuffer" )<CR>
nmap <buffer> ง :close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> ยง :close<CR>:call VM_BackToOriginalWindow()<CR>

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> <Esc><Esc> :close<CR>:call VM_BackToOriginalWindow()<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :close<CR>:call VM_BackToOriginalWindow()<CR>
endif " End IF we are using a gui version

"---< Fin de fichier >----------------------------------------------------------

