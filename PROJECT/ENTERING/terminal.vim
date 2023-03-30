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

tmap <buffer> <F1> <C-W>:
tmap <buffer> <C-Left> <C-W><Left>
tmap <buffer> <C-Up> <C-W><Up>
tmap <buffer> <C-Right> <C-W><Right>
tmap <buffer> <C-Down> <C-W><Down>
tmap <buffer> <F2> cds<CR>
tmap <buffer> <F3> cdm<CR>
tmap <buffer> <F8> updAll<CR>
tmap <buffer> <F4> commitAll<CR>
tmap <buffer> <F6> cdm && make<CR>
tmap <buffer> <S-F6> outLib<CR>
tmap <buffer> <C-T> <C-W>:tabnew<CR>
tmap <buffer> <C-TAB> <C-W>:tabnext<CR>
tmap <buffer> <S-C-TAB> <C-W>:tabprevious<CR>
tmap <buffer> <C-Esc> <C-W>N
tmap <buffer> <T-Esc> <C-W><C-C>

"---< Fin de fichier >----------------------------------------------------------

