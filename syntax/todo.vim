" Vim syntax file
" Language:   Prime Description Language, langage de description des objets financiers
" Maintainer: Vini "Cool Coyote" <coolcoyote@club-internet.fr>
" Last change : 25 Oct 2001
"---------------------------------------------------

" Remove any old syntax stuff hanging around
"-------------------------------------------
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn keyword todoImportant IMPORTANT HIGH URGENT
syn keyword todoNormal    TASK Task task STD NORMAL STANDARD
syn keyword todoLow       OCCASION LOW
syn keyword todoReserved  Started Terminated Author Executor
syn keyword todoParagraph Summary Subject Technical

syn match todoNumber contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match todoNumber contained "\d\+f"
syn match todoNumber contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match todoNumber contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match todoNumber contained "\d\+e[-+]\=\d\+[fl]\=\>"
syn match todoPriorityLevel "\[[^\[\]]*\]"
syn match todoDate "\([0-9]\|\)[0-9] [A-Za-z\.]\+ \([0-9][0-9]\|\)[0-9][0-9]"
syn match todoFilename "#[\$A-Za-z0-9_/\.]\+#"

syn region todoBanner start="^:" end="$" keepend
syn region todoComment start="\-\-" end="$" keepend
syn region todoString start=+"+  end=+"+ contains=todoPriorityLevel,todoNumber,todoDate
syn region todoStarted start="^[ 	]*Started : "  end="$" contains=todoPriorityLevel,todoNumber,todoDate keepend
syn region todoTerminated start="^[ 	]*Terminated : "  end="$" contains=todoPriorityLevel,todoNumber keepend
syn region todoAuthor start="^[ 	]*Author : "  end="$" contains=todoPriorityLevel,todoNumber,todoDate keepend
syn region todoExecutor start="^[ 	]*Executor : "  end="$" contains=todoPriorityLevel,todoNumber keepend
syn region todoHighPriorityIntro start="^\*++< " end=" >+\+$" contains=todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow keepend
syn region todoHighPriority start="^\*++< "  end="^\*++<>+\+$" contains=todoHighPriorityIntro,todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow,todoReserved,todoParagraph,todoStarted,todoTerminated,todoAuthor,todoExecutor,todoFilename
syn region todoNormalPriorityIntro start="^\*+\-< " end=" >-\+$" contains=todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow keepend
syn region todoNormalPriority start="^\*+\-< "  end="^\*+\-<>-\+$" contains=todoNormalPriorityIntro,todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow,todoReserved,todoParagraph,todoStarted,todoTerminated,todoAuthor,todoExecutor,todoFilename
syn region todoLowPriorityIntro start="^\*\-\-< " end=" >-\+$" contains=todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow keepend
syn region todoLowPriority start="^\*\-\-< "  end="^\*\-\-<>-\+$" contains=todoLowPriorityIntro,todoPriorityLevel,todoNumber,todoDate,todoImportant,todoNormal,todoLow,todoReserved,todoParagraph,todoStarted,todoTerminated,todoAuthor,todoExecutor,todoFilename

if ( !exists( "did_todo_syntax_inits" ) )
   let did_todo_syntax_inits = 1

   highlight todoBanner gui=bold,italic guifg=Yellow guibg=black cterm=bold ctermfg=yellow ctermbg=black
   highlight todoPriorityLevel gui=bold guifg=Yellow guibg=black cterm=bold ctermfg=yellow ctermbg=black
   highlight todoExecutor guifg=DarkCyan guibg=black ctermfg=darkcyan ctermbg=black
   highlight todoHighPriorityIntro gui=bold guifg=Yellow guibg=darkred ctermfg=yellow ctermbg=235 cterm=bold
   highlight todoHighPriority gui=italic guifg=Red guibg=black ctermfg=green ctermbg=black
   highlight todoNormalPriority gui=italic cterm=bold
   highlight todoLowPriorityIntro gui=bold guifg=Yellow guibg=darkgray ctermfg=yellow ctermbg=235 cterm=bold
   highlight todoLowPriority gui=italic guifg=Gray guibg=black ctermfg=gray ctermbg=black
   highlight todoParagraph gui=Bold guifg=Cyan guibg=black ctermfg=cyan ctermbg=black

   hi link todoImportant         Error
   hi link todoNormal            WarningMsg
   hi link todoLow               NonText
   hi link todoReserved          Identifier
   hi link todoNumber            Function
   hi link todoDate              Special
   hi link todoString            String
   hi link todoStarted           IncSearch
   hi link todoTerminated        Underlined
   hi link todoAuthor            Function
   hi link todoFilename          Identifier
   hi link todoComment           Comment
   hi link todoNormalPriorityIntro Folded

endif

let b:current_syntax = "todo"

