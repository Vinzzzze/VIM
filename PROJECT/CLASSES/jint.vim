if ( exists( "g:VM_projectJavaBaseSource" ) != 0 )
   " Recup�re le nom de la classe � cr�er
   "-------------------------------------
   let s:className = input( "Interface : " )
   echo "\n"

   " R�cup�re le r�pertoire o� devra �tre cr�� ce nouveau fichier
   "-------------------------------------------------------------
   let s:repository = input( "Repository : " )
   echo "\n"

   " R�cup�re le commentaire du fichier
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

