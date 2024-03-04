" Fichier : termCMapping-rxvt-unicode-256color.vim
"
" But : The mapping C for the rxvt file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 20 mars 2021
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

if ( expand( "%:e" ) == "c" )
   nmap <buffer> <F20> :call CCompleteOpen()<CR>
else
   nmap <buffer> <F20> :call COpenAlternate( "vsplit", "" )<CR>
endif

if ( exists( "g:VM_debugModeActive" ) == 0 )
   nmap <buffer> <silent> <F4> :Debug<CR>
   nmap <buffer> <silent> <Tab><F1> :SelectDebug<CR>
   if ( exists( "b:VM_localDebugMapping" ) != 0 )
      unlet b:VM_localDebugMapping
   endif
else " End IF the debug mode is not active
   " Pour commenter / décommenter une zone
   "--------------------------------------
   nmap <buffer> <silent> <F4> :Run<CR>
   nmap <buffer> <silent> <F16> :Stop<CR>
   nmap <buffer> <silent> <F9> :Over<CR>
   nmap <buffer> <silent> <F6> :Step<CR>
   nmap <buffer> <silent> <F18> :Continue<CR>
   nmap <buffer> <silent> <F1> :Break<CR>
   nmap <buffer> <silent> <F13> :Clear<CR>
endif " End IF the debug mode is active

"---< Fin de fichier >----------------------------------------------------------


