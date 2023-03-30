" Fichier : setting_vim.vim
"
" But : Définition des settings des fichiers de syntaxe VIM.
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

" Je ne gère que des fichier UNIX, c'est moins risqué
"----------------------------------------------------
if ( &modifiable != 0 )
   setlocal fileformat=unix
endif

call VM_AddDictionary( g:VM_projectDirDictionary . "/vimFunctions.dic" )
call VM_AddDictionary( g:VM_projectDirDictionary . "/vimVariables.dic" )
call VM_AddDictionary( g:VM_projectDirDictionary . "/vimOptions.dic" )
call VM_AddDictionary( g:VM_projectDirDictionary . "/vimCommand.dic" )
call VM_AddDictionary( g:VM_projectDirDictionary . "/vimCompletion.dic" )

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   nmap <buffer> <C-F6> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=syntax

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

