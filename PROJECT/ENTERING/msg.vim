" Fichier : setting_msg.vim
"
" But : Définition des settings du fichier d'envoie des messages.
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
" But : Demande le groupe à qui le message doit être envoyé.
"
" Buffer : 
"    Fichier de définition des messages
" Parametres :
"    msgToSend - Message à envoyer
"    groupToSend - Groupe a qui envoyer le message
"-------------------------------------------------------------------------------
function SendMessage( msgToSend, groupToSend )
   " Récupère le nom du groupe a qui envoyer le message
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
      " Saisi du nom du groupe à utiliser
      "----------------------------------
      let groupUsed = input( "Groupe de réception : " )
      echo "\n"
   endif
   " Vérifie que le nom du groupe n'est pas vide
   "--------------------------------------------
   if ( groupUsed != "" )
      " Je vérifie l'existance du groupe
      "---------------------------------
      if ( exists( "g:" . groupUsed . "_0" ) != 0 )
         " Récupère le nombre de machines du groupe
         "-----------------------------------------
         execute "let nbMachine = g:" . groupUsed . "_0"
         let numMachine = 1
         while ( numMachine <= nbMachine )
            " Construction de la commande à executer
            "---------------------------------------
            execute "let commandExec = g:systemNetCmd . g:" . groupUsed . "_" . numMachine . " . \" \" . a:msgToSend"
            echo system( commandExec )
            " Passe à la machine suivante
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

" Récupère la liste des groupes et des machines
"----------------------------------------------
" execute "source " . g:VIM_CODE . "/buildMessage.vim"
" Définition des mappings de touches
"-----------------------------------
nmap <buffer> <CR> :write<CR>:call SendMessage( getline( "." ), "" )<CR>

"---< Fin de fichier >----------------------------------------------------------

