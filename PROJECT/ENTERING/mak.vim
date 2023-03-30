" Fichier : setting_mak.vim
"
" But : Setting pour les fichiers de makefile.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Ajout de la fonction de choix de l'environnement SQL d'exécution. Modification
"    du mapping en conséquence.
"    Ajout de la fonction d'élimination d'un evironnement particulier. Modification
"    du mapping en conséquence
"--------------------------
" Modify : VM - 29 Oct 2001
"    Ajout du mapping des touches pour éviter l'utilisation des accents.
"--------------------------
" Modify : VM - 23 May 2002
"    Ajout du server WEB, élimination du comptage des lignes lors de l'exécution de la commande isql
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

" Redéfinition des tabulations
"-----------------------------
setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4
" Les fichiers unix sont plus jolis
"----------------------------------
setlocal fileformat=unix

"---< Fin de fichier >----------------------------------------------------------

