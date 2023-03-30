" Fichier : setting_python.vim
"
" But : D�finition des settings des fichiers de syntaxe python
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

" Red�finition des tabulations
"-----------------------------
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
" Mapping pour ne plus utiliser d'accents
"----------------------------------------
imap <buffer> � e
vmap <buffer> � e
omap <buffer> � e
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � c
omap <buffer> � c
vmap <buffer> � c
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � a
omap <buffer> � a
vmap <buffer> � a
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � e
omap <buffer> � e
vmap <buffer> � e
imap <buffer> � i
omap <buffer> � i
vmap <buffer> � i
imap <buffer> � i
omap <buffer> � i
vmap <buffer> � i
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u
imap <buffer> � o
omap <buffer> � o
vmap <buffer> � o
imap <buffer> � o
omap <buffer> � o
vmap <buffer> � o
imap <buffer> � u
omap <buffer> � u
vmap <buffer> � u

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour d�clancher/arr�ter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <F6> :setlocal foldmethod=indent<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=indent

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

