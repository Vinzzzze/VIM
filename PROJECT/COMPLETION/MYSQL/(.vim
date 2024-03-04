" Fichier : (.vim
"
" But : Expand the table definition to build associated procedures.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 02 Jun 2015
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

if ( getline( "." ) == "(" )
   let s:currentLineNum = line( "." )
   let s:completeTableName = substitute( getline( s:currentLineNum - 1 ), "CREATE \\+TABLE \\+", "", "" )

   if ( s:completeTableName != getline( s:currentLineNum - 1 ) )
      let s:singleTableName = substitute( s:completeTableName, "\.*\\.", "", "" )
      let s:currentLineNum += 1
      let s:currentLineValue = substitute( getline( s:currentLineNum ), "^\t\\+", "", "" )
      let s:listColumns = []

      while ( strpart( s:currentLineValue, 0, 1 ) != ")" )
         let s:currentColumn = {}
         let s:currentColumn.name = substitute( s:currentLineValue, "^[ \t]\\+", "", "" )
         let s:currentColumn.type = substitute( substitute( s:currentColumn.name, "^[^ \t]\\+[ \t]\\+", "", "" ), "\t.*", "", "" )
         let s:currentColumn.name = substitute( s:currentColumn.name, "[ \t].*", "", "" )

         call add( s:listColumns, s:currentColumn )
         let s:currentLineNum += 1
         let s:currentLineValue = substitute( getline( s:currentLineNum ), "^\t\\+", "", "" )
      endwhile

      let s:databaseNumLine = search( "^USE ", "wn" )

      if ( s:databaseNumLine > 0 )
         let s:databaseName = substitute( getline( s:databaseNumLine ), "^USE \\+", "", "" )
      endif

      let s:completeProcName = substitute( s:completeTableName, "\\..*", ".P_", "" )
      let s:trigrame = strpart( s:singleTableName, 2, 3 )
      let s:baseProcName = toupper( strpart( s:singleTableName, 6, 1 ) ) . tolower( strpart( s:singleTableName, 7 ) )
      let s:positionWord = stridx( s:baseProcName, "_" )

      while ( s:positionWord > 0 )
         let s:lastLength = len( s:baseProcName )

         if ( s:positionWord + 1 == s:lastLength )
            let s:baseProcName = strpart( s:baseProcName, 0, s:positionWord )
         elseif ( s:positionWord + 2 == s:lastLength )
            let s:baseProcName = strpart( s:baseProcName, 0, s:positionWord ) . toupper( strpart( s:baseProcName, s:positionWord + 1, 1 ) )
         else
            let s:baseProcName = strpart( s:baseProcName, 0, s:positionWord ) . toupper( strpart( s:baseProcName, s:positionWord + 1, 1 ) ) . strpart( s:baseProcName, s:positionWord + 2 )
         endif

         let s:positionWord = stridx( s:baseProcName, "_" )
      endwhile

      let s:projectRef = expand( "%:h:h" )
      let s:comment = input( "Comment : " )
      echo "\n"

      call VM_ProjectBuildFile( "vsplit", "P_" . s:trigrame . "_Add" . s:baseProcName, "PRCADD", s:comment, s:completeProcName . s:trigrame . "_Add" . s:baseProcName . ".PRC", s:databaseName, s:projectRef )

      let s:lineToReplace = search( "<@ADD_PARAM_LIST@>", "w" )

      while ( s:lineToReplace > 0 )
         let s:lineToReplace = search( "<@ADD_PARAM_LIST@>", "w" )
      endwhile

      echo "Procs to generate :\n" . s:completeProcName . "Add" . s:baseProcName . "\n"
      echo s:completeProcName . "Upd" . s:baseProcName . "\n"
      echo s:completeProcName . "Get" . s:baseProcName . "\n"
      echo s:completeProcName . "Lst" . s:baseProcName . "\n"
      echo "Parametres :\n"
      echo s:listColumns
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

