" Fichier : getCPPGit.vim
"
" But : Get an existing project from Git
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 12 oct. 2014
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

echo system( g:VM_projectShellExecute . " 'git clone ssh://" . g:VM_distantUserName . "@" . g:VM_distantMachineName . g:VM_distantFolderBase . g:VM_distantFolderMake . g:projectName . "_" . g:VM_distantFolderType . " " . g:VM_projectBuildFolder . g:projectName . "/MAKEFILEGENERATION'" )
echo system( g:VM_projectShellExecute . " 'git clone ssh://" . g:VM_distantUserName . "@" . g:VM_distantMachineName . g:VM_distantFolderBase . g:projectName . " " . g:VM_projectBaseProjects . "/" . g:projectName . "'" )

"---< Fin de fichier >----------------------------------------------------------

