" Fichier : termMapping-rxvt-unicode-256color.vim
"
" But : The mapping for the rxvt file.
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

execute "nmap <Esc><F1> :split " . g:VM_projectDirShell . "/VIM_SQLShell." . g:VM_projectDBExtension . "<CR>G"
nmap <Esc>[24~ :vimgrep /<C-R>// 
nmap <Esc><F2> :vimgrep /<C-R>0/ 
vmap <F2> y:vimgrep /<C-R>0/ 
nmap <Esc>[12~ :echo VM_ProjectAnalyze()<CR>
nmap <S-C-F2> :call VM_ProjectInitialize()<CR>
nmap <Esc>[25~ :call VM_BuildPath()<CR>
nmap <Esc>[13~ :vsplit<>:tjump <C-R><C-F><CR>
vmap <Esc>[25~ y:split<CR>:tjump <C-R>+<CR>
vmap <Esc>[13~ y:vsplit<CR>:tjump /<C-R>+<CR>
nmap <Esc>[26~ [z
nmap <Esc>[14~ ]z
" Le mapping des touches pour la compile en dev et en prod
"---------------------------------------------------------
nmap <Esc>[6~ zo
nmap <Esc>[5~ zc
nmap <Esc>[8~ zO
nmap <Esc>[7~ zC
" Pour le déplacement dans les tabs
"----------------------------------
nmap <Esc>n :tabnext<CR>
nmap <Esc>p :tabprevious<CR>
nmap <Esc>c :tabclose<CR>
nmap <Esc>v :vsplit<CR>
nmap <Esc>l :split<CR>
nmap <Esc>t :tabnew<CR>:tjump<space>
nmap <Esc>r :tjump<space>
" Pour la completion automatique
"-------------------------------
imap <C-^> <Esc>:call VM_Completion( expand( "<cword>" ) )<CR>/<@/<CR>v/@>/<CR><Right>
imap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
imap  <C-@>s<C-^>
vmap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <Esc><CR> /<@/<CR>v/@>/<CR><Right>
nmap  ?<@?<CR>nv/@>/<CR><Right>
vmap  <Esc>?<@?<CR>nv/@>/<CR><Right>
vmap <C-^> s<C-CR>
" Pour se déplacer dans les buffers
"----------------------------------
nmap <Esc>Oa <C-W><Up>
nmap <Esc>Od <C-W><Left>
nmap <Esc>Ob <C-W><Down>
nmap <Esc>Oc <C-W><Right>
nmap <M-Up> <C-W>-
nmap <M-Left> <C-W><
nmap <M-Down> <C-W>+
nmap <M-Right> <C-W>>
nmap <Esc>m 1<C-W>_1<C-W>\|
nmap <Esc>M <C-W>_<C-W>\|
nmap <C-a> <C-W>=
nmap <C-A> <C-W>=
" Pour déplacer les fenêtres
"---------------------------
nmap <Esc>[d <C-W>H<C-W>=
nmap <Esc>[a <C-W>K<C-W>=
nmap <Esc>[c <C-W>L<C-W>=
nmap <Esc>[b <C-W>J<C-W>=
" Pour l'indentation
"-------------------
nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W
vmap <Tab> >mg'>V'g
vmap <S-Tab> <mg'>V'g
nmap <C-T> :tabnew<CR>
" Only for terminal
"------------------
nmap <Esc>[23~ :echo expand( "%" )<CR>
nmap § :q<CR>
" Pour accéder au nom de fichier
"-------------------------------
cmap <F1> <C-R>=expand( "%" )<CR>
cmap <Esc>[23~ <C-R>=expand( "%:r" )<CR>
cmap <F2> <C-R>=expand( "%:t" )<CR>
cmap <Esc>[24~ <C-R>=expand( "%:t:r" )<CR>
cmap <F3> <C-R>=expand( "%:h" )<CR>
cmap <Esc>[25~ <C-R>=expand( "%:p:h" )<CR>
cmap <F4> <C-R>=expand( "%:p" )<CR>
cmap <Esc>[26~ <C-R>=expand( "%:p:r" )<CR>
" Pour la gestion des buffers
"----------------------------
nmap <F7> :call VM_CommandTabs()<CR>
nmap <Esc>[31~ :call VM_CommandBuffer()<CR>
nmap <Esc>[18~ :call VM_SwitchTab()<CR>

"---< Fin de fichier >----------------------------------------------------------

