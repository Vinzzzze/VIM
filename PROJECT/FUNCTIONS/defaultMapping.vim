" Fichier : defaultMapping.vim
"
" But : The default mapping when moving to a new file.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 01 May 2023
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

" Pour la création de fichiers
"-----------------------------
nmap <M-F5> :call VM_ProjectBuildAlternateFunction()<CR><CR>
nmap <S-F5> :call VM_ProjectBuildClass()<CR>
nmap <F5> :call VM_ProjectBuildFunction()<CR>
" Pour ne laisser qu'une seule fenêtre ouverte
"---------------------------------------------
nmap <F1> :help<CR>
nmap <S-F1> :execute "help " . expand( "<cword>" )<CR>
vmap <F1> y:help <C-R>+<CR>
nmap <C-F1> :execute "vsplit " . expand( "<cWORD>" )<CR>
nmap <S-C-F1> :execute "split " . expand( "<cWORD>" )<CR>
nmap <T-F1> :vert terminal<CR>
nmap <S-T-F1> :terminal<CR>
nmap <C-T-F1> :tabnew<CR>:terminal<CR><C-W>w:q<CR>
nmap <F3> :vsplit<CR>:tjump <C-R><C-W><CR>
vmap <F3> y:vsplit<CR>:tjump <C-R>+<CR>
cmap <F3> <C-R><C-W>
cmap <S-F3> <C-R><C-A>
cmap <C-F3> <C-R><C-F>
nmap <M-F8> :find 
vmap <M-F8> y:find <C-R>+<Tab>
" Pour les recherches dans les fichiers du projet
"------------------------------------------------
nmap <F2> :vimgrep /

execute "nmap " . nr2char( 167 ) . " :q<CR>"
" Pour la conversion des dates excel
"-----------------------------------
nmap <C-K> :echo "Date : " . VM_ProjectCalculExcelDate( expand( "<cword>" ) )<CR>
" Pour recharger un fichier
"--------------------------
nmap <F6> G:e<CR>
" Pour passer en mode explorer
"-----------------------------
nmap <F8> :Explore<CR>

if ( &diff != 0 )
   nmap <S-Up> [c
   nmap <S-Down> ]c
endif " End IF we are in a diff view

"---< Fin de fichier >----------------------------------------------------------

