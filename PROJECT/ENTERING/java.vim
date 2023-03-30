" Fichier : setting_java.vim
"
" But : Définition des settings des fichiers de syntaxe java.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

let functionLevel = 0

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
      let thisValue = "this."
      let staticValue = ""
   else
      let thisValue = ""
      let staticValue = "static "
   endif
   " Read the type
   "--------------
   let typeValue = substitute( substitute( currentLineValue, "^[ 	]*", "", "" ), "[ 	]\\+[_a-zA-Z][_a-zA-Z0-9]*\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*$", "", "" )
   " Eliminate the protection definition
   "------------------------------------
   let typeValue = substitute( typeValue, "\\([Pp][Rr][Ii][Vv][Aa][Tt][Ee]\\|[Pp][Rr][Oo][Tt][Ee][Cc][Tt][Ee]d\\|[Pp][Uu][Bb][Ll][Ii][Cc]\\) \\+", "", "" )
   " Read the variable name
   "-----------------------
   let variableName = substitute( substitute( substitute( getline( a:numLine ), "\\(\\|[ 	]*\\[[ 	]*[0-9A-Za-z_]\\+[ 	]*\\]\\);.*", "", "" ), "[_a-zA-Z][_a-zA-Z0-9]*$", "@@@&", "" ), "^.*@@@", "", "" )
   " Calculate the function name
   "----------------------------
   let functionName = substitute( variableName, "^_*", "", "" )
   let functionName = toupper( strpart( functionName, 0, 1 ) ) . strpart( functionName, 1 )
   " Get the variable comment
   "-------------------------
   let commentValue = substitute( getline( ( a:numLine - 2 ) ), "[ 	]* \\* ", "", "" )
   if ( commentValue == getline( ( a:numLine - 2 ) ) )
      let commentValue = substitute( getline( ( a:numLine - 1 ) ), "[ 	]*// ", "", "" )
   endif
   if ( commentValue == getline( ( a:numLine - 1 ) ) )
      let commentValue = ""
   endif
   " Create the Set function
   "------------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . g:VM_projectIndentation . thisValue . variableName . " = param;" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . g:JAVA_projectSetAccessor . staticValue . "void set" . functionName . "( " . typeValue . " param )" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Set " . commentValue )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
   " Create the get function
   "------------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . g:VM_projectIndentation . "return " . thisValue . variableName . ";" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . g:JAVA_projectGetAccessor . staticValue . typeValue . " get" . functionName . "()" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Get " . commentValue )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
endfunction

endif

if ( exists( "*CreateConstructor" ) == 0 )

" Fonction : CreateConstructor
"
" But : Create the function get and set on a class attribute
"
" Buffer : 
"    Current editting buffer
" Parametres :
"    numLine - number of the line where the attribute is declared
"-------------------------------------------------------------------------------
function CreateConstructor( numLine )
   " Read the indente value
   "-----------------------
   let indenteValue = substitute( getline( a:numLine ), "[^ 	].*", "", "" )
   " Calculate the function name
   "----------------------------
   let functionName = expand( "%:t:r" )
   " Create the function
   "--------------------
   call append( a:numLine, indenteValue . "}" )
   call append( a:numLine, indenteValue . "{" )
   call append( a:numLine, indenteValue . "public " . functionName . "()" )
   call append( a:numLine, indenteValue . "*/" )
   call append( a:numLine, indenteValue . " * Constructor." )
   call append( a:numLine, indenteValue . "/**" )
   call append( a:numLine, "" )
endfunction

endif

if ( exists( "*IndenteFunction" ) == 0 )

" Fonction : IndentLine
"
" But : Create the function get and set on a class attribute
"
" Buffer : 
"    Current editting buffer
" Parametres :
"    completeFunctionName - The complete function name with the open bracet
"    parameterPart - The parameter list of the function
"    indenteValue - The indentation level
"    numLine - number of the line where the attribute is declared
"-------------------------------------------------------------------------------
function IndenteFunction( completeFunctionName, parameterPart, indenteValue, numLine )
   let currentFunctionName = a:completeFunctionName
   let parameterList = substitute( substitute( a:parameterPart, "^[ 	]*", "", "" ), "[ 	]$", "", "" )
   let firstParameter = substitute( parameterList, "[,()].*", "", "" )
   let lastParameters = strpart( parameterList, strlen( firstParameter ) )
   let firstParameter = substitute( firstParameter, "[ 	]$", "", "" )
   let retNum = a:numLine
	let repeat = 1

	while ( repeat > 0 )
		let currentFunctionLevel = g:functionLevel
		let repeat = 0

      if ( ( firstParameter == "" ) && ( strpart( lastParameters, 0, 1 ) == ")" ) )
         let currentFunctionName = substitute( currentFunctionName, "([ 	]*$", "", "" )
         let lineToAdd = a:indenteValue . currentFunctionName

         call setline( a:numLine, lineToAdd . "§§" . strpart( lastParameters, 1 ) )
         call IndentLine( a:numLine )
         call setline( a:numLine, lineToAdd . "()" . strpart( getline( a:numLine ), strlen( lineToAdd ) + 2 ) )

         let retNum = -1
      elseif ( lastParameters == "" )
			call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " " )
		elseif ( strpart( lastParameters, 0, 1 ) == "(" )
			let endOfFunction = substitute( strpart( lastParameters, 1 ), "^[ 	]*", "", "" )

			if ( strpart( endOfFunction, 0, 1 ) == ")" )
				let firstParameter = firstParameter . "()" . substitute( strpart( endOfFunction, 1 ), "[,()].*", "", "" )
				let lastParameters = strpart( parameterList, strlen( firstParameter ) )
            let firstParameter = substitute( firstParameter, "[ 	]$", "", "" )

				let repeat = 1
			else
				let g:functionLevel = g:functionLevel + 1

				let retNum = IndenteFunction( currentFunctionName . firstParameter . "( ", strpart( lastParameters, 1 ), a:indenteValue, retNum )

				if ( retNum <= 0 )
					let retNum = -1
				elseif ( currentFunctionLevel == g:functionLevel )
					let currentFunctionName = substitute( currentFunctionName, "[^	]", " ", "g" )
					let parameterList = substitute( substitute( getline( retNum ), "^[ 	]*", "", "" ), "[ 	]$", "", "" )
					let firstParameter = substitute( parameterList, "[,()].*", "", "" )
					let lastParameters = strpart( parameterList, strlen( firstParameter ) )
               let firstParameter = substitute( firstParameter, "[ 	]$", "", "" )

					let repeat = 1
				else
					let retNum = retNum - 1
				endif
			endif
		elseif ( strpart( lastParameters, 0, 1 ) == ")" )
			let endFunction = substitute( strpart( lastParameters, 1 ), "^[ 	]*", "", "" )
			let repeatEnd = 1

			while ( repeatEnd > 0 )
				let g:functionLevel = g:functionLevel - 1
				let repeatEnd = 0

				if ( strpart( endFunction, 0, 1 ) == "," )
					if ( substitute( strpart( endFunction, 1 ), "^[ 	]*//.*", "", "" ) == "" )
						call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " )" . endFunction )
						let retNum = -1
					else
						call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " )," )

						let endFunction = substitute( strpart( endFunction, 1 ), "^[ 	]*", "", "" )

						if ( endFunction > "" )
							call append( retNum, endFunction )
						else
							let retNum = -1
						endif
					endif
				elseif ( strpart( endFunction, 0, 1 ) == ";" )
					if ( substitute( strpart( endFunction, 1 ), "^[ 	]*//.*", "", "" ) == "" )
						call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " )" . endFunction )
						let retNum = -1
					else
						call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " );" )

						let endFunction = substitute( strpart( endFunction, 1 ), "^[ 	]*", "", "" )

						if ( endFunction > "" )
							call append( retNum, endFunction )
						else
							let retNum = -1
						endif
					endif

					if ( retNum > 0 )
						call append( retNum, "" )
					endif
				elseif ( strpart( endFunction, 0, 1 ) == "." )
               let otherParameter = substitute( substitute( endFunction, "[^()]*", "", "" ), "[ 	]*$", "", "" )
               let endFunction = substitute( substitute( endFunction, "[()].*", "", "" ), "[ 	]*$", "", "" )

               if ( otherParameter == "" )
                  let currentRealLine = a:indenteValue . currentFunctionName . firstParameter . " )"
                  let currentAnalyzeLine = substitute( currentRealLine, "[()]", "§", "g" )

						call setline( retNum, currentAnalyzeLine . endFunction )
                  call IndentLine( retNum )
						call setline( retNum, currentRealLine . strpart( getline( retNum ), strlen( currentAnalyzeLine ) ) )

                  let retNum = -1
               elseif ( strpart( otherParameter, 0, 1 ) == "(" )
                  let currentFunctionName = currentFunctionName . firstParameter . " )" . endFunction . "( "
                  let parameterList = substitute( substitute( strpart( otherParameter, 1 ), "^[ 	]*", "", "" ), "[ 	]$", "", "" )
                  let firstParameter = substitute( parameterList, "[,()].*", "", "" )
                  let lastParameters = strpart( parameterList, strlen( firstParameter ) )
                  let firstParameter = substitute( firstParameter, "[ 	]$", "", "" )

                  let repeat = 1
               elseif ( strpart( otherParameter, 0, 1 ) == ")" )
                  let firstParameter = firstParameter . " )" . endFunction
                  let endFunction = substitute( strpart( otherParameter, 1 ), "^[ 	]*", "", "" )

                  let repeatEnd = 1
               endif
				elseif ( strpart( endFunction, 0, 1 ) == ")" )
					let firstParameter = firstParameter . " )"
					let endFunction = substitute( strpart( endFunction, 1 ), "^[ 	]*", "", "" )

					let repeatEnd = 1
				elseif ( endFunction > "" )
					call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . " )" )

					let endFunction = substitute( endFunction, "^[ 	]*", "", "" )

					if ( endFunction > "" )
						call append( retNum, a:indenteValue . endFunction )

						let retNum = retNum - 1
					else
						let retNum = -1
					endif
				endif
			endwhile
		elseif ( strpart( lastParameters, 0, 1 ) == "," )
			call setline( retNum, a:indenteValue . currentFunctionName . firstParameter . "," )

			let nextParameter = substitute( strpart( lastParameters, 1 ), "[ 	]*$", "", "" )

			if ( nextParameter > "" )
				let currentFunctionName = substitute( currentFunctionName, "[^	]", " ", "g" )

				call append( retNum, a:indenteValue . currentFunctionName . nextParameter )

				let retNum = IndenteFunction( currentFunctionName, nextParameter, a:indenteValue, retNum + 1 ) - 1
			endif
		endif
	endwhile

   return ( retNum + 1 )
endfunction

endif

if ( exists( "*IndentLine" ) == 0 )

" Fonction : IndentLine
"
" But : Create the function get and set on a class attribute
"
" Buffer : 
"    Current editting buffer
" Parametres :
"    numLine - number of the line where the attribute is declared
"-------------------------------------------------------------------------------
function IndentLine( numLine )
   " Reset the function level value
   "-------------------------------
   let g:functionLevel = 0
   " Read the indente value
   "-----------------------
   let indenteValue = substitute( getline( a:numLine ), "[^ 	].*", "", "" )
   " Get the line without the indente
   "---------------------------------
   let noIndenteLine = substitute( substitute( getline( a:numLine ), "^" . indenteValue , "", "" ), "[ 	]*$", "", "" )

   if ( noIndenteLine == "" )
      call setline( a:numLine, "" )
   elseif ( substitute( noIndenteLine, "[    ]*//.*", "", "" ) == "{" )
      call setline( a:numLine, indenteValue . noIndenteLine )
   elseif ( substitute( noIndenteLine, "[    ]*//.*", "", "" ) == "}" )
      call setline( a:numLine, indenteValue . noIndenteLine )
   else
      let beforeSeparator = substitute( noIndenteLine, "[(){};].*", "", "" )
      let separatorAndAfter = substitute( noIndenteLine, "[^(){};]*", "", "" )

      if ( separatorAndAfter == "" )
         call setline( a:numLine, indenteValue . noIndenteLine )
      elseif ( strpart( separatorAndAfter, 0, 1 ) == "{" )
         if ( beforeSeparator > "" )
            call setline( a:numLine, indenteValue . beforeSeparator )
            call append( a:numLine, indenteValue . separatorAndAfter )

				call IndentLine( a:numLine + 1 )
         elseif ( substitute( separatorAndAfter, "^}[ 	]*//.*", "", "" ) == "" )
            call setline( a:numLine, indenteValue . separatorAndAfter )
			else
            call setline( a:numLine, indenteValue . "{" )

            let finalPartLine = substitute( substitute( strpart( separatorAndAfter, 1, 0 ), "^[ 	]*", "", "" ), "[ 	]*$", "", "" )

            if ( finalPartLine == "" )
               let nextLineValue = getline( a:numLine + 1 )

               while ( ( a:numLine < line( "$" ) ) && ( nextLineValue == "" ) )
                  execute a:numLine + 1 . " delete"

                  let nextLineValue = getline( a:numLine + 1 )
               endwhile
            else
               call append( a:numLine, indenteValue . "	" . finalPartLine )

					call IndentLine( a:numLine + 1 )
            endif
         endif
      elseif ( strpart( separatorAndAfter, 0, 1 ) == "}" )
         if ( beforeSeparator > "" )
            call setline( a:numLine, indenteValue . beforeSeparator )
            call append( a:numLine, substitute( indenteValue, "	", "", "" ) . separatorAndAfter )

				call IndentLine( a:numLine + 1 )
         else
            call setline( a:numLine, indenteValue . "}" )

            let finalPartLine = substitute( substitute( strpart( separatorAndAfter, 1 ), "[ 	]*$", "", "" ), "^[ 	]*", "", "" )

            if ( finalPartLine == "" )
               let nextLineValue = getline( a:numLine + 1 )

               while ( ( a:numLine < line( "$" ) ) && ( nextLineValue == "" ) )
                  execute a:numLine + 1 . " delete"

                  let nextLineValue = getline( a:numLine + 1 )
               endwhile

               if ( a:numLine < line( "$" ) )
                  let nextLineValue = getline( a:numLine + 1 )

                  if ( substitute( nextLineValue, "^[ 	]*}", "", "" ) == nextLineValue )
                     call append( a:numLine, "" )
                  endif
               else
                  call append( a:numLine, "" )
               endif
            else
               call append( a:numLine, indenteValue . finalPartLine )

					call IndentLine( a:numLine + 1 )
            endif
         endif
      elseif ( strpart( separatorAndAfter, 0, 1 ) == "(" )
         let beforeSeparator = substitute( beforeSeparator, "[ 	]\\+$", "", "" )
         let beforeSeparator = substitute( beforeSeparator, "if$", "if ", "" )
         let beforeSeparator = substitute( beforeSeparator, "while$", "while ", "" )
         let beforeSeparator = substitute( beforeSeparator, "for$", "for ", "" )
         let beforeSeparator = substitute( beforeSeparator, "catch$", "catch ", "" )

         let retNum = IndenteFunction( beforeSeparator . "( ", strpart( separatorAndAfter, 1 ), indenteValue, a:numLine )

			if ( retNum > 0 )
				call IndentLine( retNum + 1 )
			endif
      elseif ( strpart( separatorAndAfter, 0, 1 ) == ")" )
         let separatorAndAfer = substitute( separatorAndAfter, ")[ 	]*,", "),", "" )
         let separatorAndAfer = substitute( separatorAndAfter, ")[ 	]*;", ");", "" )

         if ( substitute( separatorAndAfter, ")\\(\\|[,;]\\)[ 	]*//.*", "", "" ) == "" )
            call setline( a:numLine, indenteValue . substitute( beforeSeparator, "[ 	]\\+$", "", "" ) . " " . separatorAndAfter )
         else
            let nextLineValue = substitute( separatorAndAfter, ")\\(\\|[,;]\\)[ 	]*", "", "" )
            let separatorAndAfter = substitute( separatorAndAfter, "[ 	]*" . nextLineValue . "$", "", "" )

            call setline( a:numLine, indenteValue . substitute( beforeSeparator, "[ 	]\\+$", "", "" ) . " " . separatorAndAfter )
            call append( a:numLine, indenteValue . nextLineValue )
            call append( a:numLine, "" )
         endif
      elseif ( strpart( separatorAndAfter, 0, 1 ) == ";" )
         call setline( a:numLine, indenteValue . substitute( beforeSeparator, "[ 	]\\+$", "", "" ) . ";" )

         if ( strpart( separatorAndAfter, 1 ) > "" )
            call append( a:numLine, indenteValue . strpart( separatorAndAfter, 1 ) )

            call IndenteLine( a:numLine + 1 )
         endif
      endif
   endif
endfunction

endif

if ( exists( "*AddImport" ) == 0 )

" Fonction : AddImport
"
" But : Add the import command for the specified name.
"
" Parametres :
"    classSearched - The class that we want to import in the current file
"-------------------------------------------------------------------------------
function AddImport( classSearched )
   let linesToAdd = VM_GetProjectsImports( "\\." . a:classSearched . ";$" )
   if ( len( linesToAdd ) > 0 )
      call append( 2, linesToAdd )
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Redéfinition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=3
setlocal tabstop=3
setlocal matchpairs=(:),{:},[:],<:>

" Le mapping pour se déplacer dans les folders
"---------------------------------------------
nmap <buffer> <M-F6> :call IndentLine( line( "." ) )<CR>
" Pour la creation automatique des get et set des attributs
"----------------------------------------------------------
nmap <buffer> <F9> :call CreateGetSet( line( "." ) )<CR>
nmap <buffer> <S-F9> :call CreateConstructor( line( "." ) )<CR>

" Pour commenter / décommenter une zone
"--------------------------------------
vmap <buffer> <F2> <ESC>:call VM_CommentAtMinIndente( "// " )<CR>
vmap <buffer> <S-F2> :substitute /\/\/ //<CR>
map <buffer> <C-F5> :call AddImport( expand( "<cword>" ) )<CR>

" Le mapping ne sera fait que si on ne se trouve pas pas une version diff du fichier
"-----------------------------------------------------------------------------------
if ( &diff == 0 )
   " Le mapping pour déclancher/arrêter la lecture des PDLs via le folder
   "---------------------------------------------------------------------
   nmap <buffer> <F6> :setlocal foldmethod=syntax<CR>:setlocal foldenable<CR>
   nmap <buffer> <S-F6> :setlocal nofoldenable<CR>

   if ( ( exists( "b:foldSet" ) == 0 )&&( VM_TestFoldDisabled() == 0 ) )
      " Auto launch the fold options
      "-----------------------------
      setlocal foldenable
      setlocal foldmethod=syntax

      let b:foldSet = 1
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

