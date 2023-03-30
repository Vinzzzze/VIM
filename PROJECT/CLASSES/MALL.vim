" Fichier : MALL.vim
"
" But : Define all the procs for a specified table.
"
" Auteur : VM "Cool Coyote" - coolcoyote@noos.fr
" Date : 01 juin 2015
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

let g:VM_additionnalValues[ "TABLE_NAME" ] = input( "Table name : " )
echo "\n"

if ( g:VM_additionnalValues[ "TABLE_NAME" ] == "" )
   finish
endif

let s:baseTrigrame = input( "Base trigrame : " )
echo "\n"

if ( s:baseTrigrame == "" )
   finish
endif

" Recupère le nom de la classe à créer
"-------------------------------------
let s:procedureName = input( "Base procedure name : " )
echo "\n"

if ( s:procedureName == "" )
   finish
endif

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

if ( s:projectFolder == "" )
   finish
endif

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
for s:currentProject in VM_GetFolders( s:projectFolder )
   echo " " . s:currentProject . "\n"
endfor
let s:schema = input( "\nSchema : " )
echo "\n"

if ( s:svhema == "" )
   finish
endif

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Procedure comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let g:VM_additionnalValues[ "ELEMENT_UPD_NAME" ] = "P_" . s:baseTrigrame . "_Upd" . s:procedureName
   let s:commandUsed = "vsplit"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le fichier d'insertion des données
   "---------------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, "P_" . s:baseTrigrame . "_Add" . s:procedureName, "MADD", s:comment, "P_" . s:baseTrigrame . "_Add" . s:procedureName . ".MPRC", s:schema, s:projectFolder )

   " Construit le fichier de mise à jour des données
   "------------------------------------------------
   call VM_ProjectBuildFile( "vsplit", "P_" . s:baseTrigrame . "_Upd" . s:procedureName, "MUPD", s:comment, "P_" . s:baseTrigrame . "_Upd" . s:procedureName . ".MPRC", s:schema, s:projectFolder )

   " Construit le fichier de lecture des données
   "--------------------------------------------
   call VM_ProjectBuildFile( "vsplit", "P_" . s:baseTrigrame . "_Lst" . s:procedureName, "MLST", s:comment, "P_" . s:baseTrigrame . "_Lst" . s:procedureName . ".MPRC", s:schema, s:projectFolder )

   " Construit le fichier de lecture d'une donnée
   "---------------------------------------------
   call VM_ProjectBuildFile( "split", "P_" . s:baseTrigrame . "_Get" . s:procedureName, "MGET", s:comment, "P_" . s:baseTrigrame . "_Get" . s:procedureName . ".MPRC", s:schema, s:projectFolder )
endif

"---< Fin de fichier >----------------------------------------------------------

