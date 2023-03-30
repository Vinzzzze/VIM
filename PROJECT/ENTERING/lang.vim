" Fichier : lang.vim
"
" But : The language file entering definition
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 24 août 2017
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

setlocal winfixheight
setlocal readonly

nmap <buffer> o   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> O   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> d   :call VM_DelDefinitionLanguage( expand( "%:h:h" ) )<CR>
nmap <buffer> D   :call VM_DelDefinitionLanguage( expand( "%:h:h" ) )<CR>
nmap <buffer> C   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> c   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> S   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> s   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> R   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> r   :call VM_RequestAndCallLanguage( "Replacement language name : ", "VM_RenameLanguage" )<CR>
nmap <buffer> a   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> A   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> i   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> I   :call VM_RequestAndCallLanguage( "Language name to add : ", "VM_AddDefinitionLanguage" )<CR>
nmap <buffer> u   :echo "Disabled undo.\n"<CR>
nmap <buffer> U   :echo "Disabled undo.\n"<CR>

"---< Fin de fichier >----------------------------------------------------------

