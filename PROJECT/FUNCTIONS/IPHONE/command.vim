" Fichier : command.vim
"
" But : The commands for the iPhone
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 01 May 2023
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

" Pour la création de fichiers
"-----------------------------
command! Class call VM_ProjectBuildClass()
command! Funct call VM_ProjectBuildFunction()
command! Buff call VM_CommandBuffer()<CR>

"---< Fin de fichier >----------------------------------------------------------

