" Je demande le nom de la fonction et le libellé que je vais devoir utiliser
"---------------------------------------------------------------------------
let s:currentFunctionName = input( "Nom de la fonction a créer : " )
echo "\n"
let s:currentLibelleName = input( "Commentaire de la fonction : " )
echo "\n"

" Vérification de la validité des opérations saisies
"---------------------------------------------------
let s:goForAction = input( "Les informations saisies sont-elles correctes ( Y/N ) : " )

if ( s:goForAction == "Y" )
   let numLine = line( "." )

   " Récupère l'indentation
   "-----------------------
   if ( exists( "g:VM_projectPHPIndent" ) == 0 )
      let indentation = substitute( getline( numLine ), "[^ 	].*", "", "" )
   else
      let indentation = g:VM_projectJIndent
   endif

   call append( numLine, "" )
   let numLine = numLine + 1
   call append( numLine, indentation . "/**" )
   let numLine = VM_PrintLimitedLengthLine( indentation . " * ", indentation . " * ", numLine + 1, s:currentLibelleName, 90 )
   call append( numLine, indentation . " *" )
   let numLine = numLine + 1
   call append( numLine, indentation . " * @param <@PARAM_DEFINITION@>" )
   let numLine = numLine + 1
   call append( numLine, indentation . " *" )
   let numLine = numLine + 1
   call append( numLine, indentation . " * @return <@RETURN_VALUE@>" )
   let numLine = numLine + 1
   call append( numLine, indentation . "*/" )
   let numLine = numLine + 1
   call append( numLine, indentation . "function " . s:currentFunctionName . "(<@PARAM_LIST@>)" )
   let numLine = numLine + 1
   call append( numLine, indentation . "{" )
   let numLine = numLine + 1
   call append( numLine, indentation . "}" )
endif

