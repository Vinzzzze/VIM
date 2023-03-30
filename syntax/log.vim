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

syn keyword logPortfolio Portfolio
syn keyword logPosition Position
syn keyword logTrade Trade
syn keyword logUnderlyingDef Underlying

syn match logStrategy "strategy : [^,]\+"
syn match logMaturityDate "maturity : [0-3][0-9] [JFMASOND][aepuco][nbrylgptvc] [2-9][0-9][0-9][0-9]"
syn match logDate contained "[0-3][0-9][JFMASOND][aepuco][nbrylgptvc][2-9][0-9][0-9][0-9]"
syn match logPDLName "[^ ]\+.pdl" contains=logDate
syn match logHour "[0-9]\+h[0-9]\+m[0-9]\+s[0-9]\+"
syn match logNumber "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match logNumber "\d\+f"
syn match logNumber "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match logNumber "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match logNumber "\d\+e[-+]\=\d\+[fl]\=\>"
syn match logCurrency "\<\(USD\|DKK\|EUR\|GBP\|CAD\|CHF\|SEK\|NOK\|AUD\|JPY\|GBPpence\|BEF\|DEM\|HKD\|NLG\|ZAR\)"
syn match logUnderlying "\<[A-Z][A-Z]_[A-Z0-9]\+"
syn match logUnderlyingCompo "\<[A-Z][A-Z]_[A-Z0-9]\+_[A-Z][A-Z][A-Z]"
syn match logPortfolioName "^[a-zA-Z_0-9]\+ :"
syn match logResult "[0-9]\+ result(s) .*"
syn match logError "(ERROR) .*"
syn match logError "ERROR : .*"

if ( !exists( "did_log_syntax_inits" ) )
   let did_log_syntax_inits = 1

   hi link logStrategy           PreProc
   hi link logPortfolio          ToDo
   hi link logPosition           Special
   hi link logTrade              SpecialKey
   hi link logUnderlyingDef      Comment
   hi link logMaturityDate       Comment
   hi link logDate               PreProc
   hi link logHour               Type
   hi link logUnderlying         Type
   hi link logUnderlyingCompo    Type
   hi link logError              Error
   hi link logNumber             Identifier
   hi link logCurrency           Statement
   hi link logPDLName            Special
   hi link logResult             Special
   hi link logPortfolioName      Comment

endif

let b:current_syntax = "log"

