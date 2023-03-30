" Fichier : setting_msg.vim
"
" But : D�finition des settings du fichier d'envoie des messages.
"
" Auteur : Vini "Cool Coyote"
" Date : 24/01/2001
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*SendMessage" ) == 0 )

" Fonction : SendMessage
"
" But : Demande le groupe � qui le message doit �tre envoy�.
"
" Buffer : 
"    Fichier de d�finition des messages
" Parametres :
"    msgToSend - Message � envoyer
"    groupToSend - Groupe a qui envoyer le message
"-------------------------------------------------------------------------------
function SendMessage( msgToSend, groupToSend )
   " R�cup�re le nom du groupe a qui envoyer le message
   "---------------------------------------------------
   let groupUsed = a:groupToSend
   if ( groupUsed == "" )
      " Affiche la liste des groupes
      "-----------------------------
      echo "Liste des groupes de messages :\n"
      echo "-------------------------------\n"
      execute "let nbGroup = g:" . g:varNameTabGroup . "0"
      let currentGroup = 1
      while ( currentGroup <= nbGroup )
         execute "echo g:" . g:varNameTabGroup . currentGroup
         let currentGroup = currentGroup + 1
      endwhile
      echo "-------------------------------\n"
      " Saisi du nom du groupe � utiliser
      "----------------------------------
      let groupUsed = input( "Groupe de r�ception : " )
      echo "\n"
   endif
   " V�rifie que le nom du groupe n'est pas vide
   "--------------------------------------------
   if ( groupUsed != "" )
      " Je v�rifie l'existance du groupe
      "---------------------------------
      if ( exists( "g:" . groupUsed . "_0" ) != 0 )
         " R�cup�re le nombre de machines du groupe
         "-----------------------------------------
         execute "let nbMachine = g:" . groupUsed . "_0"
         let numMachine = 1
         while ( numMachine <= nbMachine )
            " Construction de la commande � executer
            "---------------------------------------
            execute "let commandExec = g:systemNetCmd . g:" . groupUsed . "_" . numMachine . " . \" \" . a:msgToSend"
            echo system( commandExec )
            " Passe � la machine suivante
            "----------------------------
            let numMachine = numMachine + 1
         endwhile
      else
         " Le groupe n'existe pas
         "-----------------------
         echo "Le groupe [" . groupUsed . "] n'existe pas\n"
      endif
   endif
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

" R�cup�re la liste des groupes et des machines
"----------------------------------------------
" execute "source " . g:VIM_CODE . "/buildMessage.vim"
" D�finition des mappings de touches
"-----------------------------------
nmap <buffer> <CR> :write<CR>:call SendMessage( getline( "." ), "" )<CR>

"---< Fin de fichier >----------------------------------------------------------

