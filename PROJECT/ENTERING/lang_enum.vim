" Fichier : lang_enum.vim
"
" But : Handle the language enum values
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 27 août 2017
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

setlocal readonly

nmap <buffer> o   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> O   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> d   :call VM_DelMessageLanguage( expand( "%:h:h" ) )<CR>
nmap <buffer> D   :call VM_DelMessageLanguage( expand( "%:h:h" ) )<CR>
nmap <buffer> C   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> c   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> S   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> s   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> R   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> r   :call VM_RequestAndCallLanguage( "Replacement message name : ", "VM_UpdateMessageLanguage" )<CR>
nmap <buffer> a   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> A   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> i   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> I   :call VM_RequestAndCallLanguage( "Message name to add : ", "VM_AddMessageLanguage" )<CR>
nmap <buffer> u   :echo "Disabled undo.\n"<CR>
nmap <buffer> U   :echo "Disabled undo.\n"<CR>
vmap <buffer> <CR> :call VM_UseVariableMessageLanguage( expand( "%:h:h" ), expand( "%:t:r" ) )<CR>ea
vmap <buffer> /   :call VM_SearchVariableMessageLanguage( expand( "%:h:h" ), expand( "%:t:r" ) )<CR>
vmap <buffer> !   :call VM_SearchProjectMessageLanguage( expand( "%:h:h" ), expand( "%:t:r" ) )<CR>
nmap <buffer> /   :call VM_SearchVariableMessageLanguage( expand( "%:h:h" ), expand( "%:t:r" ) )<CR>
nmap <buffer> !   :call VM_SearchProjectMessageLanguage( expand( "%:h:h" ), expand( "%:t:r" ) )<CR>

"---< Fin de fichier >----------------------------------------------------------

