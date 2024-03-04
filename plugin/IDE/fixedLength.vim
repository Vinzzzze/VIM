" Fichier : fixedLength.vim
"
" But : The plugin used to handle the fixed length files.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 13 Jan 2020
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_ReadFixedLength" ) == 0 )

" Fonction : VM_ReadFixedLength
"
" But : Get the columns definition
"
" Buffer : 
"  Fixed length file
" Parametres :
"  fixedLengthFile - string : The conplete filename where the column definition can be found
"-------------------------------------------------------------------------------
function VM_ReadFixedLength( fixedLengthFile )
   let b:lengthColumn = 10
   let b:indexColumn = 1
   let firstColumn = 1

   if ( exists( "b:lastUsedColumn" ) != 0 )
     unlet b:lastUsedColumn
   endif

   let b:arrayColIndex = [ {} ]
   let b:arrayColPosition = [ {} ]
   let b:arrayColName = {}

   for currentLine in readfile( a:fixedLengthFile )
      let columnSize = substitute( currentLine, " .*", "", "" )
      let columnName = substitute( currentLine, "\.* ", "", "" )

      if ( b:lengthColumn < len( columnName ) )
         let b:lengthColumn = len( columnName )
      endif " End IF the length of the largest column name had to be updated

      let currentColumn = { "name" : columnName, "size" : columnSize, "position" : firstColumn, "index" : b:indexColumn }

      call add( b:arrayColIndex, currentColumn )
      let b:arrayColName[ columnName ] = currentColumn
      let b:indexColumn += 1
      let firstColumn += columnSize

      while ( columnSize > 0 )
        call add( b:arrayColPosition, currentColumn )

        let columnSize -= 1
      endwhile " End WHILE all the positions are marked as belonging to the right column
   endfor " End FOR all the columns in the definition file

   let b:lastColumn = firstColumn
endfunction

endif

if ( exists( "*VM_DisplayColumn" ) == 0 )

" Fonction : VM_DisplayColumn
"
" But : Display	 the column name of the current position
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_DisplayColumn()
   let colIndex = col( "." )

   if ( colIndex >= b:lastColumn )
      echo "ERROR : beyond last column definition"
   else " End IF we are after the last column definition
      echo b:arrayColPosition[ colIndex ].name
   endif " End IF we are able to display the column name
endfunction

endif

if ( exists( "*VM_AutoCommandFixedLengh" ) == 0 )

" Fonction : VM_AutoCommandFixedLengh
"
" But : Initialize the auto commands for the fixed length files
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_AutoCommandFixedLengh()
   autocmd CursorMoved <buffer> :call VM_DisplayColumn()
endfunction

endif

if ( exists( "*VM_DisplayColumnName" ) == 0 )

" Fonction : VM_DisplayColumnName
"
" But : Display the current column definition
"
" Parametres :
"  currentBuffer - object : The column dictionary definition
"-------------------------------------------------------------------------------
function VM_DisplayColumnName( currentBuffer )
   if ( exists( "a:currentBuffer.name" ) != 0 )
      call append( line( "$" ), a:currentBuffer.name )
   endif " End IF the column definition is complete
endfunction

endif

if ( exists( "*VM_OpenColumnWindow" ) == 0 )

" Fonction : VM_OpenColumnWindow
"
" But : Open the window to enable an action on the columns
"
" Buffer : 
"  Fixed length file
" Parametres :
"  modeAction - string : The action to be done : search or another value
"-------------------------------------------------------------------------------
function VM_OpenColumnWindow( modeAction )
   let colIndex = col( "." )

   if ( colIndex < b:lastColumn )
      let defaultLine = b:arrayColPosition[ colIndex ].index
   else " End IF we are able to go to the column used
      let defaultLine = b:arrayColPosition[ b:lastColumn - 1 ].index
   endif " End IF we will go to the last column

   call VM_DisplayInternalWindow( "[Columns]", "vert " . g:VM_fixedColumnWindowPos . " " . ( b:lengthColumn + 3 ) . " sview", "VM_fixed_length_column_internal", b:arrayColIndex, "VM_DisplayColumnName" )

   let b:modeAction = a:modeAction
   execute defaultLine
endfunction

endif

if ( exists( "*VM_FixedLengthActionExec" ) == 0 )

" Fonction : VM_FixedLengthActionExec
"
" But : The action todo on retun key pressed
"
" Buffer : 
"  The column definition list
"-------------------------------------------------------------------------------
function VM_FixedLengthActionExec()
   let columnIndex = line( "." )
   let modeAction = b:modeAction

   close

   let b:lastUsedColumn = b:arrayColIndex[ columnIndex ]

   if ( modeAction == "search" )
      0
      let columnSearchPos = ""
      let paternSearch = input( "Patern to search in column " . b:lastUsedColumn.name . " : " )

      if ( columnIndex > 1 )
         let columnSearchPos = ".\\{" . ( b:lastUsedColumn.position - 1 ) . "\\}"
      endif " End IF we are not searching in the first column

      execute "/^" . columnSearchPos . paternSearch
   else " End IF we are searching for a value in the specified column
      call VM_FixedLengthGotoColumn( b:lastUsedColumn, 0 )
   endif " End IF we want to move to the column position
endfunction

endif

if ( exists( "*VM_FixedLengthGotoColumn" ) == 0 )

" Fonction : VM_FixedLengthGotoColumn
"
" But : Goto the specified column
"
" Buffer : 
"  Fixed length file
" Parametres :
"   currentCol - object : The column where to go to dictionary definition
"   modè - bool : 0 to go to the beginig of the column, another value to go to the end
"-------------------------------------------------------------------------------
function VM_FixedLengthGotoColumn( currentCol, mode )
   let currentPos = getpos( "." )
   let position = a:currentCol.position

   if ( a:mode != 0 )
      let position += a:currentCol.size - 1
   endif

   if ( currentPos[ 2 ] == position )
      call VM_DisplayColumn()
   else " End IF we are already on the rigth position
      let currentPos[ 2 ] = position

      call setpos( ".", currentPos )
   endif " End IF we need to move
endfunction

endif

if ( exists( "*VM_FixedLengthPreviousColumn" ) == 0 )

" Fonction : VM_FixedLengthPreviousColumn
"
" But : Goto the previous column
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_FixedLengthPreviousColumn()
   let colIndex = col( "." )

   if ( colIndex >= b:lastColumn )
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ b:lastColumn - 1 ], 0 )
   else " End IF we are after the last column definition
      let colIndex = b:arrayColPosition[ colIndex ].index - 1

      if ( colIndex < 1 )
         let colIndex = 1
      endif

      call VM_FixedLengthGotoColumn( b:arrayColIndex[ colIndex ], 0 )
   endif " End IF we are able to go to tho previous column
endfunction

endif

if ( exists( "*VM_FixedLengthNextColumn" ) == 0 )

" Fonction : VM_FixedLengthNextColumn
"
" But : Goto the next column
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_FixedLengthNextColumn()
   let colIndex = col( "." )

   if ( colIndex >= b:lastColumn )
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ b:lastColumn - 1 ], 0 )
   else " End IF we are after the last column definition
      let colIndex = b:arrayColPosition[ colIndex ].index + 1

      if ( colIndex >= b:indexColumn )
         let colIndex = b:indexColumn - 1
      endif

      call VM_FixedLengthGotoColumn( b:arrayColIndex[ colIndex ], 0 )
   endif " End IF we are able to go to tho previous column
endfunction

endif

if ( exists( "*VM_FixedLengthLastUsedColumn" ) == 0 )

" Fonction : VM_FixedLengthLastUsedColumn
"
" But : Goto the last used column when it’s defined
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_FixedLengthLastUsedColumn()
   if ( exists( "b:lastUsedColumn" ) != 0 )
      call VM_FixedLengthGotoColumn( b:lastUsedColumn, 0 )
   endif
endfunction

endif

if ( exists( "*VM_FixedLengthGotoColStart" ) == 0 )

" Fonction : VM_FixedLengthGotoColStart
"
" But : Go to the current column start
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_FixedLengthGotoColStart()
   let colIndex = col( "." )

   if ( colIndex >= b:lastColumn )
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ b:lastColumn - 1 ], 0 )
   else " End IF we are after the last column definition
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ colIndex ], 0 )
   endif " End IF we are able to go to tho previous column
endfunction

endif

if ( exists( "*VM_FixedLengthGotoColEnd" ) == 0 )

" Fonction : VM_FixedLengthGotoColEnd
"
" But : Go to the current column end
"
" Buffer : 
"  Fixed length file
"-------------------------------------------------------------------------------
function VM_FixedLengthGotoColEnd()
   let colIndex = col( "." )

   if ( colIndex >= b:lastColumn )
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ b:lastColumn - 1 ], 1 )
   else " End IF we are after the last column definition
      call VM_FixedLengthGotoColumn( b:arrayColPosition[ colIndex ], 1 )
   endif " End IF we are able to go to tho previous column
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "g:VM_fixedColumnWindowPos" ) == 0 )
   let g:VM_fixedColumnWindowPos = "rightbelow"
endif

"---< Fin de fichier >----------------------------------------------------------

