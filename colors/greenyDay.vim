" Fichier : greenyDay.vim
"
" But : Define the greeny day color scheme
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

let g:colors_name = "greenyDay"

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

highlight StatusLine guibg=#700000 guifg=yellow
highlight StatusLineNC guibg=#606060 guifg=#c0c000
highlight LocalVar guifg=#60ff90
highlight GlobalVar guifg=#f0ff70 gui=italic
highlight Procedure guifg=#90ffe0 gui=italic
highlight Function guifg=#d0ffff gui=italic
highlight FoldColumn guifg=green guibg=#606060
highlight Folded guifg=#a0ffa0 guibg=#105010

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

highlight Normal guifg=#baffc4 guibg=Black
highlight String guifg=#ff88c8 guibg=Black
highlight Comment guifg=LightGray guibg=Black
highlight Constant guifg=LightRed guibg=Black
highlight Special guifg=LightCyan guibg=Black
highlight Identifier guifg=White guibg=Black
highlight Statement guifg=#80ff80 guibg=Black
highlight PreProc guifg=#ffc0b8 guibg=Black
highlight Type guifg=Cyan guibg=Black
highlight Ignore guifg=#a0ffa0 guibg=Black
highlight Error guifg=White guibg=Red
highlight Todo guifg=#80ff80 guibg=DarkGreen
highlight SpecialKey guifg=#a0ffa0 guibg=Black
highlight NonText guifg=Grey10 guibg=Grey10
highlight Directory guifg=#80ff80 guibg=Black
highlight ErrorMsg guifg=LightRed guibg=Black
highlight WarningMsg guifg=Cyan guibg=Black
highlight IncSearch guifg=Orange guibg=Black
highlight Search guifg=Orange guibg=Black
highlight MoreMsg guifg=LightGray guibg=Black
highlight ModeMsg guifg=#80ff80 guibg=Black
highlight LineNr guifg=#80ff80 guibg=DarkGreen
highlight Question guifg=Cyan guibg=Black
highlight Title guifg=White guibg=DarkGreen
highlight Visual guifg=White guibg=DarkGreen
highlight VisualNOS guifg=#80ff80 guibg=DarkGreen
highlight WildMenu guifg=White guibg=DarkGreen
highlight Cursor guifg=Black guibg=Yellow
highlight CursorLine guibg=#400000

"---< Fin de fichier >----------------------------------------------------------

