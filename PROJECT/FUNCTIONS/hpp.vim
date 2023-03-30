" Get the class name

if ( exists( "*CleanParameter" ) == 0 )

" Fonction : CleanParameter
"
" But : Clean the parameter to comment the initialisation.
"
" Parametres :
"    param : The parameter definition
" Retour :
"    The cleaned value for the current parameter
"-------------------------------------------------------------------------------
function CleanParameter( param )
   if ( a:param == ");" )
      let endOfParam = ")"
      let lastParam = ""

      let s:lastParameter = 1
   else
      let endOfParam = " )"
      let lastParam = substitute( a:param, endOfParam . ";$", "", "" )
      if ( a:param == lastParam )
         let endOfParam = ","
         let lastParam = substitute( a:param, endOfParam . "$", "", "" )
      else
         let s:lastParameter = 1
      endif
   endif

   return substitute( lastParam, " = .*", " /*& */", "" ) . endOfParam
endfunction

endif

let s:className = expand( "%:t:r" )

" Copy the function definition
"-----------------------------
-1
mark n
,/)\(\| *= *0\);$/ s/)\(\| *= *0\);$/);/
'n
?/\*\*$?,/);$/ yank

" Open the alternate file to build the body function
"---------------------------------------------------
call CPPOpenAlternate( "split" )

" Save the modified status
"-------------------------
let s:saveAlternate = &modified

" Move to the line to use for the creation of the function
"---------------------------------------------------------
$
?^}

" Add the empty line
"-------------------
call append( line( "." ), "}" )
call append( line( "." ), "{" )
call append( line( "." ), "" )

" Paste the function definition
"------------------------------
+1 mark n
+1 put
'n
/\*\/$/+1 mark b
,/);$/ <
'n
,/);$/ <

" Get the function name
"----------------------
let s:functionLine = substitute( substitute( substitute( getline( "'b" ), "^[ 	]*", "", "" ), "static \\+", "", "" ), "[A-Za-z_]*[Vv][Ii][Rr][Tt][Uu][Aa][Ll] \\+", "", "" )

" To know when the parameter list had been updated
"-------------------------------------------------
let s:lastParameter = 0

" Determine the type returned
"----------------------------
let s:currentTypeReturned = substitute( substitute( s:functionLine, "[A-Za-z_][A-Za-z_0-9]* *(.*", "", "" ), "[ 	]*$", "", "" )
let s:functionName = substitute( substitute( substitute( s:functionLine, substitute( s:currentTypeReturned, "\\*", "\\\\*", "g" ), "", "" ), "^[ 	]*", "", "" ), "(.*", "", "" )
let s:firstParameter = CleanParameter( substitute( s:functionLine, "^[^(]*([ 	]*", "", "" ) )

" Determine if something had to be returned
"------------------------------------------
let s:voidFunction = 0

if ( s:currentTypeReturned == "void" )
   let s:voidFunction = 1
endif

" Mark the position of the opened function code
"----------------------------------------------
let s:currentLine = line( "'b" ) + 1

" Replace the function name definition
"-------------------------------------
if ( s:firstParameter == ")" )
   call setline( line( "'b" ), s:currentTypeReturned . " " . s:className . "::" . s:functionName . "()" )
else
   call setline( line( "'b" ), s:currentTypeReturned . " " . s:className . "::" . s:functionName . "( " . s:firstParameter )

   if ( s:lastParameter == 0 )
      let s:indentation = substitute( s:currentTypeReturned . " " . s:className . "::" . s:functionName . "( ", ".", " ", "g" )

      while ( s:lastParameter == 0 )
         call setline( s:currentLine, s:indentation . CleanParameter( substitute( getline( s:currentLine ), "^[ 	]*", "", "" ) ) )

         let s:currentLine = s:currentLine + 1
      endwhile
   endif
endif

" Add the return code if needed
"------------------------------
if ( s:voidFunction == 0 )
   call append( s:currentLine, g:VM_projectIndentation . "return <@RETURNED_VALUE@>;" )
endif

'b

" Remove the function
"--------------------
delfunction CleanParameter

" Close the file opened
"----------------------
if ( s:saveAlternate == 0 )
   write
endif

quit

