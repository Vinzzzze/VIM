" Fichier : xml.vim
"
" But : Entering in an XML file, additional command for my projects
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 04 nov. 2014
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_BuildProjectFileList" ) == 0 )

" Fonction : VM_BuildProjectFileList
"
" But : Call the functions used to build the file list used for the current
"       project.
"
" Buffer :
"    The current file modified since line number 2
" Parametres :
"     maskSearched - The mask for the searched files
"-------------------------------------------------------------------------------
function VM_BuildProjectFileList( maskSearched )
   let baseFolder = expand( "%:h" )
   let numLineAppend = 2

   if ( baseFolder == "." )
      let baseFolder = ""
   else
      let baseFolder .= g:VM_projectDirSeparator
   endif

   let listFolders = insert( VM_GetFolders( baseFolder ), "." )
   let indexFolder = 0

   while indexFolder < len( listFolders )
      " Get all the sub-folders
      "------------------------
      let currentFolder = listFolders[ indexFolder ]

      if ( currentFolder != "." )
         let folderList = VM_GetFolders( baseFolder . currentFolder )

         for localFolder in folderList
            call add( listFolders, currentFolder . g:VM_projectDirSeparator . localFolder )
         endfor
      endif

      " Get all the files of the current folder
      "----------------------------------------
      let searchedFile = baseFolder . currentFolder . g:VM_projectDirSeparator . a:maskSearched
      let commandListFiles = g:VM_projectListFileStart . searchedFile . g:VM_projectListFileEnd
      let listFiles = VM_ExtractFolders( commandListFiles )

      for currentFile in listFiles
         let extention = substitute( currentFile, "\.*\\.", "", "" )
         let fileName = substitute( currentFile, "\\." . extention . "$", "", "" )
         let fileName = substitute( fileName, "\.*" . g:VM_projectDirSeparator, "", "" )

         let fileDescription = "<FILE name=\"" . fileName . "\" ext=\"" . extention . "\" path=\"" . currentFolder

         if ( substitute( fileName, g:XML_projectMainPattern, "", "" ) != fileName )
            let fileDescription .= "\" main=\"yes"
         endif

         call append( numLineAppend, g:XML_projectIndentation . fileDescription . "\"/>" )

         let numLineAppend += 1
      endfor

      " Do not forget to update the folder index
      "-----------------------------------------
      let indexFolder += 1
   endwhile
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( expand( "%:t:r" ) == "fileList" )
   nmap <buffer> <F10> :call VM_BuildProjectFileList( g:VM_projectListFileMask )<CR>
endif

if ( exists( "g:XML_projectIndentation" ) == 0 )
   let g:XML_projectIndentation = "	"
endif

if ( exists( "g:XML_projectMainPattern" ) == 0 )
   let g:XML_projectMainPattern = "^main$"
endif

"---< Fin de fichier >----------------------------------------------------------

