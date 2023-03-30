" Fichier : log.vim
"
" But : The log creation definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 02 mai 2018
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

let s:currentLineNum = line( "." )
let s:currentLine = getline( s:currentLineNum )
let s:currentIndent = substitute( s:currentLine, "[^ 	].*", "", "" )
let s:currentFolder = "%:h"
let s:lastRead = expand( s:currentFolder )

if ( exists( "g:criticity" ) == 0 )
   call inputsave()
   let g:criticity = toupper( input( "Criticity ( ERROR|WARNING|INFO|EXCEPTION ) : " ) )
   call inputrestore()
endif " End IF the criticity is not defined

while ( s:lastRead != "." )
   let s:lastFolder = s:lastRead
   let s:currentFolder .= ":h"
   let s:lastRead = expand( s:currentFolder )
endwhile " End WHILE the base folder had not been found

if ( exists( "s:lastFolder" ) == 0 )
   let s:codeLog = "BASE_LOGGER_CODE_<@CODE_LOG@>_" . g:criticity
   let s:lastFolder = "<@SUBJECT@>"
" End IF the folder had not been found
elseif ( substitute( s:lastFolder, "LIB$", "", "" ) == s:lastFolder )
   let s:codeLog = "BASE_LOGGER_CODE_LOG_APPLICATION_" . g:criticity
   let s:lastFolder = "<@APPLICATION@>"
else " End IF the current folder is not a library
   let s:codeLog = "BASE_LOGGER_CODE_LOG_" . substitute( s:lastFolder, "LIB$", "", "" ) . "_" . g:criticity
endif " End IF the curent folder is a library

call setline( s:currentLineNum, s:currentIndent . "BASE_LOGGER_WRITELOG( " . s:codeLog . "," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_CODE_VALUE_END )" )
call append( s:currentLineNum, s:currentIndent . "                      logParam<@PARAM@>," )
call append( s:currentLineNum, s:currentIndent . "                      <@TEXT_LOG_IDENTIFIER@>," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_CODE_VALUE_ID_TEXT," )
call append( s:currentLineNum, s:currentIndent . "                      COMMONCONSTANTS_" . s:lastFolder . "_ID_SUBJECT," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_CODE_VALUE_ID_SUBJECT," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_CRITICITY_" . g:criticity . "," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_CODE_VALUE_ID_CRITICITY," )
call append( s:currentLineNum, s:currentIndent . "                      BASE_LOGGER_DEFAULT_LOG_PARAM," )

unlet g:criticity

"---< Fin de fichier >----------------------------------------------------------

