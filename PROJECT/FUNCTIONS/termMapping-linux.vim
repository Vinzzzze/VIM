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
nmap <F17> :call VM_ProjectBuildClass()<CR>
nmap <F5> :call VM_ProjectBuildFunction()<CR>
nmap <C-A> <C-W>=
nmap <PageDown> zo
nmap <PageUp> zc
nmap <Tab><PageDown> zO
nmap <Tab><PageUp> zC
" Pour ne laisser qu'une seule fenêtre ouverte
"---------------------------------------------
nmap <F1> :help<CR>
nmap <F13> :echo expand( "%" )<CR>
vmap <F1> y:help <C-R>+<CR>
nmap <F3> :vsplit<CR>:tjump <C-R><C-W><CR>
vmap <F3> y:vsplit<CR>:tjump <C-R>+<CR>
nmap <F18> :call VM_BuildPath()<CR>
nmap <F16> :echo VM_ProjectAnalyze()<CR>
nmap <Tab><F4> :call VM_ProjectInitialize()<CR>
" Pour les recherches dans les fichiers du projet
"------------------------------------------------
nmap <F2> :vimgrep /
nmap <F14> :vimgrep /<C-R>// 
vmap <F2> y:vimgrep /<C-R>0/ 
" Pour se déplacer dans les buffers
"----------------------------------
nmap <Tab>l <C-W>k
nmap <Tab>s <C-W>h
nmap <Tab>h <C-W>j
nmap <Tab>n <C-W>l
" Pour déplacer les fenêtres
"---------------------------
nmap <Tab>L <C-W>K<C-W>=
nmap <Tab>S <C-W>H<C-W>=
nmap <Tab>H <C-W>J<C-W>=
nmap <Tab>N <C-W>L<C-W>=

" Pour l'indentation
"-------------------
vmap <Tab>> >mg'>V'g
vmap <Tab>< <mg'>V'g
nmap <C-T> :tabnew<CR>

" Pour le déplacement dans les tabs
"----------------------------------
nmap <TAB>+ :tabnext<CR>
nmap <TAB>- :tabprevious<CR>

" Pour la gestion des buffers
"----------------------------
nmap <F7> :call VM_CommandTabs()<CR>
nmap <Tab><F7> :call VM_CommandBuffer()<CR>
nmap <F19> :call VM_SwitchTab()<CR>

execute "nmap " . nr2char( 167 ) . " :q<CR>"
" Pour la conversion des dates excel
"-----------------------------------
nmap <C-K> :echo "Date : " . VM_ProjectCalculExcelDate( expand( "<cword>" ) )<CR>
" Pour recharger un fichier
"--------------------------
nmap <F6> G:e<CR>
" Pour utiliser l'édition hexadicimale
"-------------------------------------
nmap <F9> :let b:originFT = &ft<CR>:%!xxd<CR>:set ft=xxd<CR>
nmap <Tab><F9> :%!xxd -r<CR>:let &ft = b:originFT<CR>:unlet b:originFR<CR>
" Pour accéder au nom de fichier
"-------------------------------
cmap <F1> <C-R>=expand( "%" )<CR>
cmap <F13> <C-R>=expand( "%:r" )<CR>
cmap <F2> <C-R>=expand( "%:t" )<CR>
cmap <F14> <C-R>=expand( "%:t:r" )<CR>
cmap <F3> <C-R>=expand( "%:h" )<CR>
cmap <F15> <C-R>=expand( "%:p:h" )<CR>
cmap <F4> <C-R>=expand( "%:p" )<CR>
cmap <F16> <C-R>=expand( "%:p:r" )<CR>
" Pour la completion automatique
"-------------------------------
imap <C-Space> <Esc>:call VM_Completion( expand( "<cword>" ) )<CR>/<@/<CR>v/@>/<CR>l
nmap <C-Space> /<@/<CR>v/@>/<CR>l
vmap <C-Space> <Esc>/<@/<CR>v/@>/<CR>l
vmap <Tab><Space> s<C-CR>
" Pour passer en mode explorer
"-----------------------------
nmap <F8> :Explore<CR>

if ( &diff != 0 )
   nmap <Home> [c
   nmap <End> ]c
endif " End IF we are in a diff view

tmap <buffer> <silent> <Esc><CR> <C-W>:call VM_CloseTerminal()<CR><C-D><C-D>

"---< Fin de fichier >----------------------------------------------------------

