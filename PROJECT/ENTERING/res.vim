" Fichier : setting_res.vim
"
" But : Setting pour les fichiers de Resultat d'opération.
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

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Redéfinition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=8
setlocal tabstop=8
" Les fichiers UNIX sont plus jolis
"----------------------------------
setlocal fileformat=unix
" Le mapping pour revenir au fichier originel
"--------------------------------------------
if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> <Esc>@ :b!#<CR>:echo ""<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :b!#<CR>:echo ""<CR>
endif " End IF we are using a gui version
" Le mapping pour parcourir la liste des commandes
"-------------------------------------------------
nmap <buffer> <F2> /^COMMAND > /<CR>
nmap <buffer> <S-F2> ?^COMMAND > ?<CR>
" Affiche la liste des commandes exécutées
"-----------------------------------------
nmap <buffer> <C-F2> :%global /^COMMAND ([^)]*) > /<CR>
" Vide le buffer
"---------------
nmap <buffer> <F10> :%global /^COMMAND ([^)]*) > / -2,+1 delete<CR>$ delete<CR>
nmap <buffer> <S-F10> :%delete<CR>

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <C-F6> :setlocal foldexpr=ResultFoldLevel(v:lnum)<CR>:setlocal foldmethod=expr<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldexpr=ResultFoldLevel(v:lnum)
      setlocal foldmethod=expr
      setlocal foldenable

      " Declare a global variable to determine the current fold to use
      "---------------------------------------------------------------
      let b:globalFoldValue = 0

      let b:foldSet = 1
   endif
endif

if ( exists( "*ResultFoldLevel" ) == 0 )

" Fonction : ResultFoldLevel
"
" But : Calculate the current fold level
"
" Buffer : 
"    Texte du source
" Parametres :
"    lineNumber - Numéro de ligne actuellement analysée
" Retour :
"    Fold expression ( cf help fold )
"-------------------------------------------------------------------------------
function ResultFoldLevel( lineNumber )
   let currentLine = getline( a:lineNumber )

   if ( match( currentLine, "^\\*\\*\\*\\*\\+$" ) > -1 )
      let b:globalFoldValue = 1 - b:globalFoldValue
   endif

   let retVal = b:globalFoldValue
   return retVal
endfunction

endif

"---< Fin de fichier >----------------------------------------------------------

