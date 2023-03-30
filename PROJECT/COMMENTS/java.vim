" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let currentFunctionName = input( "Nom de la fonction à créer : " )
echo "\n"
let currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"
let currentProtection = input( "Protection de la fonction : " )
echo "\n"
let currentTypeReturned = input( "Type retourné par la fonction : " )
echo "\n"

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

" Check si le fichier est un fichier de classes
"----------------------------------------------
let numLine = line( "." )
let isInterface = search( "^//---< Interface >-\\+$" )

if ( goForAction == "Y" )
   " Cherche si la fonction à créer est inline ou non
   "-------------------------------------------------
   let voidFunction = 0
   
   if ( currentTypeReturned != substitute( currentTypeReturned, "void\\($\\| \\)", "", "" ) )
      let voidFunction = 1
   endif

   " Récupère l'indentation
   "-----------------------
   if ( exists( "g:VM_projectJIndent" ) == 0 )
      let indentation = substitute( getline( numLine ), "[^ 	].*", "", "" )
   else
      let indentation = g:VM_projectJIndent
   endif

   call append( numLine, "" )
   let numLine = numLine + 1
   call append( numLine, indentation . "/**" )
   let numLine = VM_PrintLimitedLengthLine( indentation . " * ", indentation . " * ", numLine + 1, currentLibelleName, 90 )
   call append( numLine, indentation . " *" )
   let numLine = numLine + 1
   call append( numLine, indentation . " * @param " )
   let numLine = numLine + 1

   if ( voidFunction == 0 )
      call append( numLine, indentation . " *" )
      let numLine = numLine + 1
      call append( numLine, indentation . " * @return " )
      let numLine = numLine + 1
   endif

   call append( numLine, indentation . "*/" )
   let numLine = numLine + 1

   " Build the function name
   "------------------------
   if ( isInterface == 0 )
      " Build an class function
      "------------------------
      call append( numLine, indentation . currentProtection . " " . currentTypeReturned . " " . currentFunctionName . "()" )
      let numLine = numLine + 1
      call append( numLine, indentation . "{" )
      let numLine = numLine + 1

      if ( voidFunction == 0 )
         call append( numLine, indentation . g:VM_projectIndentation . "return ;" )
         let numLine = numLine + 1
      endif

      call append( numLine, indentation . "}" )
   else
      " Build the function name
      "------------------------
      call append( numLine, indentation . currentProtection . " " . currentTypeReturned . " " . currentFunctionName . "();" )
   endif
endif

