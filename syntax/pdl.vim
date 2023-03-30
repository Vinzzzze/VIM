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

syn keyword pdlError _error_stack error_index_list _last_exec_name
syn keyword pdlEssential _adm_pdl book_today underlying broken_ibor_begin_underlying broken_ibor_end_underlying
syn keyword pdlAttribute adm_portfolio_id adm_strategy_id entity_kind murex_strategy
syn keyword pdlSpecial adm_matching_operation_id adm_code_fee policy_id
syn keyword pdlName adm_operation_id status
syn keyword pdlNetting adm_opus_id adm_transaction_date adm_insertion_date cash_flow_value_date_list
syn keyword pdlNetting adm_data_code adm_data_source
syn keyword pdlUnused adm_excel_strategy_id adm_matching_temporary_operation_id
syn keyword pdlResultNames accrual_value clean_price dirty_price premium premium_without_additional_flows
syn keyword pdlNetting changed_object_list changed_attribute_list

syn match pdlNumber contained "\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match pdlNumber contained "\d\+f"
syn match pdlNumber contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match pdlNumber contained "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match pdlNumber contained "\d\+e[-+]\=\d\+[fl]\=\>"
syn match pdlArrayElementName "\[.*\]"
syn match pdlCurrency "\<\(USD\|DKK\|EUR\|GBP\|CAD\|CHF\|SEK\|NOK\|AUD\|JPY\|GBPpence\|BEF\|DEM\|HKD\|NLG\|ZAR\)"
syn match pdlUnderlying "\<[A-Z][A-Z]_[A-Z0-9]\+"
syn match pdlUnderlyingCompo "\<[A-Z][A-Z]_[A-Z0-9]\+_[A-Z][A-Z][A-Z]"

syn region pdlExec start="^_last_exec"  end=" "
syn region pdlComment start="\-\-" end="$" keepend
syn region pdlObject start="^"  end="[\. ]" contains=pdlEssential,pdlError,pdlExec,pdlComment
syn region pdlString start=+"+  end=+"+ contains=pdlCurrency,pdlUnderlying
syn region pdlVector start="(" end=")" contains=pdlNumber,pdlString,pdlComment,pdlCurrency,pdlUnderlying
syn region pdlEqualSign start=":=" end=";" contains=pdlNumber,pdlString,pdlVector,pdlCurrency,pdlUnderlying

syn match pdlResult "[^. :=]\+/" contains=pdlNumber,pdlArrayElementName,pdlString,pdlVector,pdlEqualSign,pdlCurrency,pdlUnderlying

if ( !exists( "did_pdl_syntax_inits" ) )
   let did_pdl_syntax_inits = 1

   hi link pdlExec               Todo
   hi link pdlEssential          PreProc
   hi link pdlArrayElementName   Type
   hi link pdlUnderlying         Type
   hi link pdlUnderlyingCompo    Special
   hi link pdlAttribute          Error
   hi link pdlEqualSign          Statement
   hi link pdlCurrency           Statement
   hi link pdlVector             Todo
   hi link pdlResultNames        DiffChange
   hi link pdlString             String
   hi link pdlResult             Special
   hi link pdlComment            Comment
   hi link pdlUnused             Comment

   if ( &diff == 0 )
      highlight pdlNumber guifg=red
   else
      highlight pdlNumber guifg=white
   endif

   highlight pdlSpecial guifg=yellow guibg=darkgreen
   highlight pdlError guifg=red guibg=yellow
   highlight pdlName guifg=white
   highlight pdlNetting guifg=yellow
   highlight pdlObject guifg=green
endif

let b:current_syntax = "pdl"

