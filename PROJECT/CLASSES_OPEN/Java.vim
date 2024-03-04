" Fichier : Java.vim
"
" But : The way the Java classes are opened.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 16 Mar 2015
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

" Try to find the class in the already opened files
"--------------------------------------------------
let s:tabsDescription = VM_GetTabs()
for entry in s:tabsDescription[ 0 ]
   if ( g:VM_filenameClassOpen == entry.completeFilename )
      let g:VM_fileSelected = 1

      let currentWindow = 1
      let currentTab = entry.tabList[ 0 ]

      for tabEntry in s:tabsDescription[ currentTab ]
         if ( g:VM_filenameClassOpen == tabEntry.completeFilename )
            break
         endif

         let currentWindow += 1
      endfor

      call VM_GotoTabFile( currentTab, currentWindow )
   endif
endfor

"---< Fin de fichier >----------------------------------------------------------

