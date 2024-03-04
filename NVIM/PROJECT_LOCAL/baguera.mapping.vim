if ( exists( "g:VM_terminalUsage" ) == 0 )
nmap <M-F1> :call BG_SelectDebug()<CR>
else
nmap <Esc><F1> :call BG_SelectDebug()<CR>
endif
