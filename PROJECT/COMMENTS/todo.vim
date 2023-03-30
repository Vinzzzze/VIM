" Fichier : todo.vim
"
" But : Build the specified task
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 29 nov. 2013
"
"-------------------------------------------------------------------------------

" Récupère le nom de la classe
"-----------------------------
let priority = input( "Priority (H|M|L) : " )
echo "\n"

if ( priority == "H" || priority == "M" || priority == "L" )

   let level = input( "Level : " )
   echo "\n"
   let title = input( "Title : " )
   echo "\n"
   let summary = input( "Summary : " )
   echo "\n"
   let subject = input( "Subject : " )
   echo "\n"
   let text = input( "Text : " )
   echo "\n"
   let valid = input( "Valid ( Y or N ) : " )
   echo "\n"

   if ( valid == "Y" )

      if ( level != "" )
         let level = "[" . level . "] "
      endif

      if ( priority == "H" )
         let intro = "*++< " . level . title . " >++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
         let outro = "*++<>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
      elseif ( priority == "M" )
         let intro = "*+-< " . level . title . " >------------------------------------------------------------------------------------------"
         let outro = "*+-<>------------------------------------------------------------------------------------------"
      else
         let intro = "*--< " . level . title . " >------------------------------------------------------------------------------------------"
         let outro = "*--<>------------------------------------------------------------------------------------------"
      endif

      call append( line( "$" ), strpart( intro, 0, 90 ) )
      call append( line( "$" ), "" )

      if ( text != "" )
         call VM_PrintLimitedLengthLine( g:VM_todoIndentation, g:VM_todoIndentation, line( "$" ), text, 87 )
         call append( line( "$" ), "" )
      endif

      call append( line( "$" ), "Author : " . $USER_NAME )

      if ( summary != "" )
         call append( line( "$" ), "" )
         call append( line( "$" ), "Summary" )
         call append( line( "$" ), "" )
         call VM_PrintLimitedLengthLine( g:VM_todoIndentation, g:VM_todoIndentation, line( "$" ), summary, 87 )
      endif

      if ( subject != "" )
         call append( line( "$" ), "" )
         call append( line( "$" ), "Subject" )
         call append( line( "$" ), "" )
         call VM_PrintLimitedLengthLine( g:VM_todoIndentation, g:VM_todoIndentation, line( "$" ), subject, 87 )
      endif

      call append( line( "$" ), strpart( outro, 0, 90 ) )
   endif
else
   echo "Unknown priority [" . priority . "]\n"
endif

"---< Fin de fichier >----------------------------------------------------------

