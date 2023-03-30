if ( exists( "g:VM_projectJavaTestBaseSource" ) != 0 )
   " Recupère le nom de la classe à créer
   "-------------------------------------
   let s:className = input( "Test for class : " )
   echo "\n"

   " Récupère le répertoire où devra être créé ce nouveau fichier
   "-------------------------------------------------------------
   let s:repository = input( "Repository : " )
   echo "\n"

   " Récupère la definition specifique du test à créer
   "--------------------------------------------------
   let s:junitExtention = input( "Specification du test : " )
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
      call VM_ProjectBuildFile( s:commandUsed, s:className, "junit" . s:junitExtention, "Test for the " . s:className . " definition.", s:className . "Test.java", s:repository, g:VM_projectJavaTestBaseSource )
   endif
else
   echo "The variable g:VM_projectJavaTestBaseSource had to be defined.\n"
   call input( "Press enter to continue..." )
endif

