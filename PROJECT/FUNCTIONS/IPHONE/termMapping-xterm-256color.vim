" Fichier : termMapping-xterm-256color.vim
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

nmap æ :echo VM_ProjectAnalyze()<CR>
nmap Â :split<CR>:tjump <C-R><C-W><CR>
nmap ê :vsplit<CR>:tjump <C-R><C-F><CR>
vmap Â y:split<CR>:tjump <C-R>+<CR>
vmap ê y:vsplit<CR>:tjump <C-R>+<CR>
" Pour le déplacement dans les tabs
"----------------------------------
nmap <Tab><Down> :tabnext<CR>
nmap <Tab><Up> :tabprevious<CR>
nmap ◊ :vsplit<CR>
nmap Ò :split<CR>
nmap © :tabclose<CR>
nmap † :tabnew<CR>:tjump 
nmap ® :tjump 
" Pour la completion automatique
"-------------------------------
imap <C-C><Up> <C-C><Down>s<C-C><CR>
imap <C-C><CR> <Esc>:call VM_Completion( expand( "<cword>" ) )<CR>/<@/<CR>v/@>/<CR><Right>
imap <C-C><Down> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <C-C><Down> /<@/<CR>v/@>/<CR><Right>
vmap <C-C><Down> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <C-C><Up> ?<@?<CR>nv/@>/<CR><Right>
vmap <C-C><Up> <Esc>?<@?<CR>nv/@>/<CR><Right>
vmap <C-C><CR> s<C-C><CR>
" Pour se déplacer dans les buffers
"----------------------------------
nmap k <C-W><Up>
nmap h <C-W><Left>
nmap j <C-W><Down>
nmap l <C-W><Right>
nmap µ 1<C-W>_1<C-W>\|
nmap Ó <C-W>_<C-W>\|
nmap <C-a> <C-W>=
nmap <C-A> <C-W>=
" Pour déplacer les fenêtres
"---------------------------
nmap H <C-W>H<C-W>=
nmap K <C-W>K<C-W>=
nmap L <C-W>L<C-W>=
nmap J <C-W>J<C-W>=
" Pour l'indentation
"-------------------
nmap <Tab><Right> <C-W>w
nmap <Tab><Left> <C-W>W
vmap <Tab><Right> >mg'>V'g
vmap <S-Tab><Left> <mg'>V'g
nmap <C-T> :tabnew<CR>
" Pour accéder au nom de fichier
"-------------------------------
cmap <C-F> <C-R>=expand( "%" )<CR>
cmap <C-G> <C-R>=expand( "%:r" )<CR>
cmap <C-N> <C-R>=expand( "%:t" )<CR>
cmap <C-S> <C-R>=expand( "%:t:r" )<CR>
cmap <C-J> <C-R>=expand( "%:h" )<CR>
cmap <C-D> <C-R>=expand( "%:p:h" )<CR>
cmap <C-E> <C-R>=expand( "%:p" )<CR>
cmap <C-U> <C-R>=expand( "%:p:r" )<CR>
" Pour utiliser l'édition hexadicimale
"-------------------------------------
nmap <C-H> :let b:originFT = &ft<CR>:%!xxd<CR>:set ft=xxd<CR>
nmap <C-Q> :%!xxd -r<CR>:let &ft = b:originFT<CR>:unlet b:originFR<CR>
" Pour la gestion des buffers
"----------------------------
nmap <C-O> :call VM_CommandTabs()<CR>
nmap <C-X> :call VM_SwitchTab()<CR>

"---< Fin de fichier >----------------------------------------------------------

