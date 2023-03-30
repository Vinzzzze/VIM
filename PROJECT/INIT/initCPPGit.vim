" Fichier : initCPPGit.vim
"
" But : Create the CPP project
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 09 sept. 2014
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_GetProjectBuildFolder" ) == 0 )

" Fonction : VM_GetProjectBuildFolder
"
" But : Get the project build folder.
"
" Retour :
"    The build folder for the projects
"-------------------------------------------------------------------------------
function VM_GetProjectBuildFolder()
   let retValue = g:VM_projectBuildFolder

   if ( exists( "g:VM_projectVIMBuildFolder" ) != 0 )
      let retValue = g:VM_projectVIMBuildFolder
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_ExportMakeProject" ) == 0 )

" Fonction : VM_ExportMakeProject
"
" But : Export the GIT project for the CPP type's project.
"
" Parametres :
"    projectName - The project name to be created
"-------------------------------------------------------------------------------
function VM_ExportMakeProject( projectName )
   echo system( g:VM_projectShellExecute . " 'git clone ssh://" . g:VM_distantUserName . "@" . g:VM_distantMachineName . g:VM_distantFolderBase . g:VM_distantFolderMake . a:projectName . "_" . g:VM_distantFolderType . " " . g:VM_projectBuildFolder . a:projectName . "/MAKEFILEGENERATION'" )

   let currentBuildFolder = VM_GetProjectBuildFolder()
   call VM_ProjectBuildFile( "vsplit", a:projectName, "project_init_cpp", "The project variable initialization", ".project_init", "MAKEFILEGENERATION", currentBuildFolder . a:projectName )
   write!
   quit
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

echo system( g:VM_projectShellExecute . " 'ssh " . g:VM_distantMachineName . " git init --bare " . g:VM_distantFolderBase . g:VM_distantFolderMake . g:projectName . "_WIN'" )
echo system( g:VM_projectShellExecute . " 'ssh " . g:VM_distantMachineName . " git init --bare " . g:VM_distantFolderBase . g:VM_distantFolderMake . g:projectName . "_MAC'" )
echo system( g:VM_projectShellExecute . " 'ssh " . g:VM_distantMachineName . " git init --bare " . g:VM_distantFolderBase . g:VM_distantFolderMake . g:projectName . "_UNIX'" )
echo system( g:VM_projectShellExecute . " 'ssh " . g:VM_distantMachineName . " git init --bare " . g:VM_distantFolderBase . g:VM_distantFolderMake . g:projectName . "_ARM'" )

call VM_ExportMakeProject( g:projectName )

let currentBaseProject = VM_GetProjectBaseFolder()

call VM_ProjectBuildFile( "vsplit", g:projectName, "project_def_cpp", "The project variable initialization", ".project_def", g:projectName, currentBaseProject )
write!
quit
call VM_ProjectBuildFile( "vsplit", g:projectName, "exportC.sh", "The project export script", "export.sh", g:projectName, currentBaseProject )
write!
quit

"---< Fin de fichier >----------------------------------------------------------

