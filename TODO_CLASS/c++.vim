" Fichier : c++.vim
"
" But : How the c++ files had to be opened from the todo file.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 sept. 2013
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
let s:bodyFile = s:usedFilename . ".cpp"
let s:headerFile = s:usedFilename . ".hpp"

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

   let s:openCommand = "vsplit"
endif

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

"---< Fin de fichier >----------------------------------------------------------

