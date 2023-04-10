nmap <C-F9> :let g:VM_projectJavaBaseSource = "src/test/java"<CR>
nmap <M-F9> :let g:VM_projectJavaBaseSource = "src/main/java"<CR>
nmap <S-C-F9> :echo "Current base folder : [" . g:VM_projectJavaBaseSource . "]\n"<CR>

execute "nmap <M-F1> :split " . g:VM_projectDirShell . "/VIM_SQLShell.sql<CR>G"

nmap <S-F8> :call VM_ShowTags( function( "BNP_BuildBaseFolder" ), function( "BNP_BuildProjectName" ) )<CR>
nmap <C-F8> :call VM_BuildProjectImports( "^import " )<CR>


