" Fichier : setting_mak.vim
"
" But : Setting pour les fichiers de makefile.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Ajout de la fonction de choix de l'environnement SQL d'ex�cution. Modification
"    du mapping en cons�quence.
"    Ajout de la fonction d'�limination d'un evironnement particulier. Modification
"    du mapping en cons�quence
"--------------------------
" Modify : VM - 29 Oct 2001
"    Ajout du mapping des touches pour �viter l'utilisation des accents.
"--------------------------
" Modify : VM - 23 May 2002
"    Ajout du server WEB, �limination du comptage des lignes lors de l'ex�cution de la commande isql
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

" Red�finition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4
" Les fichiers unix sont plus jolis
"----------------------------------
setlocal fileformat=unix

"---< Fin de fichier >----------------------------------------------------------

