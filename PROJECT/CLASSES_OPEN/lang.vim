" Fichier : lang.vim
"
" But : The way the language definition files are opened
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 24 août 2017
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

let s:tabsDescription = VM_GetTabs()
let s:completeFile = g:VM_currentClassOpen.folder . "/" . g:VM_currentClassOpen.file . "." . g:VM_currentClassOpen.ext

for entry in s:tabsDescription[ 0 ]
   if ( entry.completeFilename == s:completeFile )
      let g:VM_fileSelected = 1

      let currentWindow = 1
      let currentTab = entry.tabList[ 0 ]

      for tabEntry in s:tabsDescription[ currentTab ]
         if ( tabEntry.completeFilename == s:completeFile )
            break
         endif

         let currentWindow += 1
      endfor

      call VM_GotoTabFile( currentTab, currentWindow )
   endif
endfor

if ( g:VM_fileSelected == 0 )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   execute "edit " . s:completeFile

   split
   execute "resize " . g:VM_languageDefaultSize

   execute "edit " . g:VM_currentClassOpen.folder . "/" . g:VM_currentClassOpen.file . ".lang"

   let s:currentFile = g:VM_languageNbOpen
   let s:projectFolder = fnamemodify( g:VM_currentClassOpen.folder, ":h" )

   for s:currentLanguage in VM_GetLanguageList( s:projectFolder )
      let s:currentFile -= 1

      if ( s:currentFile >= 0 )
         vsplit
         wincmd L

         call VM_OpenLanguage( s:projectFolder, s:currentLanguage )
      endif
   endfor

   1 wincmd w
   wincmd =
endif

let g:VM_fileSelected = 1

"---< Fin de fichier >----------------------------------------------------------

