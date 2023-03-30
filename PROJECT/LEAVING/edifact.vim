" Fichier : edifact.vim
"
" But : Quit the readable edifact messages
"
" Auteur : vmenager - Vincent.MENAGER@amadeus.com
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

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "*VM_UnreadableMessage" ) != 0 )
   delfunction VM_UnreadableMessage
endif
if ( exists( "*VM_ReadableAgain" ) != 0 )
   delfunction VM_ReadableAgain
endif

"---< Fin de fichier >----------------------------------------------------------

