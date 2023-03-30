" Fichier : edifactVM.vim
"
" But : Enable the display of the readable message
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 04 December 2020
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_DisplayMessage" ) == 0 )

" Fonction : VM_DisplayMessage
"
" But : Display the edifact message in a readable way
"
"-------------------------------------------------------------------------------
function VM_DisplayMessage()
   let g:useDisplayMessage = 0

   let currentLine = line( "." )
   let messageValue = getline( currentLine )

   call VM_DisplayInternalWindow( "[Message from line " . currentLine . "]", "vert rightbelow 80 sview", "edifact", [], "" )

   set noreadonly

   call setline( 1, messageValue )

   %substitute /\/+/ge
   %substitute /\/:/ge
   %substitute /\/*/ge
   %substitute /\/'\&/ge

   set nomodified
   set readonly
   set filetype=edifact
   1

   unlet g:useDisplayMessage
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

nmap <buffer> <CR> :call VM_DisplayMessage()<CR>
nmap <buffer> + :call VM_DisplayMessage()<CR>

"---< Fin de fichier >----------------------------------------------------------

