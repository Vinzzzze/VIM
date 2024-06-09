" Vim support file to detect file types
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2010 Sep 29

" my filetype file
if exists("did_load_my_filetypes")
  finish
endif

" Disable filetype.vim
let g:did_load_my_filetypes = 1

augroup filetypedetect

" VM : complete the C++
"----------------------
if has("fname_case")
  au BufNewFile,BufRead *.CPP,*.CXX,*.C++,*.HH,*.HXX,*.HPP,*.MOC,*.TCC,*.INL,*.I
	\ if exists("cynlib_syntax_for_cc")|setf cynlib|else|setfiletype cpp|endif
endif

" VM : Add the log file definition
"---------------------------------
au BufNewFile,BufRead *.str,*.typ,*.cflt  setfiletype c
au BufNewFile,BufRead *.mac  call s:FTheaderMac()

func! s:FTheaderMac()
  if exists("g:c_syntax_for_h")
    setfiletype c
  else
    setfiletype cpp
  endif
endfunc

" Fonction : s:ExecSubExtention
"
" But : Execute the sub extention of the file
"-------------------------------------------------------------------------------
function! s:ExecSubExtention()
   let subExt = expand( "<amatch>:r:e" )
 
   if ( subExt == "h" )
      setfiletype c
   elseif ( subExt > "" )
      execute "setfiletype " . subExt
   endif
endfunction

" Function : s:SQLSpecificType
"
" Purpose : Set the SQL type
"-------------------------------
function! s:SQLSpecificType()
   if ( exists( "g:specific_syntax_for_sql" ) == 0 )
      setfiletype sql
   else
      execute "setfiletype " . g:specific_syntax_for_sql
   endif
endfunction
 
" VM : Add the log file definition
"---------------------------------
au BufNewFile,BufRead *.log            setfiletype log

" VM : Prime Description Language
"--------------------------------
au BufNewFile,BufRead *.pdl	setfiletype pdl

" VM : Exocet Template Language
"------------------------------
au BufNewFile,BufRead *.tpl   setfiletype tpl

" VM : Complete the SQL
"----------------------
au BufNewFile,BufRead *.psch,*.psql,*.ptab,*.pfct,*.ptyp,*.pls			setfiletype plsql
au BufNewFile,BufRead *.msch,*.msql,*.mtab,*.mfct,*.mprc,*.mtyp			setfiletype mysql
au BufNewFile,BufRead *.mssql,*.tab,*.prc,*.viw			setfiletype mssql
au BufNewFile,BufRead *.sql			call s:SQLSpecificType()

" VM : add the project definition
"--------------------------------
au BufNewFile,BufRead *.project_def,*.workspace  setfiletype vim

" VM : Add the todo.txt definition
"---------------------------------
au BufNewFile,BufRead *todo*.txt  setfiletype todo

" TSL scripts
au BufNewFile,BufReadPost *.tsl		setfiletype tsl

" VM : Add the result definition
"-------------------------------
au BufNewFile,BufRead *.res  setfiletype res

" VM : add the project definition
"--------------------------------
au BufNewFile,BufRead *.project_init,*.project_*_init,*.bash*  setfiletype sh

" Gradle file file, using groovy
"-------------------------------
au BufNewFile,BufRead *.gradle  setfiletype groovy

" JSon files
"-----------
au BufNewFile,BufRead *.json  setf json

" Velocity files
"---------------
au BufNewFile,BufRead *.vm  setfiletype velocity

" csv files
"----------
au BufNewFile,BufRead *.csv  setf csv

" GO files
"---------
au BufNewFile,BufRead *.go  setf go

" Project makefile
"-----------------
au BufNewFile,BufRead make.*  setfiletype make

" Debug trace
"------------
au BufNewFile,BufRead debug.out  setfiletype debug

" Edifact files
"--------------
au BufNewFile,BufRead *.edifact  setfiletype edifact

" Config files
"--------------
au BufNewFile,BufRead *.cfg  setfiletype xml

" Language definition
"--------------------
au BufNewFile,BufRead lang_*.lang  setfiletype lang
au BufNewFile,BufRead lang_*.enum  setfiletype lang_enum
au BufNewFile,BufRead allObjects.export  setfiletype export
au BufNewFile,BufRead messages.enum,paramOrder.enum,paramUsage.enum  setfiletype msg_enum

au BufNewFile,BufRead *.glang  call s:ExecSubExtention()

au BufNewFile,BufRead *.i,*.ec  setfiletype cpp

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
   	setfiletype VM_fixed_length

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
        setfiletype edifactVM
      endif " End IF the first line seems to belong to an edifact file
   endif " End IF the file already have a filetype
endfunction

" Fonction : s:TermOpen
"
" But : Open the terminal
"-------------------------------------------------------------------------------
function! s:TermOpen()
   setfiletype terminal

   if ( exists( "*VM_ProjectEnterFile" ) != 0 )
      call VM_ProjectEnterFile()
   endif
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
au BufNewFile,BufRead *Output_[0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789][0123456789]  setfiletype xml
au BufNewFile,BufRead *.edif setfiletype edifact
au BufNewFile,BufRead * call s:IsEdifact()

au TermOpen * call s:TermOpen()
au TermEnter * setfiletype terminal

augroup END
