" Fichier : edifact.vim
"
" But : Build a real edifact message from the readable version
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 11 Dec 2020
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_UnreadableMessage" ) == 0 )

" Fonction : VM_UnreadableMessage
"
" But : Make a real edifact message from a readable one
"-------------------------------------------------------------------------------
function VM_UnreadableMessage()
   set noreadonly

   %substitute /'\(\|&\)$/\/ge
   %join
   %substitute /\ /\/ge
   %substitute /*/\/ge
   %substitute /:/\/ge
   %substitute /+/\/ge

   set nomodified
   set readonly
   set filetype=edifactVM
   1
   0
endfunction

endif

if ( exists( "*VM_ReadableAgain" ) == 0 )

" Fonction : VM_ReadableAgain
"
" But : Make an edifact message readable again
"-------------------------------------------------------------------------------
function VM_ReadableAgain()
   set noreadonly

   undo

   set nomodified
   set readonly
   set filetype=edifact
   1
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

nmap <buffer> <F4> :call VM_UnreadableMessage()<CR>
nmap <buffer> u :call VM_ReadableAgain()<CR>

"---< Fin de fichier >----------------------------------------------------------

