" Fichier : terminal.vim
"
" But : The mapping used on a sinmple terminal
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 23 Aug 2018
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

nmap <Esc>[6~ zo
nmap <Esc>[5~ zc
nmap <Esc>[6;2~ zO
nmap <Esc>[5;2~ zC

nmap <Esc>[1;5I :tabnext<CR>
nmap <Esc>[1;6I :tabprev<CR>
nmap <Esc>c :tabclose<CR>
nmap <Esc>v :vsplit<CR>
nmap <Esc>s :split<CR>
nmap <Esc>t :tabnew<CR>:jump<space>
nmap <Esc>r :jump<space>

imap <C-^> <Esc>:call VM_Completion( expand( "<cword>" ) )<CR>/<@/<CR>v/@>/<CR><Right>
imap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
imap <9e> <C-@>s<C-^>
vmap <Esc><CR> <Esc>/<@/<CR>v/@>/<CR><Right>
nmap <Esc><CR> /<@/<CR>v/@>/<CR><Right>
nmap <9e> ?<@?<CR>nv/@>/<CR><Right>
vmap <9e> <Esc>?<@?<CR>nv/@>/<CR><Right>
vmap <C-^> s<C-CR>
nmap <C-C> :quit<CR>

let g:VM_terminalUsage=1

"---< Fin de fichier >----------------------------------------------------------

