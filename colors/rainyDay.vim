" Fichier : rainyDay.vim
"
" But : Define the rainy day color scheme
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 05 déc. 2014
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

let g:colors_name = "rainyDay"

" Définition des couleurs spéciales
"----------------------------------
highlight clear StatusLine
highlight clear StatusLineNC
highlight clear sqlSpecial
highlight clear Transact
highlight clear TransactType
highlight clear LocalVar
highlight clear GlobalVar
highlight clear Procedure
highlight clear Function
highlight clear FoldColumn
highlight clear Folded

highlight StatusLine guibg=#4055b8 guifg=white
highlight StatusLineNC guibg=#585858 guifg=yellow
highlight sqlSpecial	guifg=White
highlight Transact guifg=#60d0ff
highlight TransactType guifg=#f0d0ff
highlight LocalVar guifg=#60ff90
highlight GlobalVar guifg=#fff070 gui=italic
highlight Procedure guifg=#ff90e0 gui=italic
highlight Function guifg=#ffd0ff gui=italic
highlight FoldColumn guifg=red guibg=#606060
highlight Folded guifg=yellow guibg=darkred

" Definition des couleurs
"------------------------
highlight clear Normal
highlight clear Comment
highlight clear Constant
highlight clear Special
highlight clear Identifier
highlight clear Statement
highlight clear PreProc
highlight clear Type
highlight clear Ignore
highlight clear Error
highlight clear Todo

highlight clear SpecialKey
highlight clear NonText
highlight clear Directory
highlight clear ErrorMsg
highlight clear WarningMsg
highlight clear IncSearch
highlight clear Search
highlight clear MoreMsg
highlight clear ModeMsg
highlight clear LineNr
highlight clear Question
highlight clear Title
highlight clear Visual
highlight clear VisualNOS
highlight clear WildMenu
highlight clear Cursor

highlight Normal guifg=#bac4ff guibg=Black
highlight Comment guifg=LightGray guibg=Black
highlight Constant guifg=LightRed guibg=Black
highlight Special guifg=LightCyan guibg=Black
highlight Identifier guifg=White guibg=Black
highlight Statement guifg=Yellow guibg=Black
highlight PreProc guifg=#ffc0b8 guibg=Black
highlight Type guifg=Orange guibg=Black
highlight Ignore guifg=LightBlue guibg=Black
highlight Error guifg=White guibg=Red
highlight Todo guifg=Yellow guibg=DarkBlue
highlight SpecialKey guifg=LightGreen guibg=Black
highlight NonText guifg=Blue guibg=Grey20
highlight Directory guifg=Yellow guibg=Black
highlight ErrorMsg guifg=LightRed guibg=Black
highlight WarningMsg guifg=Orange guibg=Black
highlight IncSearch guifg=LightGray guibg=Black
highlight Search guifg=Yellow guibg=Black
highlight MoreMsg guifg=LightGray guibg=Black
highlight ModeMsg guifg=Yellow guibg=Black
highlight LineNr guifg=Yellow guibg=DarkBlue
highlight Question guifg=Orange guibg=Black
highlight Title guifg=White guibg=DarkBlue
highlight Visual guifg=White guibg=Blue
highlight VisualNOS guifg=Yellow guibg=DarkBlue
highlight WildMenu guifg=White guibg=DarkBlue
highlight Cursor guifg=White guibg=Blue

"---< Fin de fichier >----------------------------------------------------------

