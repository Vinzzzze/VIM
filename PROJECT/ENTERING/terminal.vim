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

tmap <buffer> <silent> <F1> <C-W>N
tmap <buffer> <silent> <F3> <C-W>:
tmap <buffer> <silent> <C-TAB> <C-W>:tabnext<CR>
tmap <buffer> <silent> <S-C-TAB> <C-W>:tabprevious<CR>
tmap <buffer> <silent> <M-v> <C-W>:vert new<CR>
tmap <buffer> <silent> <M-s> <C-W>:new<CR>
tmap <buffer> <silent> <M-t> <C-W>:tabnew<CR>:tjump 
tmap <buffer> <silent> <M-r> <C-W>:tabnew<CR>:tjump 
tmap <buffer> <silent> <C-Up> <C-W><Up>
tmap <buffer> <silent> <C-Left> <C-W><Left>
tmap <buffer> <silent> <C-Down> <C-W><Down>
tmap <buffer> <silent> <C-Right> <C-W><Right>
tmap <buffer> <silent> <M-Up> <C-W>-
tmap <buffer> <silent> <M-Left> <C-W><
tmap <buffer> <silent> <M-Down> <C-W>+
tmap <buffer> <silent> <M-Right> <C-W>>
tmap <buffer> <silent> <C-S-Left> <C-W>H<C-W>=
tmap <buffer> <silent> <C-S-Up> <C-W>K<C-W>=
tmap <buffer> <silent> <C-S-Right> <C-W>L<C-W>=
tmap <buffer> <silent> <C-S-Down> <C-W>J<C-W>=
tmap <buffer> <silent> <F7> <C-W>:call VM_CommandTabs()<CR>
tmap <buffer> <silent> <S-F7> <C-W>:call VM_CommandBuffer()<CR>
tmap <buffer> <silent> <C-F7> <C-W>:call VM_SwitchTab()<CR>
tmap <buffer> <silent> <M-F7> <C-W>:call VM_MarkWindow()<CR>:call VM_CommandTabs()<CR>
tmap <buffer> <silent> <C-V> <C-W>""
tmap <buffer> <silent> <C-P> <C-W>"
tmap <buffer> <silent> <M-M> <C-W>_<C-W>\|
tmap <buffer> <silent> <C-A> <C-W>=
tmap <buffer> <silent> <C-a> <C-W>=

"---< Fin de fichier >----------------------------------------------------------

