" Vim syntax file
" Language:   Présentation des projets
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

syn case ignore

syn match ProjectTitle        "Projet : .*"

syn match ProjectOpen         "+-+-< .*"
syn match ProjectClose        "+-+-> .*"

syn match ProjectFileRead     "+-+ .* ( )"
syn match ProjectFileWrite    "+-+ .* (\*)"
syn match ProjectDependencies " +-( .* )"
syn match ProjectImport       "+<> .*"

syn region ProjectToken             start="\[@" end="@\]"
syn region LengthTask               start=" -- " end=" -- "
syn region NamedTask                start="+([0-9]\+" end=")"
syn region RealisitionTask          start="+< REALISATION > " end="$" contains=StartRealisationOnlyTask,StartRealisationTask
syn region StartRealisationOnlyTask start=" - " end=" - " containedin=RealisationTask contained
syn region StartRealisationTask     start=" <- " end=" -> " containedin=RealisationTask contained

syn match ProjectComment      "|   [^ +|].*"

syn match MainTask            "^   >>>--- .*"
syn match SecondTask          "^   +->>> .*"
syn match ScheduleTask        "Début prévu le : [^*]*"
syn match CommentTask         "| [^ |+].*"
syn match CanceledTask        "\*\* CANCELED \*\*"

if ( !exists( "did_prj_syntax_inits" ) )
   let did_prj_syntax_inits = 1

   hi link ProjectTitle        Identifier
   hi link ProjectComment      Comment
   hi link ProjectOpen         Type
   hi link ProjectClose        PreProc
   hi link ProjectImport       Statement
   hi link ProjectFileRead     Constant
   hi link ProjectFileWrite    Statement
   hi link ProjectDependencies Todo
   hi link ProjectToken        String
   hi link MainTask            Special
   hi link SecondTask          Identifier
   hi link LengthTask          PreProc
   hi link CommentTask         Comment
   hi link ScheduleTask             String
   hi link NamedTask                Statement
   hi link RealisitionTask          String
   hi link StartRealisationOnlyTask PreProc
   hi link StartRealisationTask     Normal
   hi link CanceledTask             ToDo

endif

let b:current_syntax = "prj"

