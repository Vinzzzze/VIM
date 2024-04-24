" Fichier : vinceounousTerm.vim
"
" But : Colors for terminal usage
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 28 janv. 2018
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

let g:colors_name = "vinceounoursTerm"

" Définition des couleurs spéciales
"----------------------------------
highlight clear StatusLine
highlight clear StatusLineNC
highlight clear StatusLineTerm
highlight clear StatusLineTermNC
highlight clear sqlSpecial
highlight clear Transact
highlight clear TransactType
highlight clear LocalVar
highlight clear GlobalVar
highlight clear Procedure
highlight clear Function
highlight clear FoldColumn
highlight clear Folded
highlight clear TabLine
highlight clear TabLineFill
highlight clear TabLineSel

highlight StatusLine guibg=#700000 guifg=yellow ctermfg=yellow ctermbg=darkred cterm=bold
highlight StatusLineNC guibg=#606060 guifg=#c0c000 ctermfg=yellow ctermbg=darkgray cterm=NONE
highlight StatusLineTerm guibg=#700000 guifg=yellow ctermfg=yellow ctermbg=darkred cterm=bold
highlight StatusLineTermNC guibg=#606060 guifg=#c0c000 ctermfg=yellow ctermbg=235 cterm=NONE
highlight LocalVar guifg=#60ff90 ctermfg=green ctermbg=NONE
highlight GlobalVar guifg=#f0ff70 gui=italic ctermfg=lightgray ctermbg=NONE cterm=underline
highlight Procedure guifg=#90ffe0 gui=italic ctermfg=lightgreen cterm=bold
highlight Function guifg=#d0ffff gui=italic ctermfg=white cterm=bold
highlight FoldColumn guifg=green guibg=#606060 ctermfg=green ctermbg=gray
highlight Folded guifg=#a0ffa0 guibg=#105010 ctermfg=white ctermbg=22
highlight TabLineFill guifg=orange guibg=#303030 ctermfg=white ctermbg=gray
highlight TabLine guifg=#a0a0a0 guibg=#404040 ctermfg=yellow ctermbg=darkgray
highlight TabLineSel guifg=yellow guibg=black ctermfg=white ctermbg=black cterm=bold

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

highlight Normal guifg=#7fffaf guibg=Black ctermfg=lightgreen ctermbg=black
highlight String guifg=#ff88c8 guibg=Black ctermfg=11 ctermbg=black cterm=bold
highlight Comment guifg=LightGray guibg=Black ctermfg=gray ctermbg=black
highlight Constant guifg=LightRed guibg=Black ctermfg=9 ctermbg=black
highlight Special guifg=LightCyan guibg=Black ctermfg=lightcyan ctermbg=black
highlight Identifier guifg=White guibg=Black ctermfg=white ctermbg=black
highlight Statement guifg=#40ff40 guibg=Black ctermfg=green ctermbg=black
highlight PreProc guifg=#ffc0b8 guibg=Black ctermfg=magenta ctermbg=black
highlight Type guifg=Cyan guibg=Black ctermfg=cyan ctermbg=black
highlight Ignore guifg=#a0ffa0 guibg=Black ctermfg=22 ctermbg=black
highlight Error guifg=White guibg=Red ctermfg=white ctermbg=red
highlight Todo guifg=#80ff80 guibg=DarkGreen ctermfg=white ctermbg=22
highlight SpecialKey guifg=#a0ffa0 guibg=Black ctermfg=lightgreen ctermbg=black
highlight NonText guifg=Grey10 guibg=Grey10 ctermfg=235 ctermbg=235
highlight Directory guifg=#80ff80 guibg=Black ctermfg=Yellow ctermbg=black cterm=bold
highlight ErrorMsg guifg=LightRed guibg=Black ctermfg=9 ctermbg=black cterm=bold
highlight WarningMsg guifg=Cyan guibg=Black ctermfg=cyan ctermbg=black
highlight IncSearch guifg=Orange guibg=Black ctermfg=130 ctermbg=black cterm=bold,underline
highlight Search guifg=Orange guibg=Black ctermfg=130 ctermbg=black cterm=bold
highlight MoreMsg guifg=LightGray guibg=Black ctermfg=lightgray ctermbg=black
highlight ModeMsg guifg=#80ff80 guibg=Black ctermfg=white ctermbg=black
highlight LineNr guifg=#80ff80 guibg=DarkGreen ctermfg=white ctermbg=22
highlight Question guifg=Cyan guibg=Black ctermfg=lightcyan ctermbg=black
highlight Title guifg=White guibg=DarkGreen ctermfg=white ctermbg=22 cterm=bold
highlight Visual guifg=White guibg=DarkGreen ctermfg=white ctermbg=22
highlight VisualNOS guifg=#80ff80 guibg=DarkGreen ctermfg=lightgray ctermbg=22
highlight WildMenu guifg=White guibg=DarkGreen ctermfg=white ctermbg=22
highlight Cursor guifg=Black guibg=Yellow ctermfg=black ctermbg=yellow
highlight CursorLine guibg=#400000 ctermbg=darkblue cterm=bold

"---< Fin de fichier >----------------------------------------------------------

