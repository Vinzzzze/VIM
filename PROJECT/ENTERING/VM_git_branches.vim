" Fichier : VM_git_branches.vim
"
" But : The process done while opening the branch managment window
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 15 Aug 2017
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

autocmd InsertLeave <buffer> call VM_ValidateBranchUpdate()

mapclear

nmap <buffer> <CR> :call VM_UseBranch( line( "." ) - 1, 1 )<CR>
nmap <buffer> <S-CR> :call VM_UseBranch( line( "." ) - 1, 1 )<CR>
nmap <buffer> ง :call VM_CloseBranchWindow( 1 )<CR>
nmap <buffer> ยง :call VM_CloseBranchWindow( 1 )<CR>
nmap <buffer> o :call VM_CreateBranch( 1, 0 )<CR>
nmap <buffer> O :call VM_CreateBranch( 1, 1 )<CR>
nmap <buffer> zz :call VM_SaveBranches( 1 )<CR>
nmap <buffer> Z :call VM_SaveBranches( 1 )<CR>
nmap <buffer> dd :call VM_DeleteBranch( line( "." ), 0 )<CR>
nmap <buffer> D :call VM_DeleteBranch( line( "." ), 1 )<CR>

if ( ( exists( "g:VM_terminalUsage" ) != 0 )&&( g:VM_terminalUsage != 0 ) )
   nmap <buffer> <Esc><Esc> :call VM_CloseBranchWindow( 1 )<CR>
else " End IF we are using a terminal
   nmap <buffer> <Esc> :call VM_CloseBranchWindow( 1 )<CR>
endif " End IF we are using a gui version

"---< Fin de fichier >----------------------------------------------------------

