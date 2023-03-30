" Fichier : setting_csv.vim
"
" But : Mapping used to make fab use the VIM application
"
" Auteur : Vini "Cool Coyote"
" Date : 30 May 2002
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

" if ( exists( "*BuildSQLFile" ) == 0 )
" 
" " Fonction : BuildSQLFile
" "
" " But : Build the SQL file needed to add the data in the database.
" "
" " Buffer : Current CSV file
" " Alternate : Skelton file
" "
" " Parametres :
" "
" " Marks :
" "    < : The first line impacted
" "    > : The last line impacted
" " Retour :
" "
" "-------------------------------------------------------------------------------
" function BuildSQLFile()
"    " Normalisation des chaines à utiliser
"    "-------------------------------------
"    %substitute /[\[\]\&\.\*\\]/\\&/ge
"    write
"    " Recuperation des noms de colonne
"    "---------------------------------
"    let firstLine = getline( 1 )
"    let totalColumns = 0
"    while ( firstLine != "" )
"       execute "let currentColName" . totalColumns . " = \"" . substitute( firstLine, ",.*", "", "" ) . "\""
"       let newFirstLine = substitute( firstLine, "^[^,]*,", "", "" )
"       if ( newFirstLine == firstLine )
"          let firstLine = ""
"       else
"          let firstLine = newFirstLine
"       endif
"       let totalColumns = totalColumns + 1
"    endwhile
"    " Récupération dans le buffer q de la chaine de pattern à utiliser
"    "-----------------------------------------------------------------
"    edit! #
"    % yank q
"    " Vide le fichier de pattern pour Y stocker le résultat
"    "------------------------------------------------------
"    % delete
"    write!
"    edit! #
"    " Prépare le parcours de chacune des lignes
"    "------------------------------------------
"    let endLine = line( "'>" ) + 1
"    let currentLine = line( "'<" )
"    " To avoid taking the first line, this line describe the columns
"    "---------------------------------------------------------------
"    if ( currentLine < 2 )
"       let currentLine = 2
"    endif
"    while ( currentLine < endLine )
"       " Parcours chacune des colonnes de la ligne
"       "------------------------------------------
"       let nbColumns = 0
"       let contentLine = getline( currentLine )
"       while ( contentLine != "" )
"          " Extrait la colonne courante
"          "----------------------------
"          execute "let currentCol" . nbColumns . " = substitute( contentLine, \",.*\", \"\", \"\" )"
"          let nbColumns = nbColumns + 1
"          " Elimine la colonne courante de la liste des colonne
"          "----------------------------------------------------
"          let newContentLine = substitute( contentLine, "^[^,]*,", "", "" )
"          if ( newContentLine == contentLine )
"             let contentLine = ""
"          else
"             if ( substitute( contentLine, "^[^,]*,$", "", "" ) == "" )
"                execute "let currentCol" . nbColumns . " = ''"
"                let nbColumns = nbColumns + 1
"             endif
"             let contentLine = newContentLine
"          endif
"       endwhile
"       if ( totalColumns <= nbColumns )
"          " Passe dans le fichier résultat por coller la pattern et effectuer les remplacements qui vont bien
"          "--------------------------------------------------------------------------------------------------
"          edit! #
"          $
"          mark a
"          put q
"          " Boucle sur les colonnes
"          "------------------------
"          let numCurrentCol = 0
"          while ( numCurrentCol < totalColumns )
"             execute "let nameCurrentCol = currentColName" . numCurrentCol
"             execute "execute \"'a,$ substitute !#@" . nameCurrentCol . "@#!\" . currentCol" . numCurrentCol . " . \"!ge\""
"             let numCurrentCol = numCurrentCol + 1
"          endwhile
"          " Retour dans le fichier de description des colonnes
"          "---------------------------------------------------
"          write!
"          edit! #
"       endif
"       " Fin de la boucle, j'utiliserais la ligne suivante
"       "--------------------------------------------------
"       let currentLine = currentLine + 1
"    endwhile
"    " Undo the previous modify
"    "-------------------------
"    %substitute /\\\[/[/ge
"    %substitute /\\\]/]/ge
"    %substitute /\\&/\&/ge
"    %substitute /\\\././ge
"    %substitute /\\\*/*/ge
"    %substitute /\\\\/\\/ge
"    write
" endfunction
" 
" endif
" 
" if ( exists( "*ExecuteGeneration" ) == 0 )
" 
" " Fonction : ExecuteGeneration
" "
" " But : Copy the skelton file and then execute the BuildSQLFile on it
" "
" " Buffer : Current CSV file
" "
" " Parametres :
" "    fileGeneratorModel - complete filename used to generate the SQL
" " Marks :
" "    < : The first line impacted
" "    > : The last line impacted
" " Retour :
" "
" "-------------------------------------------------------------------------------
" function ExecuteGeneration( fileGeneratorModel )
"    " Remember the current file name
"    "-------------------------------
"    only
"    let currentFileName = expand( "%" )
"    " Copy the skelton file to a correct place
"    "-----------------------------------------
"    let destinationName = "C:/TEMP/execFileVIM.sql"
"    execute "edit " . destinationName
"    % delete
"    execute "1 read " . a:fileGeneratorModel
"    1 delete
"    write
"    " Retour dans le fichier d'origine
"    "---------------------------------
"    execute "edit " . currentFileName
"    " Construction du fichier SQL
"    "----------------------------
"    call BuildSQLFile()
"    " Retour dans le fichier SQL pour executer ce dernier
"    "----------------------------------------------------
"    split #
"    " Define the password to use
"    "---------------------------
"    let g:VIM_SQLPWD_PROD = "exocet32"
"    " Execute the SQL file
"    "---------------------
"    call CompileSQLFile( "DEV" )
" endfunction
" 
" endif
" 
" "-------------------------------------------------------------------------------
" " DEBUT DU CODE
" "-------------------------------------------------------------------------------
" 
" " unauthorize to stop when there will be a lot of messages
" "---------------------------------------------------------
" setlocal nomore
" " MAP : Return when nothing selected, select the line then validate it
" "---------------------------------------------------------------------
" nmap <buffer> <CR> V<CR>
" " MAP : Return when selected, execute the function to insert the lines in the database
" "-------------------------------------------------------------------------------------
" vmap <buffer> <CR> <ESC>:call ExecuteGeneration( "t:/exocet/vim/insertConfigNewDB.sql" )<CR>
" " MAP : Select always a complete line
" "------------------------------------
" nmap <buffer> v V
" nmap <buffer> <C-v> V
" " MAP : Space to begin the selection
" "-----------------------------------
" nmap <buffer> <SPACE> V
" 
" " Never be on the first line
" "---------------------------
" if ( ( line( "." ) < 2 )&&( line( "$" ) > 1 ) )
"    2
" endif

"---< Fin de fichier >----------------------------------------------------------

