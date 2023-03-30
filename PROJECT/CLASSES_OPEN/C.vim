" Fichier : C.vim
"
" But : The way the C classes are opened.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 08 oct. 2016
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*C_TestAllExtention" ) == 0 )

" Fonction : C_TestAllExtention
"
" But : Test all the extentions of the C classe.
"
" Parametres :
"    completeFilename - The complete filename to test
" Retour :
"    0 if the extention is not found another value otherwise
"-------------------------------------------------------------------------------
function C_TestAllExtention( completeFilename )
   let retValue = 0

   for ext in s:extentionList
      if ( g:VM_currentClassOpen.folder . "/" . g:VM_currentClassOpen.file . ext == a:completeFilename )
         let retValue = 1

         break
      endif
   endfor

   return retValue
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

let s:extentionList = [ ".c", ".mac", ".h", ".typ", ".str", "cflt" ]

if ( ( exists( "g:C_testExistingFile" ) != 0 )&&( g:C_testExistingFile != 0 ) )
   " Try to find the class in the already opened files
   "--------------------------------------------------
   let s:tabsDescription = VM_GetTabs()
   for entry in s:tabsDescription[ 0 ]
      if ( C_TestAllExtention( entry.completeFilename ) != 0 )
         let g:VM_fileSelected = 1

         let currentWindow = 1
         let currentTab = entry.tabList[ 0 ]

         for tabEntry in s:tabsDescription[ currentTab ]
            if ( C_TestAllExtention( tabEntry.completeFilename ) != 0 )
               break
            endif

            let currentWindow += 1
         endfor

         call VM_GotoTabFile( currentTab, currentWindow )
      endif
   endfor
endif

if ( g:VM_fileSelected == 0 )
   let s:textCommand = "edit"
   let s:numCommand = 0
   tabnew

   for ext in s:extentionList
      let s:currentFilename = g:VM_currentClassOpen.folder . "/" . g:VM_currentClassOpen.file . ext

      if ( filereadable( s:currentFilename ) != 0 )
         execute s:textCommand . " " . s:currentFilename

         let s:numCommand += 1

         if ( s:numCommand <= 2 )
            let s:textCommand = "vsplit"
         elseif ( s:numCommand == 3 )
            let s:textCommand = "split"
         elseif ( s:numCommand == 5 )
            wincmd h
            let s:textCommand = "split"
         endif
      endif
   endfor

   wincmd =
endif

let g:VM_fileSelected = 1

"---< Fin de fichier >----------------------------------------------------------

