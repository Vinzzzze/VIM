" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2010 Sep 29

" VM : complete the C++
"----------------------
if has("fname_case")
  au BufNewFile,BufRead *.CPP,*.CXX,*.C++,*.HH,*.HXX,*.HPP,*.MOC,*.TCC,*.INL,*.I
	\ if exists("cynlib_syntax_for_cc")|setf cynlib|else|setf cpp|endif
endif

" VM : Add the log file definition
"---------------------------------
au BufNewFile,BufRead *.str,*.typ,*.cflt  setf c
au BufNewFile,BufRead *.mac  call s:FTheaderMac()

func! s:FTheaderMac()
  if exists("g:c_syntax_for_h")
    setf c
  else
    setf cpp
  endif
endfunc

" Fonction : s:ExecSubExtention
"
" But : Execute the sub extention of the file
"-------------------------------------------------------------------------------
function! s:ExecSubExtention()
   let subExt = expand( "<amatch>:r:e" )
 
   if ( subExt == "h" )
      setf c
   elseif ( subExt > "" )
      execute "setf " . subExt
   endif
endfunction

" Function : s:SQLSpecificType
"
" Purpose : Set the SQL type
"-------------------------------
function! s:SQLSpecificType()
   if ( exists( "g:specific_syntax_for_sql" ) == 0 )
      setf sql
   else
      execute "setf " . g:specific_syntax_for_sql
   endif
endfunction
 
" VM : Add the log file definition
"---------------------------------
au BufNewFile,BufRead *.log            setf log

" VM : Prime Description Language
"--------------------------------
au BufNewFile,BufRead *.pdl	setf pdl

" VM : Exocet Template Language
"------------------------------
au BufNewFile,BufRead *.tpl   setf tpl

" VM : Complete the SQL
"----------------------
au BufNewFile,BufRead *.psch,*.psql,*.ptab,*.pfct,*.ptyp,*.pls			setf plsql
au BufNewFile,BufRead *.msch,*.msql,*.mtab,*.mfct,*.mprc,*.mtyp			setf mysql
au BufNewFile,BufRead *.mssql,*.tab,*.prc,*.viw			setf mssql
au BufNewFile,BufRead *.sql			call s:SQLSpecificType()

" VM : add the project definition
"--------------------------------
au BufNewFile,BufRead *.project_def,*.workspace  setf vim

" VM : Add the todo.txt definition
"---------------------------------
au BufNewFile,BufRead *todo*.txt  setf todo

" TSL scripts
au BufNewFile,BufReadPost *.tsl		setf tsl

" VM : Add the result definition
"-------------------------------
au BufNewFile,BufRead *.res  setf res

" VM : add the project definition
"--------------------------------
au BufNewFile,BufRead *.project_init,*.project_*_init,*.bash*  setf sh

" Gradle file file, using groovy
"-------------------------------
au BufNewFile,BufRead *.gradle  setf groovy

" JSon files
"-----------
au BufNewFile,BufRead *.json  setf json

" Velocity files
"---------------
au BufNewFile,BufRead *.vm  setf velocity

" csv files
"----------
au BufNewFile,BufRead *.csv  setf csv

" GO files
"---------
au BufNewFile,BufRead *.go  setf go

" Project makefile
"-----------------
au BufNewFile,BufRead make.*  setf make

" Debug trace
"------------
au BufNewFile,BufRead debug.out  setf debug

" Edifact files
"--------------
au BufNewFile,BufRead *.edifact  setf edifact

" Config files
"--------------
au BufNewFile,BufRead *.cfg  setf xml

" Language definition
"--------------------
au BufNewFile,BufRead lang_*.lang  setf lang
au BufNewFile,BufRead lang_*.enum  setf lang_enum
au BufNewFile,BufRead allObjects.export  setf export
au BufNewFile,BufRead messages.enum,paramOrder.enum,paramUsage.enum  setf msg_enum

au BufNewFile,BufRead *.glang  call s:ExecSubExtention()

au BufNewFile,BufRead *.i,*.ec  setf cpp

" Fixed length definition
"------------------------
" Fonction : s:FixedLengthDefinition
"
" But : Execute the sub extention of the file
"-------------------------------------------------------------------------------
function! s:FixedLengthDefinition()
   let completeFile = expand( "<amatch>:t" )
 
   if ( exists( "g:VM_fixedLengthNameComputation" ) != 0 )
      execute "let definitionFile = " . g:VM_fixedLengthNameComputation . "( completeFile )"
   else
      let definitionFile = input( "Column definition file for " . definitionFile . " : " )
      echo "\n"
   endif

   if ( filereadable( definitionFile ) != 0 )
   	setf VM_fixed_length

      call VM_ReadFixedLength( definitionFile )
      call VM_AutoCommandFixedLengh()
   " End IF the fixed length can be initialized
   elseif ( exists( "g:VM_fixedLengthNotSet" ) != 0 )
      execute "call " . g:VM_fixedLengthNotSet . "( definitionFile )"
   endif " End IF the fixed length cannot be initialized
endfunction

" Fonction : s:IsEdifact
"
" But : Determine if the current file is an edifact one
"-------------------------------------------------------------------------------
function! s:IsEdifact()
   if ( &ft == "" )
      let numLine = line( "$" )

      if ( numLine > 1 )
         let numLine = 2
      endif " End IF there are enough line to test the second one

      let firstLine = getline( numLine )

      if ( substitute( firstLine, "^[A-Z]\\+\", "", "" ) != firstLine )
        setf edifactVM
      endif " End IF the first line seems to belong to an edifact file
   endif " End IF the file already have a filetype
endfunction

au BufNewFile,BufRead *.NBC.*.*.*.M[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789]  call s:FixedLengthDefinition()
au BufNewFile,BufRead *.NBC.*.*.*.D[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789].DATA  call s:FixedLengthDefinition()
au BufNewFile,BufRead *.NBC.*.D[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789].dat  call s:FixedLengthDefinition()
au BufNewFile,BufRead *Summaries_[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789] call s:FixedLengthDefinition()
au BufNewFile,BufRead sapbif.*.[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789].*dat  call s:FixedLengthDefinition()
au BufNewFile,BufRead *.cvt  call s:FixedLengthDefinition()
au BufNewFile,BufRead *.UISC.*.D[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789].* call s:FixedLengthDefinition()

" The XML reference file
"-----------------------
au BufNewFile,BufRead *Output_[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789]  setf xml
au BufNewFile,BufRead *.edif setf edifact
au BufNewFile,BufRead * call s:IsEdifact()

