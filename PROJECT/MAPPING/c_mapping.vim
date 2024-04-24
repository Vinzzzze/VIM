" Fichier : c_mapping.vim
"
" But : Define the mapping used for the C project.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 10 août 2016
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

if ( exists( "g:VM_projectDBExtension" ) != 0 )
   nmap <S-F10> :execute "tabnew " . $BUILD_HOME . "/createAll." . g:VM_projectDBExtension<CR>
endif

nmap <M-F10> :edit $BUILD_HOME/make.out<CR>
nmap <C-F10> :edit $BUILD_HOME/debug.out<CR>
nmap <F10> :call VM_OpenProjectFileDescription( g:VM_projectDefinitionFilename, "tabnew" )<CR>
nmap <C-F8> :call VM_ShowTags( function( "VM_BuildBaseFolderDefault" ), function( "C_DictionnaryName" ) )<CR>
nmap <F6> :call VM_GitBranchSelect( 0 )<CR>

if ( ( expand( "%:e" ) == "str" )||( expand( "%:e" ) == "typ" ) )
   nmap <C-F5> :call VM_ProjectBuildClass()<CR>cdesc<CR>
elseif ( ( substitute( expand( "%:t:r" ), "^bldr_Export.*Description.*", "", "" ) == "" )&&( expand( "%:e" ) == "c" ) )
   nmap <C-F5> :call C_BuildExportDescriptionArray()<CR>
else
   nmap <C-F5> :call VM_OpenTabLanguage()<CR>lang<CR>
   imap <C-F5> <Esc>:call VM_OpenTabLanguage()<CR>lang<CR>
endif

if ( substitute( expand( "%:t:r" ), "Conflated$", "", "" ) == expand( "%:t:r" ) )
   nmap <M-F5> :call VM_ProjectBuildClass()<CR>conflated<CR>
endif

if ( exists( "*CLASS_OpenFile" ) != 0 )
   nmap <C-F4> :call CLASS_OpenFile( input( "Class to open : " ) )<CR>
   nmap <M-F3> :call CLASS_OpenFile( expand( "<cword>" ) )<CR>
endif

if ( exists( "g:VM_terminalUsage" ) == 0 )
nmap <M-F1> :call VM_SelectDebug()<CR>
else
nmap <Esc><F1> :call VM_SelectDebug()<CR>
endif

"---< Fin de fichier >----------------------------------------------------------

