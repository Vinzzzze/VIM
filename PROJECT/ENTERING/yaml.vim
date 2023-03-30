" Fichier : setting_xml.vim
"
" But : Définition des settings des fichiers de syntaxe XML
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
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2

" Pour commenter / décommenter une zone
"--------------------------------------
vmap <buffer> <F2> <ESC>:call VM_CommentAtMinIndente( "# " )<CR>
vmap <buffer> <S-F2> :substitute /# //<CR>

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <C-F6> :setlocal foldmethod=indent<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>:setlocal foldcolumn=0<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldmethod=indent
      setlocal foldenable

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

