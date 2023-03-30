" Fichier : wks.vim
"
" But : Open the workspace file definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 26 oct. 2016
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

if ( isdirectory( expand( expand( s:usedFolder ) ) ) != 0 )
   execute "cd " . substitute( expand( s:usedFolder ), "\\\\", "/", "g" )

   let s:quitCommandUsed = [ "tabonly", "only", "edit " . substitute( expand( "%:p" ), "\\\\", "/", "g" ) ]
   let s:usedFilename = substitute( s:usedFilename, "\.*/", "", "" ) . ".workspace"

   if ( filereadable( expand( expand( s:usedFilename ) ) ) != 0 )
      execute "L " . substitute( expand( expand( s:usedFilename ) ), "\\\\", "/", "g" )

      let g:VM_workspaceQuitCmd = s:quitCommandUsed
   elseif ( ( exists( g:VM_workspaceFilename ) != 0 ) && ( filereadable( expand( g:VM_workspaceFilename ) ) != 0 ) )
      L

      let g:VM_workspaceQuitCmd = s:quitCommandUsed
   elseif ( filereadable( expand( "todo.txt" ) ) != 0 )
      edit todo.txt

      let g:VM_workspaceQuitCmd = s:quitCommandUsed
   else
      echo "No workspace file can be found to be opened.\n"
   endif
else
   echo "No folder " . substitute( expand( s:usedFolder ), "\\\\", "/", "g" ) . " can be found.\n"
endif

"---< Fin de fichier >----------------------------------------------------------

