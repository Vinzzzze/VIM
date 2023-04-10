" Fichier : projectFuction.vim
"
" But : The functions needed for the class display.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 20 janv. 2015
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_BuildProjectName" ) == 0 )

" Fonction : VM_BuildProjectName
"
" But : Build the project name from the VM environment
"
" Parametres :
"    tagFile - The tag file name
" Retour :
"    The project name
"-------------------------------------------------------------------------------
function VM_BuildProjectName( tagFile )
   let retValue = "Project"
   let baseFolder = VM_BuildBaseFolder( a:tagFile )

   if ( baseFolder > "" )
      let retValue = "External"
   endif

   return retValue
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

nmap <buffer> <S-F8> :call VM_ShowTags( function( "VM_BuildBaseFolder" ), function( "VM_BuildProjectName" ) )<CR>

"---< Fin de fichier >----------------------------------------------------------

