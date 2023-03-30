" Fichier : setting_prj.vim
"
" But : Définitions des touches pour les écrans de projet.
"
" Auteur : Vini "Cool Coyote"
" Date : 06/09/2001
"--------------------------
" Modify : VM - 25 Oct 2001
"    Ajout du mapping pour la gestion des taches de réalisation.
"--------------------------
" Modify : VM - 26 Oct 2001
"    Tri sur les mapping pour avoir une utilisation des touches plus conviviale
"--------------------------
" Modify : VM - 01 Dec 2001
"    Ajoute quelques spécificitées sur la touche entrée
"--------------------------
" Modify : VM - 08 Jan 2002
"    Par défaut la touche entrée ouvre les fichier suivant la méthode prédéfinie
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

" Pour éviter les problèmes lors du passage sous Linux
"-----------------------------------------------------
setlocal fileformat=unix
" Pour le déplacement dans les répertoires
"-----------------------------------------
nmap <buffer> <F2> 0j/\(+-+-\\|>>>\)<CR>
nmap <buffer> <S-F2> $k?\(+-+-\\|>>>\)<CR>
nmap <buffer> <C-F2> /^\(+-+-\\|   >>>--- \)<CR>
nmap <buffer> <C-S-F2> $k?^\(+-+-\\|   >>>--- \)<CR>
nmap <buffer> <M-F2> 1G/^+-+-[<>] /<CR>
" Pour le déplacement dans les fichiers
"--------------------------------------
nmap <buffer> <F3> 0j/\(+-+\\|+([0-9]\+)\) <CR>
nmap <buffer> <S-F3> $k?\(+-+\\|+([0-9]\+)\) <CR>
nmap <buffer> <C-F3> 0j/\(+-+ .* (\*)$\\| +< REALISATION > \)<CR>
nmap <buffer> <S-C-F3> $k?\(+-+ .* (\*)$\\| +< REALISATION > \)<CR>
nmap <buffer> <M-F3> 0j/\(+-+ .* ( )$\\| +< REALISATION > .*- \)<CR>
nmap <buffer> <S-M-F3> $k?\(+-+ .* ( )$\\| +< REALISATION > .*- \)<CR>
" Pour les ouvertures et fermetures des répertoires de projet
"------------------------------------------------------------
execute "nmap <buffer> <F4> :let gotoFile = 0<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-F4> :let gotoFile = 0<CR>:source " . g:VIM_CODE . "/closeOpenedElement.vim<CR>"
" Ouverture d'un fichier
"-----------------------
execute "nmap <buffer> <CR> :let gotoFile = 1<CR>:let cmdOpen = \"\"<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <C-CR> :let gotoFile = 1<CR>:let cmdOpen = \"split\"<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-CR> :let gotoFile = 1<CR>:let cmdOpen = \"vsplit\"<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-C-CR> :let gotoFile = 1<CR>:let cmdOpen = \"edit\"<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
" Gestion de l'écriture des textes
"---------------------------------
nmap <buffer> <F10> G?^    -------------------$?<CR>O<ESC>:execute "imap <buffer> \<ESC\> \<ESC\>:execute \"iunmap <buffer>  \\\<ESC\\\>\"\<CR\>\<S-F10\>"<CR>A
nmap <buffer> <S-F10> :call UpdateToDo( "Valide les modifications de la listes des taches" )<CR><CR>
" Gestion des taches : ouvertures, fermeture, changement d'état
"--------------------------------------------------------------
execute "nmap <buffer> <C-F4> :let actionTask = 1<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR><CR>"
execute "nmap <buffer> <S-C-F4> :let actionTask = 9<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR><CR>"
" Gestion des taches : Création modification
"-------------------------------------------
execute "nmap <buffer> <F9> :let actionTask = 2<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
execute "nmap <buffer> <S-F9> :let actionTask = 4<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR><CR>"
execute "nmap <buffer> <C-F9> :let actionTask = 5<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
execute "nmap <buffer> <S-C-F9> :let actionTask = 6<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
execute "nmap <buffer> <M-F9> :let actionTask = 3<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
execute "nmap <buffer> <S-M-F9> :let actionTask = 8<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
execute "nmap <buffer> <C-F10> :let actionTask = 7<CR>:source " . g:VIM_CODE . "/tasksManage.vim<CR>"
" Gestion des projet : sauvegarde des commentaires, calcul des dépendances
" fabrication des fichiers de projets
"-------------------------------------------------------------------------
execute "imap <buffer> <F6> <ESC>:write<CR>:let gotoFile = 3<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><F4>"
execute "nmap <buffer> <F6> :let gotoFile = 2<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-F6> :source " . g:VIM_CODE . "/buildMake.vim<CR><CR>"
" Ajout d'un élément, sauvegarde des commentaires des élément du projet courant
"------------------------------------------------------------------------------
execute "nmap <buffer> <F5> :source " . g:VIM_CODE . "/buildNewElement.vim<CR>"
execute "nmap <buffer> <C-F5> :let saveRestore = 1<CR>:source " . g:VIM_CODE . "/buildUpload.vim<CR><CR>"
execute "nmap <buffer> <M-F5> :let saveRestore = 0<CR>:source " . g:VIM_CODE . "/buildUpload.vim<CR><CR>"
" Livraison du répertoire/projet/fichier
"---------------------------------------
execute "nmap <buffer> <S-F5> :let gotoFile = 11<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR>"
" Gestion des fichiers sous-CVS
"------------------------------
execute "nmap <buffer> <F8> :let gotoFile = 5<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-F8> :let gotoFile = 6<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR>"
execute "nmap <buffer> <M-F8> :let gotoFile = 7<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR>"
execute "nmap <buffer> <C-F8> :let gotoFile = 8<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
" Gestion des fichiers de projet sous CVS
"----------------------------------------
execute "nmap <buffer> <F7> :let gotoFile = 9<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <S-F7> :let gotoFile = 10<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR><CR>"
execute "nmap <buffer> <C-F7> :let gotoFile = 4<CR>:source " . g:VIM_CODE . "/openDirectory.vim<CR>"
" Force le nombre de lignes de la fenêtre
"----------------------------------------
if ( &lines < 90 )
   setlocal lines=50
   setlocal lines=90
endif

"---< Fin de fichier >----------------------------------------------------------

