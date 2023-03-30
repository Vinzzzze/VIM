" Fichier : c.vim
"
" But : How the c files had to be opened from the todo file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 18 oct. 2013
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

let s:usedFilename = substitute( strpart( substitute( expand( "<cWORD>" ), "^[^#]*", "", "" ) , 1 ), "\#.*", "", "" )
let s:bodyFile = s:usedFilename . ".c"
let s:headerFile = s:usedFilename . ".h"
let s:structFile = s:usedFilename . ".str"
let s:accessFile = s:usedFilename . ".mac"
let s:typeFile = s:usedFilename . ".typ"

let s:openTab = 0
let s:openCommand = "edit "

" Open the body file
"-------------------
if ( filereadable( expand( s:bodyFile ) ) != 0 )
   " Open the tab if it is not already opened
   "-----------------------------------------
   if ( s:openTab == 0 )
      let s:openTab = 1

      tabnew
   endif

   " Execute the command to open the file
   "-------------------------------------
   execute s:openCommand . " " . s:bodyFile

   call CCompleteOpen()
else
   " Open the header file
   "---------------------
   if ( filereadable( expand( s:headerFile ) ) != 0 )
      " Open the tab if it is not already opened
      "-----------------------------------------
      if ( s:openTab == 0 )
         let s:openTab = 1

         tabnew
      endif

      " Execute the command to open the file
      "-------------------------------------
      execute s:openCommand . " " . s:headerFile

      let s:openCommand = "vsplit"
   endif

   " Open the structure file
   "------------------------
   if ( filereadable( expand( s:structFile ) ) != 0 )
      " Open the tab if it is not already opened
      "-----------------------------------------
      if ( s:openTab == 0 )
         let s:openTab = 1

         tabnew
      endif

      " Execute the command to open the file
      "-------------------------------------
      execute s:openCommand . " " . s:structFile

      let s:openCommand = "vsplit"
   endif

   " Open the accessor file
   "-----------------------
   if ( filereadable( expand( s:accessFile ) ) != 0 )
      " Open the tab if it is not already opened
      "-----------------------------------------
      if ( s:openTab == 0 )
         let s:openTab = 1

         tabnew
      endif

      " Execute the command to open the file
      "-------------------------------------
      execute s:openCommand . " " . s:accessFile

      let s:openCommand = "split"
   endif

   " Open the type file
   "--------------------
   if ( filereadable( expand( s:typeFile ) ) != 0 )
      " Open the tab if it is not already opened
      "-----------------------------------------
      if ( s:openTab == 0 )
         let s:openTab = 1

         tabnew
      endif

      " Execute the command to open the file
      "-------------------------------------
      execute s:openCommand . " " . s:typeFile
   endif
endif

"---< Fin de fichier >----------------------------------------------------------

