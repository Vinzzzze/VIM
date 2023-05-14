" Fichier : setting_c.vim
"
" But : Définition des settings des fichiers de syntaxe C.
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

if ( ( exists( "*ConvertNumToCommand" ) != 0 )&&( exists( "g:VM_runCompletion" ) == 0 ) )
   delfunction ConvertNumToCommand
endif

if ( exists( "*ConvertNumToCommand" ) == 0 )

" Fonction : ConvertNumToCommand
"
" But : Convert the number into a command name.
"
" Parametres :
"     commandNum - The number of the command
"-------------------------------------------------------------------------------
function ConvertNumToCommand( commandNum )
   if ( a:commandNum == 0 )
      return "vsplit"
   elseif ( a:commandNum == 1 )
      return "tabnew"
   elseif ( a:commandNum == 2 )
      return "vsplit"
   endif

   return "split"
endfunction

endif

if ( ( exists( "*CCompleteOpen" ) != 0 )&&( exists( "g:VM_runCompletion" ) == 0 ) )
   delfunction CCompleteOpen
endif

if ( exists( "*CCompleteOpen" ) == 0 )

" Fonction : CCompleteOpen
"
" But : Open all the associated files
"-------------------------------------------------------------------------------
function CCompleteOpen()
   let g:VM_runCompletion = 1
   let currentCommandNum = 0
   let changeWindow = 0

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "mac" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "h" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "typ" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "str" ) != 0 )
      let currentCommandNum += 1
   endif

   if ( gotoLeft > 0 )
      execute gotoLeft . " wincmd h"
   endif " End IF we have to go back to the main window

   if ( COpenAlternate( ConvertNumToCommand( currentCommandNum ), "cflt" ) != 0 )
      let currentCommandNum += 1
   endif

   wincmd =
   unlet g:VM_runCompletion
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

"---< Fin de fichier >----------------------------------------------------------

