" Fichier : terminal.vim
"
" But : The definitions when entering in a terminal
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 14 janv. 2018
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

tmap <buffer> <silent> <Esc> <C-\><C-N>
tmap <buffer> <silent> <F1> <C-\><C-N>
tmap <buffer> <silent> <F3> <C-\><C-N>:
tmap <buffer> <silent> <C-TAB> <C-\><C-N>:tabnext<CR>
tmap <buffer> <silent> <S-C-TAB> <C-\><C-N>:tabprevious<CR>
tmap <buffer> <silent> <C-T> <C-\><C-N>:tabnew<CR>
tmap <buffer> <silent> <M-v> <C-\><C-N>:vert new<CR>
tmap <buffer> <silent> <M-s> <C-\><C-N>:new<CR>
tmap <buffer> <silent> <M-t> <C-\><C-N>:tabnew<CR>:tjump 
tmap <buffer> <silent> <M-r> <C-\><C-N>:tabnew<CR>:tjump 
tmap <buffer> <silent> <C-Up> <C-\><C-N><C-W><Up>
tmap <buffer> <silent> <C-Left> <C-\><C-N><C-W><Left>
tmap <buffer> <silent> <C-Down> <C-\><C-N><C-W><Down>
tmap <buffer> <silent> <C-Right> <C-\><C-N><C-W><Right>
tmap <buffer> <silent> <M-Up> <C-\><C-N><C-W>-a
tmap <buffer> <silent> <M-Left> <C-\><C-N><C-W><a
tmap <buffer> <silent> <M-Down> <C-\><C-N><C-W>+a
tmap <buffer> <silent> <M-Right> <C-\><C-N><C-W>>a
tmap <buffer> <silent> <C-S-Left> <C-\><C-N><C-W>H<C-W>=a
tmap <buffer> <silent> <C-S-Up> <C-\><C-N><C-W>K<C-W>=a
tmap <buffer> <silent> <C-S-Right> <C-\><C-N><C-W>L<C-W>=a
tmap <buffer> <silent> <C-S-Down> <C-\><C-N><C-W>J<C-W>=a
tmap <buffer> <silent> <F7> <C-\><C-N>:call VM_CommandTabs()<CR>
tmap <buffer> <silent> <S-F7> <C-\><C-N>:call VM_CommandBuffer()<CR>
tmap <buffer> <silent> <C-F7> <C-\><C-N>:call VM_SwitchTab()<CR>
tmap <buffer> <silent> <M-F7> <C-\><C-N>:call VM_MarkWindow()<CR>:call VM_CommandTabs()<CR>
tmap <buffer> <silent> <C-V> <C-\><C-O>y
tmap <buffer> <silent> <C-P> <C-\><C-O>p
tmap <buffer> <silent> <M-M> <C-\><C-N><C-W>_<C-W>\|a
tmap <buffer> <silent> <C-A> <C-\><C-N><C-W>=a
tmap <buffer> <silent> <C-a> <C-\><C-N><C-W>=a
tmap <buffer> <silent> <Esc><CR> <C-\><C-N>:call VM_CloseTerminal()<CR><C-D><C-D>

"---< Fin de fichier >----------------------------------------------------------

startinsert
