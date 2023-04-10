if ( exists( "g:VM_projectDBExtension" ) != 0 )
   nmap <S-F10> :execute "tabnew " . $BUILD_HOME . "/createAll." . g:VM_projectDBExtension<CR>
endif

nmap <C-F10> :tabnew<CR>:edit $BUILD_HOME/debug.out<CR>
nmap <F10> :execute "tabnew " . substitute( expand( "%:h" ), "\\\\.*", "", "" ) . "/fileList.xml"<CR>
nmap <C-F9> :let g:VM_projectJavaBaseSource = "src/test/java"<CR>
nmap <M-F9> :let g:VM_projectJavaBaseSource = "src/main/java"<CR>
nmap <S-C-F9> :echo "Current base folder : [" . g:VM_projectJavaBaseSource . "]\n"<CR>

execute "nmap <M-F1> :split " . g:VM_projectDirShell . "/VIM_SQLShell." . g:VM_projectDBExtension . "<CR>G"

