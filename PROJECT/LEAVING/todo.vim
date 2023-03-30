" Fichier : todo.vim
"
" But : Définition des settings des fichiers de syntaxe todo
"
" Auteur : Vini "Cool Coyote"
" Date : 10 Sep 2013
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*TD_CreateTask" ) != 0 )
   delfunction TD_CreateTask
endif
if ( exists( "*TD_StartTaskDev" ) != 0 )
   delfunction TD_StartTaskDev
endif
if ( exists( "*TD_EndTaskDev" ) != 0 )
   delfunction TD_EndTaskDev
endif
if ( exists( "*TD_DeleteTask" ) != 0 )
   delfunction TD_DeleteTask
endif
if ( exists( "*TD_AddTaskParagraph" ) != 0 )
   delfunction TD_AddTaskParagraph
endif
if ( exists( "*TD_TodoFoldLevel" ) != 0 )
   delfunction TD_TodoFoldLevel
endif
if ( exists( "*TD_TodoFoldText" ) != 0 )
   delfunction TD_TodoFoldText
endif

"---< Fin de fichier >----------------------------------------------------------

