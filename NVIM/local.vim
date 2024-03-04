" Fichier : .vimrclocal
"
" But : Définition de la configuration VIM pour le compte courant
"
" Auteur : Vini "Cool Coyote" - coolcoyote@noos.fr
"-------------------------------

set clipboard=unnamedplus

" Configuration du project manager
"---------------------------------
let g:VM_projectDirShell = "~/.VIMOUT/SHELL"
let g:VM_projectDBExtension = "psql"
let g:VM_projectIndentation = "   "
let g:VM_projectFileFormat = "unix"
let g:VM_todoClassOpen = "~/.vim/TODO_CLASS"
let g:CPPInlineCode = "VM_INLINE "
let g:SQL_projectIndentation = "	"
let g:JAVA_projectIndentation = "   "
let g:XML_projectIndentation = "	"
let g:VM_dirSeparator = "/"

let s:VM_projectLocalDir = "~/.VIMPROJECT_LOCAL"
let g:VM_projectLocalDirEnterFile = s:VM_projectLocalDir . "/ENTERING"
let g:VM_projectLocalDirLeaveFile = s:VM_projectLocalDir . "/LEAVING"

let g:VM_projectListFileStart = "ls -l 2>/dev/null "
let g:VM_projectListFileEnd = " | grep -v \"^ls: \" | grep \"^-\""
let g:VM_projectBaseProjects = "~/SOURCES"
let g:VM_projectVIMBaseProjects = "~/SOURCES"
let g:VM_projectVIMBuildFolder = "~/BUILD"

" Distant configuration
"----------------------
let g:VM_distantMachineName = "thrash"
let g:VM_distantUserName = "coolcoyote"
let g:VM_distantFolderBase = "/home/ARCHIVE/"
let g:VM_distantFolderMake = "GENERATE/"
let g:VM_distantFolderType = "UNIX"
let g:VM_projectBuildFolder = "~/BUILD/"
let g:VM_projectGlobalCreation = ["echo system( \"sh -l -c 'ssh \" . g:VM_distantMachineName . \" git init --bare \" . g:VM_distantFolderBase . projectName . \"'\" )", "echo system( \"sh -l -c \\\"git clone ssh://\" . g:VM_distantUserName . \"@\" . g:VM_distantMachineName . \":\" . g:VM_distantFolderBase . projectName . \" \" . g:VM_projectBaseProjects . \"/\" . projectName . \"\\\"\" )"]
let g:VM_distantListDirStart = "sh -l -c 'ssh " . g:VM_distantMachineName . " ls -l 2>/dev/null "
let g:VM_distantListDirEnd = "' | grep \"^d\" | grep -v GENERATE"

" The shell command to be run
"----------------------------
let g:VM_projectShellExecute = "sh -l -c"
let g:VM_classConflatedNew = "new\nwincmd J"

" Configuration SQL
"------------------
let g:POSTGRE_SQLCommand = "psql -h"
let g:MYSQL_SQLCommand = "mysql "

let g:VM_listCmdPathBuild = ["let s:dirList = split( system( \"/bin/ls 2>/dev/null -R\" . g:VM_pathBuildBase ), expand( \"<CR>\" ) )", "call filter( s:dirList, 'v:val =~ \":\"' )", "call filter( s:dirList, 'v:val !~ \"\\\\.[a-zA-Z]\\\\+\"' )", "let g:VM_globalPath = substitute( substitute( substitute( substitute( join( s:dirList ), \"\\\\\", \"/\", \"g\" ), \": \", \",\", \"g\" ), \":$\", \"\", \"\" ), \"\\\\./\", \"\", \"g\" )"]
let g:VM_projectListDirStart = "/bin/ls -l 2>/dev/null "
let g:VM_projectMkDir = "mkdir -p"

" Définition du nom de l'utilisateur courant
"-------------------------------------------
let $USER_NAME = "VM \"Cool Coyote\""
let $ADDRESS_EMAIL = "coolcoyote358@gmail.com"

" Clavier BÉPO
"-------------
let g:VM_bepoUsage = 1
let g:VM_projectCtrlEnter = "<C-X>"

" Color scheme
"-------------
colorscheme vinceounoursTerm

if ( $TERM == "linux" )
   let g:VM_projectCtrlEnter = "<C-Space>"
   call VM_ProjectEnterFile()
endif " End IF I am on a console mode
