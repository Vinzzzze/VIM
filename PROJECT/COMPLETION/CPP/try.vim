" Fichier : try.vim
"
" But : How the try ... catch command can be completed
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 déc. 2013
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

call append( s:currentLineNum, s:currentIndent . "} // End CATCH all the exceptions while trying to <@TRY_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@EXCEPTION_ALL_STATEMENT@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "} // End DISPLAY_OUTPUT_FLAG_EXCEPTION" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "} // End IF there is an object for logging" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::END_PARAM_LIST );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CURRENT_THREAD_ID," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      false," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      UNEXPECTED_EXCEPTION_LOG_MARK," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CODE_TEXT_CHAR_POINTER," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      LOGOBJECT_SUB_CODE_EXCEPTION," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::SUB_CODE_VALUE," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      LOGOBJECT_CODE_<@CODE_MODULE@>," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      data_LogObject::CODE_VALUE," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      true," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "                                      bufferLog," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "data_LogObject::getDefaultLog()->add( data_LogObject::TEXT_CHAR_POINTER," )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "            this );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "            VM_CONST_STRING\"\"TEXT_EXCEPTION_MACRO," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "VM_SPRINTF( bufferLog," )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "VM_CHAR  bufferLog[ 1024 ];" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "{" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "else" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "} // End IF there is no log object" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "         this );" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "         getSystemCurrentThreadId()," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "         THREAD_MARK\"\"UNKNOWN_EXCEPTION_MARK\"\"TEXT_EXCEPTION_MACRO\"\\n\"," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . g:VM_projectIndentation . "fprintf( data_OutputFlags::getErrOutput()," )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "{" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . g:VM_projectIndentation . "if ( data_LogObject::getDefaultLog() == NULL )" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "{" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "DISPLAY_OUTPUT_FLAG_EXCEPTION" )
call append( s:currentLineNum, s:currentIndent . "{" )
call append( s:currentLineNum, s:currentIndent . "catch ( ... )" )
call append( s:currentLineNum, s:currentIndent . "} // End CATCH the library exception while trying to <@TRY_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "exception->release();" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@EXCEPTION_LIBRARY_STATEMENT@>" )
call append( s:currentLineNum, "" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "exception->display( data_OutputFlags::getErrOutput() );" )
call append( s:currentLineNum, s:currentIndent . "{" )
call append( s:currentLineNum, s:currentIndent . "catch ( excp_Definition*   exception )" )
call append( s:currentLineNum, s:currentIndent . "} // End TRY to <@TRY_EXPLAIN@>" )
call append( s:currentLineNum, s:currentIndent . g:VM_projectIndentation . "<@TRY_STATEMENT@>" )
call append( s:currentLineNum, s:currentIndent . "{" )

"---< Fin de fichier >----------------------------------------------------------

