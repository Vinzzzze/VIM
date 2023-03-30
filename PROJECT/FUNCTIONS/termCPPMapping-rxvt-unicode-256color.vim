" Fichier : termCPPMapping-rxvt-unicode-256color.vim
"
" But : The mapping CPP for the rxvt file.
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

" Pour la création des accolades
"-------------------------------
imap <buffer> <C-]> {<CR>} // End <ESC>O<TAB>
" Pour la creation automatique des get et set des attributs
"----------------------------------------------------------
nmap <buffer> <F9> :call CreateGetSet( line( "." ) )<CR>
nmap <buffer> <Esc>[33~ :call CreateGet( line( "." ) )<CR>
" Pour l'utilisation de la fonction qui permet de passer du header au body et reciproquement
"-------------------------------------------------------------------------------------------
nmap <buffer> <Esc>[32~ :call CPPOpenAlternate( "vsplit" )<CR>
nmap <buffer> <Esc>[19~ :call CPPOpenAlternate( "split" )<CR>
" Pour commenter / décommenter une zone
"--------------------------------------
vmap <buffer> <F4> <ESC>:call VM_CommentAtMinIndente( "// " )<CR>
vmap <buffer> <Esc>[26~ :substitute /\/\/ //<CR>

"---< Fin de fichier >----------------------------------------------------------

