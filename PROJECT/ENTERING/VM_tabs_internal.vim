" Fichier : VM_tabs_internal.vim
"
" But : Describe the actions associated to the buffer display.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 22 sept. 2014
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

call VM_ProjectExecuteEnteringFile( "VM_project_internal" )

setlocal winfixheight
setlocal cursorline
setlocal nomodifiable
setlocal readonly

mapclear

nmap <buffer> <CR> :call VM_DisplayCorrespondingBufferTabs()<CR>
nmap <buffer> ง :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> ยง :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
nmap <buffer> <C-Right> :wincmd l<CR>
nmap <buffer> <C-Left> <C-L>
nmap <buffer> <Right> :wincmd l<CR>
nmap <buffer> <Left> <C-L>
nmap <buffer> <Up> k^
nmap <buffer> <Down> j^
nmap <buffer> i <C-L>
nmap <buffer> I <C-L>
nmap <buffer> a <C-L>
nmap <buffer> A <C-L>
nmap <buffer> o <C-L>
nmap <buffer> O <C-L>
nmap <buffer> 1 :2<CR>
nmap <buffer> 2 :3<CR>
nmap <buffer> 3 :4<CR>
nmap <buffer> 4 :5<CR>
nmap <buffer> 5 :6<CR>
nmap <buffer> 6 :7<CR>
nmap <buffer> 7 :8<CR>
nmap <buffer> 8 :9<CR>
nmap <buffer> 9 :10<CR>
nmap <buffer> 0 :1<CR>

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> <Esc><Esc> :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :close<CR>:close<CR>:call VM_BackToOriginalWindow()<CR>
endif " End IF we are using a gui version

"---< Fin de fichier >----------------------------------------------------------

