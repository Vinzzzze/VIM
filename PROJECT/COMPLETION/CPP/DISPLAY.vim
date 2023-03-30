" Fichier : DISPLAY.vim
"
" But : How the if command had to be completed.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 11 déc. 2013
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

call setline( s:currentLineNum, s:currentLine . "_OUTPUT_FLAG_<@FLAG_NAME@>" )
call append( s:currentLineNum, s:currentIndent . "} // End DISPLAY_OUTPUT_FLAG_<@FLAG_NAME@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "} // End IF there is an object for logging" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::END_PARAM_LIST );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CURRENT_THREAD_ID," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      false," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      <@TYPE@>_LOG_MARK," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CODE_TEXT_CHAR_POINTER," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      LOGOBJECT_SUB_CODE_<@TYPE@>," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::SUB_CODE_VALUE," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      LOGOBJECT_CODE_<@CODE_MODULE@>," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CODE_VALUE," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      true," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "                                      bufferLog," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "data_LogObject::getDefaultLog()->add( data_LogObject::TEXT_CHAR_POINTER," )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "            this );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "            VM_CONST_STRING\"<@PRINT_STRING@>\"," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "VM_SPRINTF( bufferLog," )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "VM_CHAR  bufferLog[ 1024 ];" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "{" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "else" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "} // End IF there is no log object" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "         getSystemCurrentThreadId() );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "         THREAD_MARK\"<@PRINT_STRING@>\\n\"," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "fprintf( data_OutputFlags::get<@TYPE@>Output()," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "{" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "if ( data_LogObject::getDefaultLog() == NULL )" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

