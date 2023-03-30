" Fichier : setting_python.vim
"
" But : Définition des settings des fichiers de syntaxe python
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
setlocal shiftwidth=4
setlocal tabstop=4
" Mapping pour ne plus utiliser d'accents
"----------------------------------------
imap <buffer> é e
vmap <buffer> é e
omap <buffer> é e
imap <buffer> è e
omap <buffer> è e
vmap <buffer> è e
imap <buffer> ç c
omap <buffer> ç c
vmap <buffer> ç c
imap <buffer> à a
omap <buffer> à a
vmap <buffer> à a
imap <buffer> ä a
omap <buffer> ä a
vmap <buffer> ä a
imap <buffer> â a
omap <buffer> â a
vmap <buffer> â a
imap <buffer> ë e
omap <buffer> ë e
vmap <buffer> ë e
imap <buffer> ê e
omap <buffer> ê e
vmap <buffer> ê e
imap <buffer> ï i
omap <buffer> ï i
vmap <buffer> ï i
imap <buffer> î i
omap <buffer> î i
vmap <buffer> î i
imap <buffer> ü u
omap <buffer> ü u
vmap <buffer> ü u
imap <buffer> û u
omap <buffer> û u
vmap <buffer> û u
imap <buffer> ö o
omap <buffer> ö o
vmap <buffer> ö o
imap <buffer> ô o
omap <buffer> ô o
vmap <buffer> ô o
imap <buffer> ù u
omap <buffer> ù u
vmap <buffer> ù u

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
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

