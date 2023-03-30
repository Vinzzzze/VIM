" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom de la fonction à créer : " )
echo "\n"
let s:currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"
let s:currentTypeReturned = input( "Type retourné par la fonction : " )
echo "\n"

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

" Check si le fichier est un fichier de classes
"----------------------------------------------
let s:numLine = line( "." )
let s:isFunction = search( "^//---< Functions >-\\+$" )

if ( s:goForAction == "Y" )
   " Cherche si la fonction à créer est inline ou non
   "-------------------------------------------------
   let s:inlineText = 0
   let s:voidFunction = 0
   let s:virtualPure = 0
   
   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "[Ii][Nn][Ll][Ii][Nn][Ee] ", "", "" ) )
      let s:inlineText = 1
   endif

   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let s:voidFunction = 1
   endif

   if ( s:currentTypeReturned != substitute( s:currentTypeReturned, "[Vv][Ii][Rr][Tt][Uu][Aa][Ll] ", "", "" ) )
      if ( "Y" == input( "Virtual pure function ( Y/N ) : " ) )
         let s:virtualPure = 1
      endif
   endif

   if ( s:isFunction == 0 )
      " Je récupère le nom du fichier qui correspond au nom de l'élément courant
      "-------------------------------------------------------------------------
      let s:elementName = expand( "%:t:r" ) . "::"

      " Récupère l'indentation
      "-----------------------
      if ( exists( "g:VM_projectHIndent" ) == 0 )
         let s:indentation = substitute( getline( s:numLine ), "[^ 	].*", "", "" )
      else
         let s:indentation = g:VM_projectHIndent
      endif
   else
      " Il n'y a pas d'element name
      "----------------------------
      let s:elementName = ""
      " Il n'y a pas d'indentation
      "---------------------------
      let s:indentation = ""
   endif

   " Call the function used to build the header
   "-------------------------------------------
   let s:numLine = BuildFunctionComment( s:numLine, s:indentation, s:currentFunctionName, s:currentLibelleName, s:voidFunction )

   " Build the function name
   "------------------------
   if ( s:inlineText != 0 )
      " Build an include function
      "--------------------------
      call append( s:numLine, s:indentation . s:currentTypeReturned . " " . s:currentFunctionName . "()" )
      let s:numLine = s:numLine + 1
      call append( s:numLine, s:indentation . "{" )
      let s:numLine = s:numLine + 1

      if ( s:voidFunction == 0 )
         call append( s:numLine, s:indentation . g:VM_projectIndentation . "return <@RETURNED_VALUE@>;" )
         let s:numLine = s:numLine + 1
      endif

      call append( s:numLine, s:indentation . "}" )
   elseif ( s:virtualPure != 0 )
      " Build the function name
      "------------------------
      call append( s:numLine, s:indentation . s:currentTypeReturned . " " . s:currentFunctionName . "() = 0;" )
   else
      " Build the function name
      "------------------------
      call append( s:numLine, s:indentation . s:currentTypeReturned . " " . s:currentFunctionName . "();" )

      " Open the alternate file to build the body function
      "---------------------------------------------------
      if ( CPPOpenAlternate( "split" ) != 0 )
         " Save the modified status
         "-------------------------
         let s:saveAlternate = &modified

         " Move to the line to use for the creation of the function
         "---------------------------------------------------------
         $
         ?^}

         " Determine the alternate type
         "-----------------------------
         let s:alternateType = substitute( substitute( s:currentTypeReturned, "static \\+", "", "" ), "[A-Za-z_]*[Vv][Ii][Rr][Tt][Uu][Aa][Ll] \\+", "", "" )

         " Build the body
         "---------------
         call BuildFunctionBody( line( "." ), s:alternateType, s:currentFunctionName, s:elementName, s:currentLibelleName, s:voidFunction )

         " Close the file opened
         "----------------------
         if ( s:saveAlternate == 0 )
            write
         endif

         quit
      endif
   endif
endif

