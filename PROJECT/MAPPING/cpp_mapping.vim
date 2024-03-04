if ( exists( "g:VM_projectDBExtension" ) != 0 )
   nmap <S-F10> :execute "tabnew " . $BUILD_HOME . "/createAll." . g:VM_projectDBExtension<CR>
endif

nmap <C-F10> :tabnew<CR>:edit $BUILD_HOME/debug.out<CR>
nmap <F10> :execute "tabnew " . substitute( expand( "%:h" ), "\\\\.*", "", "" ) . "/fileList.xml"<CR>

if ( exists( "g:VM_terminalUsage" ) == 0 )
nmap <M-F1> :call VM_SelectDebug()<CR>
else
nmap <Esc><F1> :call VM_SelectDebug()<CR>
endif
