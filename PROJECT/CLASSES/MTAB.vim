" Recupère le nom de la classe à créer
"-------------------------------------
let s:tableName = input( "Table : " )
echo "\n"

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
let s:projectFolder = VM_ChooseProject()

" Récupère le répertoire où devra être créé ce nouveau fichier
"-------------------------------------------------------------
for s:currentProject in VM_GetFolders( s:projectFolder )
   echo " " . s:currentProject . "\n"
endfor
let s:schema = input( "\nSchema : " )
echo "\n"

" Récupère le commentaire du fichier
"-----------------------------------
let s:comment = input( "Table comment : " )
echo "\n"

" Valide la saisie
"-----------------
if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   let s:commandUsed = "split"

   if ( expand( "%" ) == "" )
      let s:commandUsed = "edit"
   endif

   " Construit le fichier de corps de class
   "---------------------------------------
   call VM_ProjectBuildFile( s:commandUsed, s:tableName, "MTAB", s:comment, s:tableName . ".MTAB", s:schema, s:projectFolder )
endif

