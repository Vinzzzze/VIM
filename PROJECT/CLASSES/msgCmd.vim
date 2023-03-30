" Fichier : msgCmd.vim
"
" But : Define all the files for creating a command message definition.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 30 mars 2016
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

let s:commandName = input( "Command name : " )
echo "\n"
let s:comment = input( "Command comment : " )
echo "\n"
let g:VM_additionnalValues[ "UPPER_COMMAND_NAME" ] = VM_ConvertToUpper( substitute( s:commandName, "[A-Z]", "\_&", "g" ) )
let g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] = toupper( strpart( s:commandName, 0, 1 ) ) . strpart( s:commandName, 1 )

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère les trois répertoires à utiliser
"------------------------------------------
let s:repositoryData = VM_SelectFolder( "data", s:projectFolder )
let s:repositoryFactory = VM_SelectFolder( "fact", s:projectFolder )
let s:repositoryPool = VM_SelectFolder( "pool", s:projectFolder )

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "tabnew"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le corps de la classe de message
   "-------------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, s:commandName, "cmdCommandClass_cpp", s:comment, "data_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.cpp", s:repositoryData, s:projectFolder )

   " Construit le corps de la classe de factory
   "-------------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:commandName, "cmdCommandFact_cpp", s:comment, "fact_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.cpp", s:repositoryFactory, s:projectFolder )

   " Construit le corps de la classe de pool
   "----------------------------------------
   call VM_ProjectBuildFile( "vsplit", s:commandName, "cmdCommandPool_cpp", s:comment, "pool_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.cpp", s:repositoryPool, s:projectFolder )

   1 wincmd w

   " Construit le header de la classe de message
   "--------------------------------------------
   call VM_ProjectBuildFile( "split", s:commandName, "cmdCommandClass_hpp", s:comment, "data_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.hpp", s:repositoryData, s:projectFolder )

   3 wincmd w

   " Construit le header de la classe de factory
   "--------------------------------------------
   call VM_ProjectBuildFile( "split", s:commandName, "cmdCommandFact_hpp", s:comment, "fact_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.hpp", s:repositoryFactory, s:projectFolder )

   5 wincmd w

   " Construit le header de la classe de pool
   "-----------------------------------------
   call VM_ProjectBuildFile( "split", s:commandName, "cmdCommandPool_hpp", s:comment, "pool_" . g:VM_additionnalValues[ "COMMAND_CLASS_NAME" ] . "CommandMessageServer.hpp", s:repositoryPool, s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

