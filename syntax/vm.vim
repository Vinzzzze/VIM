" Vim syntax file
" Language:   Template velocity
" Maintainer:   Vince coolcoyote@noos.fr
" Last Change:   2014:w


" Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match Variable   "\$[a-zA-Z_0-9]\+"
syn case ignore

" The SQL reserved words, defined as keywords.

syn keyword sqlSpecial false null true clustered nonclustered

syn keyword sqlKeyword access add asc by check cluster column set
syn keyword sqlKeyword compress connect current cursor default desc
syn keyword sqlKeyword else elsif exception exclusive file for from
syn keyword sqlKeyword function group having identified if immediate increment
syn keyword sqlKeyword index initial is level loop maxextents mode modify
syn keyword sqlKeyword nocompress nowait of offline on online start
syn keyword sqlKeyword successful synonym table then to trigger uid
syn keyword sqlKeyword unique user validate values view whenever lock
syn keyword sqlKeyword where with option order pctfree privileges
syn keyword sqlKeyword public resource row rowlabel rownum rows noaudit
syn keyword sqlKeyword session share size type using statistics
syn keyword sqlKeyword outer inner cross join print include

syn keyword sqlOperator not and or
syn keyword sqlOperator in any some all between exists
syn keyword sqlOperator like escape
syn keyword sqlOperator intersect minus
syn keyword sqlOperator prior distinct foreign
syn keyword sqlOperator sysdate out[put] constraint primary key

syn keyword sqlStatement alter analyze audit comment commit create begin
syn keyword sqlStatement union delete drop execute explain grant insert into
syn keyword sqlStatement rename revoke rollback savepoint select declare
syn keyword sqlStatement truncate update tran[saction] end if else while
syn keyword sqlStatement return raiserror exec[ute] proc[edure] goto use
syn keyword sqlStatement open close deallocate

syn keyword sqlType boolean char character date[time] decimal float int[eger] long
syn keyword sqlType mlslabel number raw rowid smallint varchar varchar2 varray
syn keyword sqlType nvarchar tinyint real

syn keyword sqlOption rowcount quoted_identifier
syn keyword sqlOptionValue off

syn keyword sqlBlockSeparator go

syn keyword sqlFct max min sum avg count kill

syn keyword Transact case when as
syn match TransactGlobal "@@[a-zA-Z_0-9]\+\>"
syn match TransactLocal  "@[a-zA-Z_0-9]\+\>"

syn keyword TransactProc sp_help[text] sp_who[2] sp_lock dbcc object_id objectproperty convert inputbuffer
" Date functions
"---------------
syn keyword sqlFct dateadd datediff datename datepart day getdate getutcdate month year
" Math functions
"---------------
syn keyword sqlFct abs acos asin atan atn2 ceiling cos cot degrees exp floor log log10
syn keyword sqlFct pi power radians rand round sign square sqrt tan
" Metadata functions
"-------------------
syn keyword sqlFct col_length col_name columnproperty col_length col_name fulltextcatalogproperty
syn keyword sqlFct columnproperty fulltextserviceproperty databaseproperty index_col
syn keyword sqlFct databasepropertyex indexkey_property db_id indexproperty db_name object_id
syn keyword sqlFct file_id object_name file_name objectproperty filegroup_id filegroup_name
syn keyword sqlFct sql_variant_property filegroupproperty typeproperty fileproperty
" String functions
"-----------------
syn keyword sqlFct ascii nchar soundex char patindex space charindex replace str difference quotename
syn keyword sqlFct stuff left replicate substring len reverse unicode lower right upper ltrim rtrim
" System functions
"-----------------
syn keyword sqlFct app_name case cast coalesce collationproperty current_timestamp current_user datalength
syn keyword sqlFct fn_helpcollations fn_servershareddrives fn_virtualfilestats formatmessage getansinull
syn keyword sqlFct host_id host_name ident_current ident_incr ident_seed identity isdate isnull isnumeric
syn keyword sqlFct newid nullif parsename permissions rowcount_big scope_identity serverproperty
syn keyword sqlFct sessionproperty session_user stats_date system_user user_name
" Text and image functions
"-------------------------
syn keyword sqlFct patindex textptr textvalid

" Exocet database
"----------------
syn match ExocetDB "\<Exocet[a-zA-Z]\+"

" Database owner
"---------------
syn keyword sqlDBO   dbo

" Strings and characters:
syn region sqlString start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region sqlString start=+'+  skip=+\\\\\|\\'+  end=+'+

" Numbers:
syn match sqlNumber "-\=\<\d*\.\=[0-9_]\>"

" Comments:
syn region sqlComment start="/\*"  end="\*/" contains=sqlComment
syn match sqlLineComment "--.*"

syn sync ccomment sqlComment

" The default highlighting.
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_sql_syn_inits")
   if version < 508
      let did_sql_syn_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif

   HiLink sqlComment     Comment
   HiLink sqlKeyword     sqlSpecial
   HiLink sqlNumber      Number
   HiLink sqlSpecial     Special
   HiLink sqlString      String
   HiLink sqlType        Type
   HiLink sqlLineComment sqlComment
   HiLink TransactGlobal GlobalVar
   HiLink TransactLocal  LocalVar
   HiLink TransactProc   Procedure
   HiLink sqlFct         Function

   delcommand HiLink

   highlight sqlOperator         guifg=Green guibg=Black gui=italic
   highlight sqlStatement        guifg=White gui=bold
   highlight ExocetDB            guifg=red guibg=Black gui=underline
   highlight sqlDBO              guifg=LightRed guibg=Black gui=italic
   highlight sqlOption           guifg=LightBlue guibg=Black gui=bold
   highlight sqlOptionValue      guifg=Yellow guibg=DarkRed
   highlight sqlBlockSeparator   guifg=Yellow guibg=DarkBlue gui=italic,bold
endif

let b:current_syntax = "sql"

" vim: ts=8
