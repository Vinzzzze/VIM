" Fichier : termMapping-xterm.vim
"
" But : The mapping for the xterminal file.
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

execute "nmap <Esc>[1;3P :split " . g:VM_projectDirShell . "/VIM_SQLShell." . g:VM_projectDBExtension . "<CR>G"
nmap <Esc>[1;2Q :vimgrep /<C-R>// 
nmap <Esc>[1;3Q :vimgrep /<C-R>0/ 
vmap <F2> y:vimgrep /<C-R>0/ 
nmap <Esc>[1;3R :call VM_BuildPath()<CR>
nmap <Esc>[1;5Q :echo VM_ProjectAnalyze()<CR>
nmap <Esc>[1;6Q :call VM_ProjectInitialize()<CR>
nmap <Esc>[1;2R :split<CR>:tjump <C-R><C-W><CR>
nmap <Esc>[1;5R :vsplit<>:tjump <C-R><C-F><CR>
nmap <Esc>[1;6R :split<CR>:tjump <C-R><C-F><CR>
vmap <Esc>[1;2R y:split<CR>:tjump <C-R>+<CR>
vmap <Esc>[1;5R y:vsplit<CR>:tjump /<C-R>+<CR>
vmap <Esc>[1;6R y:tabnew<CR>:tjump /<C-R>+<CR>
nmap <Esc>[1;2S [z
nmap <Esc>[1;5S ]z
" Le mapping des touches pour la compile en dev et en prod
"---------------------------------------------------------
nmap <Esc>[6~ zo
nmap <Esc>[5~ zc
nmap <Esc>[6;2~ zO
nmap <Esc>[5;2~ zC
" Pour le déplacement dans les tabs
"----------------------------------
nmap <Esc><Tab> :tabnext<CR>
nmap <Esc>[Z :tabprevious<CR>
nmap <Esc>c :tabclose<CR>
nmap <Esc>v :vsplit<CR>
nmap <Esc>s :split<CR>
nmap <Esc>t :tabnew<CR>:tjump<space>
nmap <Esc>r :tjump<space>
" Pour la completion automatique
"-------------------------------
call VM_MapCtrlEnter( "i", "", "<Esc>:call VM_Completion( expand( \"<cword>\" ) )<CR>/<@/<CR>v/@>/<CR><Right>" )
imap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
imap  <C-@>s<C-^>
vmap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <Esc><CR> /<@/<CR>v/@>/<CR><Right>
nmap  ?<@?<CR>nv/@>/<CR><Right>
vmap  <Esc>?<@?<CR>nv/@>/<CR><Right>
vmap <C-^> s<C-CR>
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
" Only for terminal
"------------------
nmap <Esc>[1;2P :echo expand( "%" )<CR>
" Pour accéder au nom de fichier
"-------------------------------
cmap <F1> <C-R>=expand( "%" )<CR>
cmap <Esc>[1;2P <C-R>=expand( "%:r" )<CR>
cmap <F2> <C-R>=expand( "%:t" )<CR>
cmap <Esc>[1;2Q <C-R>=expand( "%:t:r" )<CR>
cmap <F3> <C-R>=expand( "%:h" )<CR>
cmap <Esc>[1;2R <C-R>=expand( "%:p:h" )<CR>
cmap <F4> <C-R>=expand( "%:p" )<CR>
cmap <Esc>[1;2S <C-R>=expand( "%:p:r" )<CR>
" Pour la gestion des buffers
"----------------------------
nmap <F7> :call VM_CommandTabs()<CR>
nmap <Esc>[31~ :call VM_CommandBuffer()<CR>
nmap <Esc>[18;5~ :call VM_SwitchTab()<CR>

"---< Fin de fichier >----------------------------------------------------------

