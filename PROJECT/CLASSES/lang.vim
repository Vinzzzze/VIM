" Fichier : lang.vim
"
" But : The way the language files are created
"
" Auteur : VM - vincent.menager@bnpparibas.com
" Date : 22 Aug 2017
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

let s:projectDefine = 0

" Récupère le projet ( base du folder de création du fchier )
"------------------------------------------------------------
if ( exists( "g:projectFolder" ) == 0 )
   let g:projectFolder = VM_ChooseProject()
   let s:projectDefine = 1
endif
let s:listLanguageFiles = VM_ListLibraryLanguage( g:projectFolder )

if ( g:projectFolder == "" )
   unlet g:projectFolder

   finish
elseif ( len( s:listLanguageFiles ) > 0 )
   echo "Language definition already exists for this library.\n"

   call VM_ClassOpenDefinition( VM_BuildClassOpenLanguage( g:projectFolder, s:listLanguageFiles[ 0 ] ) )

   if ( s:projectDefine != 0 )
      unlet g:projectFolder
   endif

   finish
endif

" Recupère le nom de la librairie pour laquelle les messages sont créés
"----------------------------------------------------------------------
let s:libraryName = input( "Library name : " )

if ( s:libraryName == "" )
   finish
endif

if ( input( "Valide ( Y/N ) ? " ) == "Y" )
   if ( expand( "%" ) != "" )
      tabnew
   endif

   " Construit le fichier de header des messages de la librairie
   "------------------------------------------------------------
   call VM_ProjectBuildFile( "edit", "lang_" . s:libraryName, "lang_h", "The messages for each languages used in the " . s:libraryName . " libraries", "lang_" . s:libraryName . ".h", g:VM_languageRepository, g:projectFolder )

   write!

   " Construit le fichier d'enum des messages de la librairie
   "---------------------------------------------------------
   call VM_ProjectBuildFile( "edit", "lang_" . s:libraryName, "enum", "", "lang_" . s:libraryName . ".enum", g:VM_languageRepository, g:projectFolder )

   split
   execute "resize " . g:VM_languageDefaultSize

   " Construit le fichier d'enum des langues de la librairie
   "--------------------------------------------------------
   call VM_ProjectBuildFile( "edit", "lang_" . s:libraryName, "lang_lang", "", "lang_" . s:libraryName . ".lang", g:VM_languageRepository, g:projectFolder )

   write!

   " Construit le langage par défault
   "---------------------------------
   call VM_CreateLanguage( g:projectFolder, g:VM_languageDefaultName )
   let s:currentFile = g:VM_languageNbOpen

   for s:currentLanguage in VM_GetLanguageList( g:projectFolder )
      call VM_CreateLanguage( g:projectFolder, s:currentLanguage )

      let s:currentFile -= 1

      if ( s:currentFile >= 0 )
         vsplit
         wincmd L

         call VM_OpenLanguage( g:projectFolder, s:currentLanguage )
      endif
   endfor

   1 wincmd w
   wincmd =
endif

if ( s:projectDefine != 0 )
   unlet g:projectFolder
endif

"---< Fin de fichier >----------------------------------------------------------

