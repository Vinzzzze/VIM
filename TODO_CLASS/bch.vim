" Fichier : bch.vim
"
" But : Open the project with the workspace of the current branch.
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 15 Aug 2017
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

let s:usedFilename = substitute( substitute( strpart( substitute( expand( "<cWORD>" ), "^[^#]*", "", "" ) , 1 ), "\#.*", "", "" ), "\\\\", "/", "g" )
let s:usedFolder = substitute( s:usedFilename, "\/[^/]*$", "", "" )

if ( isdirectory( expand( s:usedFolder ) ) != 0 )
   execute "cd " . substitute( expand( s:usedFolder ), "\\\\", "/", "g" )

   let s:quitCommandUsed = [ "tabonly", "only", "edit " . substitute( expand( "%:p" ), "\\\\", "/", "g" ) ]

   if ( filereadable( expand( "todo.txt" ) ) != 0 )
      edit todo.txt

      let g:VM_workspaceQuitCmd = s:quitCommandUsed
      L
   else
      echo "No workspace file can be found to be opened.\n"
   endif
else
   echo "No folder " . substitute( expand( s:usedFolder ), "\\\\", "/", "g" ) . " can be found.\n"
endif

"---< Fin de fichier >----------------------------------------------------------

