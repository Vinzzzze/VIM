" Fichier : edifactVM.vim
"
" But : Quit the edifact messages
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

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( ( exists( "*VM_DisplayMessage" ) != 0 )&&( exists( "useDisplayMessage" ) == 0 ) )
   delfunction VM_DisplayMessage
endif
if ( exists( "*VM_UnreadableMessage" ) != 0 )
   delfunction VM_UnreadableMessage
endif
if ( exists( "*VM_ReadableAgain" ) != 0 )
   delfunction VM_ReadableAgain
endif

"---< Fin de fichier >----------------------------------------------------------

