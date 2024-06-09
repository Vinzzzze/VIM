" Fichier : typ.vim
"
" But : The comment for the type definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 25 janv. 2017
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentTypeReturned = input( "Type de l'attribut : " )

if ( s:currentTypeReturned == "" )
   finish
endif

let s:classUsage = ( ( "" == substitute( s:currentTypeReturned, "^[a-z][a-z]\\+_[^\\*]*$", "", "" ) )&&( s:currentTypeReturned != "size_t" )&&( s:currentTypeReturned != "ptrdiff_t" ) )

if ( s:classUsage != 0 )
   let s:macroPostName = ""
   let s:prefixeAdd = input( "Prefixe string to add : " )

   if ( s:prefixeAdd > "" )
      let s:macroPostName = toupper( s:prefixeAdd )
      let s:prefixeAdd = "##_" . s:prefixeAdd

      if ( strpart( s:macroPostName, 0, 1 ) != "_" )
         let s:macroPostName = "_" . s:macroPostName
      endif
   endif

   let s:upperTypeReturned = toupper( s:currentTypeReturned )

   echo s:upperTypeReturned . "_HSTR( prefixe" . s:prefixeAdd . " )\n"
else
   let s:currentAttributeName = input( "Nom de l'attribut à créer : " )

   if ( s:currentAttributeName == "" )
      finish
   endif

   echo s:currentTypeReturned . " " . s:currentAttributeName "\n"
endif
let s:currentLibelleName = input( "Commentaire de l'attribut : " )

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

if ( s:goForAction == "Y" )
   let s:numLine = line( "." )
   let s:currentLine = getline( s:numLine )
   let s:insertFirst = ( s:currentLine != substitute( s:currentLine, ") \\\\$", "", "" ) )

   if ( s:insertFirst != 0 )
      let s:lastLine = ( getline( s:numLine + 1 ) == "" )

      let s:searchedMark = "ADDRFIRSTFIELD"
   else
      let s:lastLine = ( s:currentLine == substitute( s:currentLine, "\\\\$", "", "" ) )

      if ( s:lastLine != 0 )
         call setline( s:numLine, s:currentLine . "; \\" )
      endif

      call append( s:numLine, "\\" )

      let s:searchedMark = toupper( substitute( substitute( substitute( substitute( s:currentLine, "prefixe##_", "", "" ), ";.*", "", "" ), "\\[.*\\]", "", "" ), "\.* ", "", "" ) )
      let s:numLine += 1

      if ( s:searchedMark == ")" )
         let s:searchedMark = "ADDRFIRSTFIELD"
      endif
   endif

   call append( s:numLine, g:VM_projectIndentation . "/**" )

   let s:startLine = s:numLine + 1
   let s:numLine = VM_PrintLimitedLengthLine( g:VM_projectIndentation . " * ", g:VM_projectIndentation . " * ", s:startLine, s:currentLibelleName, 90 )
   let s:goBackLine = s:numLine + 2

   if ( s:classUsage != 0 )
      if ( s:lastLine == 0 )
         if ( s:insertFirst != 0 )
            call append( s:numLine, "\\" )
            let s:goBackLine += 1
         endif
         call append( s:numLine, g:VM_projectIndentation . s:upperTypeReturned . "_HSTR( prefixe" . s:prefixeAdd . " ); \\" )
      else
         call append( s:numLine, g:VM_projectIndentation . s:upperTypeReturned . "_HSTR( prefixe" . s:prefixeAdd . " )" )
      endif

      call append( s:numLine, g:VM_projectIndentation . "*/ \\" )

      " Add the accessors macros
      "-------------------------
      let s:className = expand( "%:t:r" )
      let s:currentClassName = toupper( s:className )

      " Move to the line to use for the creation of the function
      "---------------------------------------------------------
      1
      /\/\*---< Macros >---------------------------------------------------------------\*\/
      /^$
      let s:numLine = line( "." )
      let s:currentLine = getline( s:numLine + 1 )

      if ( s:currentLine == substitute( s:currentLine, "_CONVERT_TO_", "", "" ) )
         call append( s:numLine, "" )
         call append( s:numLine, "" )
      endif

      call append( s:numLine, "#define " . s:currentClassName . "_CONVERT_FROM_" . s:upperTypeReturned . s:macroPostName . "( object ) " . s:currentClassName . "_PREFIXED_CONVERT_FROM_" . s:upperTypeReturned . s:macroPostName . "( std, object )" )
      call append( s:numLine, "#define " . s:currentClassName . "_CONVERT_TO_" . s:upperTypeReturned . s:macroPostName . "( object )   " . s:currentClassName . "_PREFIXED_CONVERT_TO_" . s:upperTypeReturned . s:macroPostName . "( std, object )" )
      /^$
      let s:numLine = line( "." )
      call append( s:numLine, "#define " . s:currentClassName . "_PREFIXED_CONVERT_FROM_" . s:upperTypeReturned . s:macroPostName . "( prefixe, object ) ((" . s:className . "*)( (char*)(object) - ( (char*)(" . s:currentClassName . "_CONVERT_TO_" . s:upperTypeReturned . s:macroPostName . "( ((" . s:className . "*)NULL) )) - (char*)NULL ) ))" )
      call append( s:numLine, "#define " . s:currentClassName . "_PREFIXED_CONVERT_TO_" . s:upperTypeReturned . s:macroPostName . "( prefixe, object )   ((" . s:currentTypeReturned . "*)( " . s:upperTypeReturned . "_PREFIXED_GETADDRFIRSTFIELD( prefixe" . s:prefixeAdd . ", object ) ))" )
   else
      if ( s:lastLine == 0 )
         if ( s:insertFirst != 0 )
            call append( s:numLine, "\\" )
            let s:goBackLine += 1
         endif
         call append( s:numLine, g:VM_projectIndentation . s:currentTypeReturned . " prefixe##_" . s:currentAttributeName . "; \\" )
      else
         call append( s:numLine, g:VM_projectIndentation . s:currentTypeReturned . " prefixe##_" . s:currentAttributeName )
      endif

      call append( s:numLine, g:VM_projectIndentation . "*/ \\" )

      let s:currentClassName = toupper( expand( "%:t:r" ) )
      let s:updatedAttributeName = substitute( s:currentAttributeName, "\\[.*", "", "" )
      let s:upperAttributeName = toupper( substitute( s:updatedAttributeName, "_no-export$", "", "" ) )

      " Move to the line to use for the creation of the function
      "---------------------------------------------------------
      1
      execute "/\\<" . s:currentClassName . "_GET" . s:searchedMark . "\\>"
      let s:numLine = line( "." ) + 1

      if ( s:updatedAttributeName == s:currentAttributeName )
         call append( s:numLine, "#define " . s:currentClassName . "_SET" . s:upperAttributeName . "( object, value ) " . s:currentClassName . "_PREFIXED_SET" . s:upperAttributeName . "( std, object, value )" )
      endif

      call append( s:numLine, "#define " . s:currentClassName . "_GET" . s:upperAttributeName . "( object )        " . s:currentClassName . "_PREFIXED_GET" . s:upperAttributeName . "( std, object )" )
      execute "/\\<" . s:currentClassName . "_PREFIXED_GET" . s:searchedMark . "\\>"
      let s:numLine = line( "." ) + 1

      if ( s:updatedAttributeName == s:currentAttributeName )
         call append( s:numLine, "#define " . s:currentClassName . "_PREFIXED_SET" . s:upperAttributeName . "( prefixe, object, value ) object->prefixe##_" . s:updatedAttributeName . " = value" )
      endif

      call append( s:numLine, "#define " . s:currentClassName . "_PREFIXED_GET" . s:upperAttributeName . "( prefixe, object )        object->prefixe##_" . s:updatedAttributeName )
   endif

   " Get back to the current line
   execute s:goBackLine
endif

"---< Fin de fichier >----------------------------------------------------------

