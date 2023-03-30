" Fichier : unsetting_xml.vim
"
" But : Unsetting pour les fichiers de langage XML
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 28 Oct 2001
"    Elimination de la fonction de choix de l'environnement d'exécution
"    Elimination de la fonction de l'élimination d'un environnement d'exécution
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

" Destruction des fonctions
"--------------------------
if ( exists( "*XmlFoldLevel" ) != 0 )
   delfunction XmlFoldLevel
endif
if ( exists( "*XmlFoldText" ) != 0 )
   delfunction XmlFoldText
endif
if ( exists( "*XmlCommentArea" ) != 0 )
   delfunction XmlCommentArea
endif
if ( exists( "*XmlUncommentArea" ) != 0 )
   delfunction XmlUncommentArea
endif

"---< Fin de fichier >----------------------------------------------------------

