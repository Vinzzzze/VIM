" Fichier : gvimrc
"
" But : Définition de la configuration graphique de VIM pour le compte courant
"
" Auteur : Vini "Cool Coyote" - coolcoyote@club-internet.fr
"-------------------------------
" Modification : VM - 05/10/2001
"    Définition de couleurs sympatiques pour utiliser la syntaxe SQL
"-------------------------------------------------------------------------------

if ( exists( "$TERM" ) != 0 )
   finish
endif

if ( ( exists( ":unlet" ) != 1 )&&( exists( "g:VM_terminalUsage" ) != 0 ) )
   unlet g:VM_terminalUsage
endif

" Définition des options graphiques : pas de menus ni de scroll bars, ni même de tool bar
" idem pour la souris, moins elle fonctionne plus je suis heureux, alors...
"----------------------------------------------------------------------------------------
set guioptions=a
set mouse=
set guicursor=n-v-c:block-Cursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor,r-cr:hor20-Cursor,sm:
set showtabline=0

let g:VM_projectCtrlEnter = "<C-CR>"

" Execute le local file definition
"---------------------------------
let s:localFileDef = substitute( localFileDefinitions, "/[^/]\\+$", "/glocal", "" )
if ( filereadable( expand( s:localFileDef . ".vim" ) ) != 0 )
   execute "source " . s:localFileDef . ".vim"
endif

if ( localExtension != "" && filereadable( expand( s:localFileDef . localExtension . ".vim" ) ) != 0 )
   execute "source " . s:localFileDef . localExtension . ".vim"
endif

call VM_ProjectEnterFile()
