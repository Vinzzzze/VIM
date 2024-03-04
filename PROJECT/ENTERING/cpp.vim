" Fichier : setting_cpp.vim
"
" But : Définition des settings des fichiers de syntaxe C++.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*CreateGetSet" ) == 0 )

" Fonction : CreateGetSet
"
" But : Create the function get and set on a class attribute
"
" Buffer : 
"    Current editting buffer
" Parametres :
"    numLine - number of the line where the attribute is declared
"-------------------------------------------------------------------------------
function CreateGetSet( numLine )
   " Read the indente value
   "-----------------------
   let indenteValue = substitute( getline( a:numLine ), "[^ 	].*", "", "" )
   " Define the static variables
   "----------------------------
   let currentLineValue = substitute( getline( a:numLine ), "\\<static \\+", "", "" )

   if ( currentLineValue == getline( a:numLine ) )
      let thisValue = "this->"
      let staticValue = ""
   else
      let thisValue = ""
      let staticValue = "static "
   endif
   " Read the type
   "--------------
   let typeValue = substitute( substitute( currentLineValue, "^[ 	]*", "", "" ), "[ 	]\\+[_a-zA-Z][_a-zA-Z0-9]*\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*$", "", "" )
   " Read the variable name
   "-----------------------
   let variableName = substitute( substitute( substitute( getline( a:numLine ), "\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*", "", "" ), "[_a-zA-Z][_a-zA-Z0-9]*$", "@@@&", "" ), "^.*@@@", "", "" )
   " Calculate the function name
   "----------------------------
   let functionName = substitute( variableName, "^_*", "", "" )
   let functionName = toupper( strpart( functionName, 0, 1 ) ) . strpart( functionName, 1 )
   " Get the variable comment
   "-------------------------
   let commentValue = substitute( getline( ( a:numLine - 2 ) ), "[ 	]*/\\*\\* ", "", "" )
   if ( commentValue == getline( ( a:numLine - 2 ) ) )
      let commentValue = substitute( getline( ( a:numLine - 1 ) ), "[ 	]*/\\*\\* ", "", "" )
   endif
   if ( commentValue == getline( ( a:numLine - 1 ) ) )
      let commentValue = ""
   endif
   " Create the Set function
   "------------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . g:VM_projectIndentation . thisValue . variableName . " = param;" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . g:CPPInlineCode . staticValue . "void set" . functionName . "( " . typeValue . " param )" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Set " . commentValue )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
   " Create the get function
   "------------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . g:VM_projectIndentation . "return " . thisValue . variableName . ";" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . g:CPPInlineCode . staticValue . typeValue . " get" . functionName . "()" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Get " . commentValue )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
endfunction

endif

if ( exists( "*CreateGet" ) == 0 )

" Fonction : CreateGet
"
" But : Create the function get on a class attribute
"
" Buffer : 
"    Current editting buffer
" Parametres :
"    numLine - number of the line where the attribute is declared
"-------------------------------------------------------------------------------
function CreateGet( numLine )
   " Read the indente value
   "-----------------------
   let indenteValue = substitute( getline( a:numLine ), "[^ 	].*", "", "" )
   " Define the static variables
   "----------------------------
   let currentLineValue = substitute( getline( a:numLine ), "\\<static \\+", "", "" )

   if ( currentLineValue == getline( a:numLine ) )
      let thisValue = "this->"
      let staticValue = ""
   else
      let thisValue = ""
      let staticValue = "static "
   endif
   " Read the type
   "--------------
   let typeValue = substitute( substitute( currentLineValue, "^[ 	]*", "", "" ), "[ 	]\\+[_a-zA-Z][_a-zA-Z0-9]*\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*$", "", "" )
   " Read the variable name
   "-----------------------
   let variableName = substitute( substitute( substitute( getline( a:numLine ), "\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*", "", "" ), "[_a-zA-Z][_a-zA-Z0-9]*$", "@@@&", "" ), "^.*@@@", "", "" )
   " Calculate the function name
   "----------------------------
   let functionName = substitute( variableName, "^_*", "", "" )
   let functionName = toupper( strpart( functionName, 0, 1 ) ) . strpart( functionName, 1 )
   " Get the variable comment
   "-------------------------
   let commentValue = substitute( getline( ( a:numLine - 2 ) ), "[ 	]*/\\*\\* ", "", "" )
   if ( commentValue == getline( ( a:numLine - 2 ) ) )
      let commentValue = substitute( getline( ( a:numLine - 1 ) ), "[ 	]*/\\*\\* ", "", "" )
   endif
   if ( commentValue == getline( ( a:numLine - 1 ) ) )
      let commentValue = ""
   endif
   " Create the get function
   "------------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . g:VM_projectIndentation . "return &" . thisValue . variableName . ";" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . g:CPPInlineCode . staticValue . typeValue . "* get" . functionName . "()" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Get " . commentValue )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
endfunction

endif

if ( exists( "*CppFoldLevel" ) == 0 )

" Fonction : CppFoldLevel
"
" But : Calculate the folder level for the C/C++ language.
"
" Buffer : 
"    Texte du source
" Parametres :
"    lineNumber - Numéro de ligne actuellement analysée
" Retour :
"    Fold expression ( cf help fold )
"-------------------------------------------------------------------------------
function CppFoldLevel( lineNumber )
   let retValue = "="
   let currentLine = getline( a:lineNumber )

   if ( ( ( match( currentLine, "{" ) > -1 )&&( match( currentLine, "}" ) == -1 ) )||( ( match( currentLine, "/\\*" ) > -1 )&&( match( currentLine, "\\*/" ) == -1 ) ) )
      let retValue = "a1"
   elseif ( ( ( match( currentLine, "{" ) == -1 )&&( match( currentLine, "}" ) > -1 ) )||( ( match( currentLine, "/\\*" ) == -1 )&&( match( currentLine, "\\*/" ) > -1 ) ) )
      let retValue = "s1"
   endif

   return retValue
endfunction

endif

if ( exists( "*CppFoldText" ) == 0 )

" Fonction : CppFoldText
"
" But : Print the line for displaying a fold closed
"
" Buffer : 
"    Texte du PDL
" Retour :
"    Line to print
"-------------------------------------------------------------------------------
function CppFoldText()
   if ( ( match( getline( v:foldstart ), "/\\*" ) > -1 )&&( match( getline( v:foldstart ), "\\*/" ) == -1 ) )
      let retValue = "---< ********************** ++ COMMENTS ++ ********************** >"
   else
      let lengthCompressed = "     " . ( v:foldend - v:foldstart )
      let retValue = "\-< " . strpart( lengthCompressed, strlen( lengthCompressed ) - 5 ) . " lines >"
   endif
    return retValue
endfunction

endif

if ( exists( "*CPPOpenAlternate" ) == 0 )

" Fonction : CPPOpenAlternate
"
" But : Open the alternate file, on the header we open the body,
"       on the body, open the header
"
" Parametres :
"     modeOpen - The command to use to open the file ( vsplit | split | edit )
"-------------------------------------------------------------------------------
function CPPOpenAlternate( modeOpen )
   " Get the current extention
   "--------------------------
   let extention = expand( "%:e" )
   let letterReplaced = strpart( extention, 0, 1 )
   let replaceExt = ""
   let opened = 0

   if ( letterReplaced == "h" )
      let replaceExt = "c"
   elseif ( letterReplaced == "c" )
      let replaceExt = "h"
   endif

   if ( replaceExt > "" )
      " Recompute the extention
      "------------------------
      let extention = substitute( extention, letterReplaced, replaceExt, "g" )
      let opened = filereadable( expand( "%:r" ) . "." . extention )

      if ( opened != 0 )
         " Open the alternate file
         "------------------------
         execute a:modeOpen . " " . expand( "%:r" ) . "." . extention
      endif
   endif

   return opened
endfunction

endif

if ( exists( "*BuildFunctionComment" ) == 0 )

" Fonction : BuildFunctionComment
"
" But : Build the header of a function.
"
" Parametres :
"     numLine - The line number where the comment had to been added
"     identation - The indentation of each created line
"     functionName - The function name
"     comment - The comment of the function
"     voidFct - To know if the current function is void function
" Retour :
"     The last number of line where the last line had been added
"-------------------------------------------------------------------------------
function BuildFunctionComment( numLine, indentation, functionName, comment, voidFct )
   call append( a:numLine, "" )
   let numLineRet = a:numLine + 1
   call append( numLineRet, a:indentation . "/**" )
   let numLineRet = VM_PrintLimitedLengthLine( a:indentation . " * ", a:indentation . " * ", numLineRet + 1, a:comment, 90 )
   call append( numLineRet, a:indentation . " *" )
   let numLineRet = numLineRet + 1
   call append( numLineRet, a:indentation . " * @param " )
   let numLineRet = numLineRet + 1

   if ( a:voidFct == 0 )
      call append( numLineRet, a:indentation . " *" )
      let numLineRet = numLineRet + 1
      call append( numLineRet, a:indentation . " * @return " )
      let numLineRet = numLineRet + 1
   endif

   call append( numLineRet, a:indentation . "*/" )
   let numLineRet = numLineRet + 1

   return numLineRet
endfunction

endif

if ( exists( "*BuildFunctionBody" ) == 0 )

" Fonction : BuildFunctionBody
"
" But : Build the function body.
"
" Parametres :
"     numLine - The line number where the comment had to been added
"     typeReturned - The type returned
"     functionName - The function name
"     elementName - The class for which the function had been built
"     comment - The comment of the function
"     voidFct - To know if the current function is void function
"-------------------------------------------------------------------------------
function BuildFunctionBody( numLine, typeReturned, functionName, elementName, comment, voidFct )
   let numLineRet = BuildFunctionComment( a:numLine, "", a:functionName, a:comment, a:voidFct )
   call append( numLineRet, a:typeReturned . " " . a:elementName . a:functionName . "()" )
   let numLineRet = numLineRet + 1
   call append( numLineRet, "{" )
   let numLineRet = numLineRet + 1

   if ( a:voidFct == 0 )
      call append( numLineRet, g:VM_projectIndentation . "return <@RETURNED_VALUE@>;" )
      let numLineRet = numLineRet + 1
   endif

   call append( numLineRet, "}" )
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "g:VM_terminalUsage" ) == 0 )
   " Pour la création des accolades
   "-------------------------------
   imap <buffer> <C-M-{> {<CR>} // End <ESC>O<TAB>
   " Pour la creation automatique des get et set des attributs
   "----------------------------------------------------------
   nmap <buffer> <F9> :call CreateGetSet( line( "." ) )<CR>
   nmap <buffer> <S-F9> :call CreateGet( line( "." ) )<CR>
   " Pour l'utilisation de la fonction qui permet de passer du header au body et reciproquement
   "-------------------------------------------------------------------------------------------
   nmap <buffer> <S-F8> :call CPPOpenAlternate( "vsplit" )<CR>
   nmap <buffer> <C-F8> :call CPPOpenAlternate( "split" )<CR>
   nmap <buffer> <M-F8> :call CPPOpenAlternate( "edit" )<CR>
   " Pour commenter / décommenter une zone
   "--------------------------------------
   vmap <buffer> <F4> <ESC>:call VM_CommentAtMinIndente( "// " )<CR>
   vmap <buffer> <S-F4> :substitute /\/\/ //<CR>

   if ( exists( "g:VM_debugModeActive" ) == 0 )
      nmap <buffer> <silent> <F4> :Debug<CR>
      nmap <buffer> <silent> <M-F1> :SelectDebug<CR>
      if ( exists( "b:VM_localDebugMapping" ) != 0 )
         unlet b:VM_localDebugMapping

         nunmap <buffer> <S-F4>
         nunmap <buffer> <C-F4>
         nunmap <buffer> <C-F9>
         nunmap <buffer> <F1>
         nunmap <buffer> <S-F1>
      endif
   else " End IF the debug mode is not active
      " Pour commenter / décommenter une zone
      "--------------------------------------
      let b:VM_localDebugMapping = 1
      nmap <buffer> <silent> <F4> :Run<CR>
      nmap <buffer> <silent> <S-F4> :Stop<CR>
      nmap <buffer> <silent> <C-F4> :Gdb<CR>
      nmap <buffer> <silent> <F9> :Over<CR>
      nmap <buffer> <silent> <S-F9> :Step<CR>
      nmap <buffer> <silent> <C-F9> :Continue<CR>
      nmap <buffer> <silent> <F1> :Break<CR>
      nmap <buffer> <silent> <S-F1> :Clear<CR>
   endif " End IF the debug mode is active
else
   call VM_ProjectTerminalMappingFile( "termCPPMapping" )
endif

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   if ( exists( "g:VM_terminalUsage" ) == 0 )
      nmap <buffer> <C-F6> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
      nmap <buffer> <S-F6> :setlocal nofoldenable<CR>
   else
      call VM_ProjectTerminalMappingFile( "termFoldMapping" )
   endif

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=syntax

      let b:foldSet = 1
   endif
endif
" Definition du code inline à utiliser
"-------------------------------------
if ( exists( "g:CPPInlineCode" ) == 0 )
   let g:CPPInlineCode = "inline "
endif

call VM_AddDictionary( g:VM_projectDirDictionary . "/cpp.dic" )

"---< Fin de fichier >----------------------------------------------------------

