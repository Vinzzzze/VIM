" Fichier : msg_enum.vim
"
" But : The mapping for the messages values definitions
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 28 août 2017
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

nmap <buffer> <F5>  :call VM_MoveNextMessageDefinitionLanguage( expand( "%:h:h:h" ) )<CR>
vmap <buffer> <F3>   :call VM_SearchVariableMessageLanguage( expand( "%:h:h:h" ), "*" )<CR>
vmap <buffer> <F2>   :call VM_SearchProjectMessageLanguage( expand( "%:h:h:h" ), "*" )<CR>
nmap <buffer> <F3>   :call VM_SearchVariableMessageLanguage( expand( "%:h:h:h" ), "*" )<CR>
nmap <buffer> <F2>   :call VM_SearchProjectMessageLanguage( expand( "%:h:h:h" ), "*" )<CR>

"---< Fin de fichier >----------------------------------------------------------

