" Fichier : _vimrc
"
" But : Définition de la configuration VIM pour le compte courant
"
" Auteur : Vini "Cool Coyote" - coolcoyote@noos.fr
"-------------------------------
" Modification : VM - 05/10/2001
"    Utilisation de la fonction VIM system pour masquer les commandes
"-------------------------------------------------------------------------------

let g:VM_terminalUsage = 1

" J'initialise les critères par défaut
"-------------------------------------
set nonumber
set nolist
" Définition des mots réservés include et define
"-----------------------------------------------
set define=#\\s*define
set include=#\\s*include
" Localisation des tags
"----------------------
set tagrelative
" Pas de passage à la ligne pour les lignes trop longues
"-------------------------------------------------------
set nowrap
" Pas de rafraichissement de l'affichage pendant les macros
"----------------------------------------------------------
set lazyredraw
" Visualisation des commandes
"----------------------------
set showcmd
" Signale les erreurs par un bip visuel
"--------------------------------------
set errorbells
set visualbell
" Je copie toujours vers le clipboard
"------------------------------------
set clipboard=unnamed
" Définition de l'historique utilisé
"-----------------------------------
set history=32
" L'affichage des fenêtres ne doit pas se modifier en fonction
" de l'ouverture de nouveau fichier
" Les nouvelles fenêtres sont ouvertes en bas
"-------------------------------------------------------------
set noequalalways
set splitbelow
set splitright
set switchbuf=split
" Mode de completion du fichier courant
"--------------------------------------
set wildmode=list:longest
set suffixes=_bak,.o,.info,.desc,.info,.swp,.obj,.class
" Appels récursifs de fonctions
"------------------------------
set maxfuncdepth=128
" Utilisation des fond noir
"--------------------------
set background=dark
" Je déclenche l'affichage de la syntaxe
"---------------------------------------
if ( exists( ":syntax" ) != 0 )
   syntax on
endif
" Je ne souligne pas la chaine recherchée
"----------------------------------------
set nohlsearch
set incsearch
let localUserName = ""
let localSubFolder = ""
let localExtension = ""
 
if ( exists( "$SUDO_USER" ) != 0 )
   let localUserName = substitute( $SUDO_USER, " \\+", "", "g" )
 
   if ( localUserName > "" )
      let localSubFolder = "/" . toupper( localUserName )
      let localExtension = "." . tolower( localUserName )
   endif " End IF there is a real sudo user
endif " End IF we are here following a sudo command

" Défini le répertoire de base de mon VIM
"----------------------------------------
let myVIMRep = "~/.local/share/nvim"
let localFileDefinitions="~/.config/nvim/local"

" Je note les commandes systeme utilisées par VIM dans la gestion des projets
"----------------------------------------------------------------------------
if ( $VIM == substitute( $VIM, "^[A-Za-z]:", "", "" ) )
   " Je défini le système utilisé : LINUX
   "-------------------------------------
   let VIM_REP_SEPARATOR = "/"
   " Définition des commandes système
   "---------------------------------
   let systemCommandListAllDirBegin = "echo system( \"ls -lR --color=none "
   let systemCommandListAllDirMid = " | grep -v CVS | grep -E -e \\\"^[^ ]+:$\\\" -e \\\"^dr[w-]x[r-][w-][x-][r-][w-][x-] \\\" | awk 'BEGIN { baseSearch = \\\""
   let systemCommandListAllDirEnd = "\\\"; currentRep = \\\"\\\"; } { if ( NF > 1 ) { printf( \\\"\\%s/\\%s\\\\n\\\", currentRep, $9 ); } else { currentRep = $1; sub( \\\":$\\\", \\\"\\\", currentRep ); sub( baseSearch, \\\"\\\", currentRep ); if ( currentRep == \\\"\\\" ) { currentRep = \\\".\\\"; } } }'"
   let systemSysCommandCurrentRep = "pwd"
   let systemCommandDeleteForce = "echo system( \"rm -f "
   let systemCommandChmodWrite = "echo system( \"chmod ug+w "
   let systemSysCommandChmodRead = "chmod ugo-wx "
else
   " Je défini le système utilisé : WINDAUBE
   "----------------------------------------
   let VIM_REP_SEPARATOR = "\\"
   " Définition des commandes système
   "---------------------------------
   let systemCommandListAllDirBegin = "echo system( \"rem "
   let systemCommandListAllDirMid = " & dir /AD /B "
   let systemCommandListAllDirEnd = ""
   let systemSysCommandCurrentRep = "cd"
   let systemCommandDeleteForce = "echo system( \"del /F "
   let systemCommandChmodWrite = "echo system( \"attrib -R "
   let systemSysCommandChmodRead = "attrib +R "
endif
" Répertoire de création de backup
"---------------------------------
execute "set backupdir=" . myVIMRep . "/backup"
set backupext=_bak
" Localisation des tags
"----------------------
let g:VM_projectCommonTags=myVIMRep . "/tags"
execute "set tags=tags,TAGS/tags,./tags,./TAGS/tags," . g:VM_projectCommonTags
" Répertoire des fichiers de swap
"--------------------------------
execute "set directory=" . myVIMRep . "/swap"
" Definition des fichiers des erreurs
"------------------------------------
execute "set errorfile=" . myVIMRep . "/errors/errors.err"
execute "set makeef=" . myVIMRep . "/errors/make##.err"
" L'art et la manière de terminer toutes les commandes
"-----------------------------------------------------
let systemEndCommand = " \" )"
" Définition des commandes système
"---------------------------------
let systemCommandBuildRep = "echo system( \"mkdir "
let systemCommandChmodRead = "echo system( \"" . systemSysCommandChmodRead
" Autorise les fichiers de SWAP
"------------------------------
set swapfile
" Force l'extention des noms de fichiers / répertoire / commande VIM
" comme sous KSH
"-------------------------------------------------------------------
set cedit=<C-x>
set wildchar=<Tab>
" Autorise le chargement d'un fichier de définition local
"--------------------------------------------------------
set exrc
" Définition du browser VIM
"--------------------------
let g:netrw_maxfilenamelen = 128
let g:netrw_liststyle = 1
let g:netrw_sort_sequence = "[\/]$,\.[ch]pp$,\.[ch]$,\.[a-np-z]$,*,\.info$,\.swp$,\.o$\.obj$,\.bak$"
" Configuration du project manager
"---------------------------------
let g:VM_projectDirSeparator = VIM_REP_SEPARATOR
" The complete option definition
"-------------------------------
set complete=.,w,t

" Allow cpp keywords in java
"---------------------------
let java_allow_cpp_keywords=1
let java_highlight_java=1
let java_highlight_mockito=1
 
let g:c_syntax_for_h = 1
 
set omnifunc=syntaxcomplete#Complete

set laststatus=2
set statusline=%<%f%h%m%r%=\ %{fugitive#statusline()}\ (%b\ 0x%B)\ -\ [%c%V]%l/%L

let php_folding = 2
let vimsyn_folding = "a"

" Load the debug terminal feature
"---------------------------------
packadd termdebug

" Execute le local file definition
"---------------------------------
if ( filereadable( expand( localFileDefinitions . ".vim" ) ) != 0 )
   execute "source " . localFileDefinitions . ".vim"
endif

if ( localExtension != "" && filereadable( expand( localFileDefinitions . localExtension . ".vim" ) ) != 0 )
   execute "source " . localFileDefinitions . localExtension . ".vim"
endif

" Annule la définition du répertoire de base de vim
"--------------------------------------------------
if ( exists( ":unlet" ) != 1 )
   unlet myVIMRep
endif

" Enable the filetype, but only the interesting one
"--------------------------------------------------
filetype on
filetype plugin off
filetype indent off
