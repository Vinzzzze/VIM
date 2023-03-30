if ( exists( "g:VM_projectJavaBaseSource" ) != 0 )
   " Recupère le nom de la classe à créer
   "-------------------------------------
   let s:className = input( "Interface : " )
   echo "\n"

   " Récupère le répertoire où devra être créé ce nouveau fichier
   "-------------------------------------------------------------
   let s:repository = input( "Repository : " )
   echo "\n"

   " Récupère le commentaire du fichier
   "-----------------------------------
   let s:comment = input( "Class comment : " )
   echo "\n"

   " Valide la saisie
   "-----------------
   if ( input( "Valide ( Y/N ) ? " ) == "Y" )
      let s:commandUsed = "vsplit"

      if ( expand( "%" ) == "" )
         let s:commandUsed = "edit"
      endif

      " Construit le fichier de corps de class
      "---------------------------------------
      call VM_ProjectBuildFile( s:commandUsed, s:className, "interface", s:comment, s:className . ".java", s:repository, g:VM_projectJavaBaseSource )
   endif
else
   echo "The variable g:VM_projectJavaBaseSource had to be defined.\n"
   call input( "Press enter to continue..." )
endif

