" Fichier : graphicMapping.vim
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

execute "nmap <M-F1> :split " . g:VM_projectDirShell . "/VIM_SQLShell." . g:VM_projectDBExtension . "<CR>G"
nmap <S-F2> :vimgrep /<C-R>// 
nmap <M-F2> :vimgrep /<C-R>*/ 
vmap <F2> y<M-F2>
nmap <M-F3> :call VM_BuildPath()<CR>
nmap <C-F2> :echo VM_ProjectAnalyze()<CR>
nmap <S-C-F2> :call VM_ProjectInitialize()<CR>
nmap <S-F3> :split<CR>:tjump <C-R><C-W><CR>
nmap <C-F3> :vsplit<>:tjump <C-R><C-F><CR>
nmap <C-S-F3> :split<CR>:tjump <C-R><C-F><CR>
vmap <S-F3> y:split<CR>:tjump <C-R>+<CR>
vmap <C-F3> y:vsplit<CR>:tjump /<C-R>+<CR>
vmap <C-S-F3> y:tabnew<CR>:tjump /<C-R>+<CR>
" Copier / Coller
"----------------
map <S-Insert> P
map <C-Insert> y
" Le mapping des touches pour la compile en dev et en prod
"---------------------------------------------------------
if ( exists( "g:VM_keypad" ) != 0 )
   nmap <kPlus> zo
   nmap <kMinus> zc
   nmap <S-kPlus> zO
   nmap <S-kMinus> zC
else
   nmap <PageDown> zo
   nmap <PageUp> zc
   nmap <S-PageDown> zO
   nmap <S-PageUp> zC
endif
" Pour le déplacement dans les tabs
"----------------------------------
nmap <C-TAB> :tabnext<CR>
nmap <S-C-TAB> :tabprevious<CR>
nmap <M-v> :vsplit<CR>
nmap <M-s> :split<CR>
nmap <M-c> :tabclose<CR>
nmap <M-t> :tabnew<CR>:tjump 
nmap <M-r> :tjump 
" Pour la completion automatique
"-------------------------------
imap <C-S-CR> <S-CR>s<C-CR>
imap <C-CR> <Esc>:call VM_Completion( expand( "<cword>" ) )<CR>/<@/<CR>v/@>/<CR><Right>
imap <S-CR> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <S-CR> /<@/<CR>v/@>/<CR><Right>
vmap <S-CR> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <C-S-CR> ?<@?<CR>nv/@>/<CR><Right>
vmap <C-S-CR> <Esc>?<@?<CR>nv/@>/<CR><Right>
vmap <C-CR> s<C-CR>
" Pour se déplacer dans les buffers
"----------------------------------
nmap <C-Up> <C-W><Up>
nmap <C-Left> <C-W><Left>
nmap <C-Down> <C-W><Down>
nmap <C-Right> <C-W><Right>
nmap <M-Up> <C-W>-
nmap <M-Left> <C-W><
nmap <M-Down> <C-W>+
nmap <M-Right> <C-W>>
nmap <M-m> 1<C-W>_1<C-W>\|
nmap <M-M> <C-W>_<C-W>\|
nmap <C-a> <C-W>=
nmap <C-A> <C-W>=
" Pour déplacer les fenêtres
"---------------------------
nmap <C-S-Left> <C-W>H<C-W>=
nmap <C-S-Up> <C-W>K<C-W>=
nmap <C-S-Right> <C-W>L<C-W>=
nmap <C-S-Down> <C-W>J<C-W>=
" Pour l'indentation
"-------------------
nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W
vmap <Tab> >mg'>V'g
vmap <S-Tab> <mg'>V'g
nmap <C-T> :tabnew<CR>
" Pour accéder au nom de fichier
"-------------------------------
cmap <F1> <C-R>=expand( "%" )<CR>
cmap <S-F1> <C-R>=expand( "%:r" )<CR>
cmap <F2> <C-R>=expand( "%:t" )<CR>
cmap <S-F2> <C-R>=expand( "%:t:r" )<CR>
cmap <F3> <C-R>=expand( "%:h" )<CR>
cmap <S-F3> <C-R>=expand( "%:p:h" )<CR>
cmap <F4> <C-R>=expand( "%:p" )<CR>
cmap <S-F4> <C-R>=expand( "%:p:r" )<CR>
" Pour utiliser l'édition hexadicimale
"-------------------------------------
nmap <F9> :let b:originFT = &ft<CR>:%!xxd<CR>:set ft=xxd<CR>
nmap <S-F9> :%!xxd -r<CR>:let &ft = b:originFT<CR>:unlet b:originFR<CR>
" Pour la gestion des buffers
"----------------------------
nmap <F7> :call VM_CommandTabs()<CR>
nmap <S-F7> :call VM_CommandBuffer()<CR>
nmap <C-F7> :call VM_SwitchTab()<CR>
nmap <M-F7> :call VM_MarkWindow()<CR>:call VM_CommandTabs()<CR>
" Le mapping pour se déplacer dans les folders
"---------------------------------------------
nmap <S-F4> [z
nmap <F4> ]z
nmap <C-S-F4> zk
nmap <C-F4> zj

"---< Fin de fichier >----------------------------------------------------------

