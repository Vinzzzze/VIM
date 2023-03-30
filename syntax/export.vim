" Fichier : export.vim
"
" But : The export definition  for the enum on the export definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 23 nov. 2017
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

syn match exportClass   contained "desc_[a-zA-Z_]\+"
syn match exportIdentifier   "DESC_[A-Z]\+"
syn region  exportComment		 start="/\*"  end="\*/" contains=exportClass
syn keyword lastExport LAST_ALLOBJECTS_EXPORT_IDENTIFIER

hi link exportClass String
hi link exportIdentifier Number
hi link exportComment Comment
hi link lastExport Comment

"---< Fin de fichier >----------------------------------------------------------

