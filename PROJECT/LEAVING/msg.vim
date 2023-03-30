" Fichier : unsetting_msg.vim
"
" But : Annulation des définitions du fichier d'envoie de messages.
"
" Auteur : Vini "Cool Coyote" - coolcoyote@club-internet.fr
" Date : 30/01/2002
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

" Annulation des fonctions
"-------------------------
delfunction SendMessage
" Annulation des variables de définition de groupe
"-------------------------------------------------
execute "let nbGroup = " . varNameTabGroup . "0"
let numGroup = 1
while ( numGroup <= nbGroup )
   " Recherche le nom du groupe courant
   "-----------------------------------
   execute "let currGroupName = " . varNameTabGroup . numGroup
   execute "let nbGroupName = " . currGroupName . "_0"
   let numGroupName = 1
   while ( numGroupName <= nbGroupName )
      " Destruction de la variable courante
      "------------------------------------
      execute "unlet " . currGroupName . "_" . numGroupName
      " Passe à la variable suivante
      "-----------------------------
      let numGroupName = numGroupName + 1
   endwhile
   " Annulation des variables du groupe courant
   "-------------------------------------------
   execute "unlet " . currGroupName . "_0"
   execute "unlet " . varNameTabGroup . numGroup
   " Annulation des variables de boucle
   "-----------------------------------
   unlet numGroupName
   unlet nbGroupName
   unlet currGroupName
   " Passe au groupe suivant
   "------------------------
   let numGroup = numGroup + 1
endwhile
" Annulation des variable du code d'annulation
"---------------------------------------------
execute "unlet " . varNameTabGroup . "0"
unlet numGroup
unlet nbGroup
" Annulation des variables globales
"----------------------------------
unlet varNameTabGroup
unlet systemNetCmd

"---< Fin de fichier >----------------------------------------------------------

