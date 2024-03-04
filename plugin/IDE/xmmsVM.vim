" Fichier : xmmsVM.vim
"
" But : The plugin used to handle the control to XMMS2 from VIM
"
" Auteur : Vince "Cool Coyote" - coolcoyote358@gmail.com
" Date : 17 Jan 2018
"
"-------------------------------------------------------------------------------

"---< Utilisation de modules communs >------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES VARIABLES GLOBALES
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DECLARATION DES FONCTIONS
"-------------------------------------------------------------------------------

if ( exists( "*VM_XmmsClientExecute" ) == 0 )

" Fonction : VM_XmmsClientExecute
"
" But : Select the client
"-------------------------------------------------------------------------------
function VM_XmmsClientExecute() dict
   let $XMMS_PATH = self.address

   if ( exists( "g:VM_xmmsPlaylists" ) != 0 )
      unlet g:VM_xmmsPlaylists
   endif

   if ( exists( "g:VM_xmmsActivePlaylist" ) != 0 )
      unlet g:VM_xmmsActivePlaylist
   endif

   return self.comment
endfunction

endif

if ( exists( "*VM_XmmsCreateClient" ) == 0 )

" Fonction : VM_XmmsCreateClient
"
" But : Create the client address
"
" Parametres :
"    name - The client name to create
"    address - address of the server to connect
"    comment - the comment associated to the server
" Retour :
"    The client created
"-------------------------------------------------------------------------------
function VM_XmmsCreateClient( name, address, comment )
   let retValue = {}

   let retValue[ "name" ] = a:name
   let retValue[ "address" ] = a:address
   let retValue[ "comment" ] = a:comment
   let retValue[ "select" ] = function( "VM_XmmsClientExecute" )

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsBuildDefaultClientList" ) == 0 )

" Fonction : VM_XmmsBuildDefaultClientList
"
" But : Create the default XMMS client list.
"
" Retour :
"    The default client list
"-------------------------------------------------------------------------------
function VM_XmmsBuildDefaultClientList()
   if ( exists( "g:VM_xmmsDefaultClientList" ) != 0 )
      let retValue = g:VM_xmmsDefaultClientList
   else
      let retValue = {}
      let retValue[ "local" ] = VM_XmmsCreateClient( "local", "", "Standard default" )
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsSelectClient" ) == 0 )

" Fonction : VM_XmmsSelectClient
"
" But : Select the specified client
"
" Parametres :
"    name - The client name to be used
"-------------------------------------------------------------------------------
function VM_XmmsSelectClient( name )
   if ( exists( "g:xmmsClientList." . a:name ) != 0 )
      call g:xmmsClientList[ a:name ].select()
   else " End IF the client is well known
      echo "There is not client [" . a:name . "] in the client list.\n"
   endif " End IF the client is not known
endfunction

endif

if ( exists( "*VM_XmmsExecute" ) == 0 )

" Fonction : VM_XmmsExecute
"
" But : Execute the specified command
"
" Parametres :
"     command - The xmms command to be run
" Retour :
"     The XMMS client result
"-------------------------------------------------------------------------------
function VM_XmmsExecute( command )
   return split( system( g:VM_xmmsClientExe . " " . a:command ), "\n" )
endfunction

endif

if ( exists( "*VM_XmmsBuildAttributeNamePlaylist" ) == 0 )

" Fonction : VM_XmmsBuildAttributeNamePlaylist
"
" But : Build the name of an attribute of the playlist
"
" Parametres :
"     name - name of the attribute of the playlist
" Retour :
"     The attribute name
"-------------------------------------------------------------------------------
function VM_XmmsBuildAttributeNamePlaylist( name )
   return g:VM_xmmsPlaylistAttributePrefixe . a:name
endfunction

endif

if ( exists( "*VM_XmmsBuildFunctionNamePlaylist" ) == 0 )

" Fonction : VM_XmmsBuildFunctionNamePlaylist
"
" But : Build the name of an attribute that hold a method of the playlist
"
" Parametres :
"     name - name of the searched method
" Retour :
"     The function attribute name
"-------------------------------------------------------------------------------
function VM_XmmsBuildFunctionNamePlaylist( name )
   return g:VM_xmmsPlaylistFunctionPrefixe . a:name
endfunction

endif

if ( exists( "*VM_XmmsPlaylistAttributes" ) == 0 )

" Fonction : VM_XmmsPlaylistAttributes
"
" But : Get the attributes of the current playlist
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistAttributes() dict
   let playlistName = self[ VM_XmmsBuildAttributeNamePlaylist( "name" ) ]

   for currentKey in keys( self )
      if ( strpart( currentKey, 0, len( g:VM_xmmsPlaylistAttributePrefixe ) ) == g:VM_xmmsPlaylistAttributePrefixe )
         unlet self[ currentKey ]
      endif " End IF attribute had to be deleted
   endfor " End FOR all the entries

   let playlistValues = VM_XmmsExecute( "playlist config " . playlistName )

   for currentAttributeValue in playlistValues
      let attributeName = substitute( currentAttributeValue, ":.*", "", "" )
      let attributeValue = substitute( currentAttributeValue, "^[^:]\\+: ", "", "" )

      let self[ VM_XmmsBuildAttributeNamePlaylist( attributeName ) ] = attributeValue
   endfor

   return self
endfunction

endif

if ( exists( "*VM_XmmsSwitchPlaylistUpdate" ) == 0 )

" Fonction : VM_XmmsSwitchPlaylistUpdate
"
" But : Update the current playlist global variable when switching to the
"       specified playlist
"-------------------------------------------------------------------------------
function VM_XmmsSwitchPlaylistUpdate() dict
   if ( exists( "g:VM_xmmsActivePlaylist" ) != 0 )
      let g:VM_xmmsActivePlaylist.current = 0
   endif " End IF there is an already existing playlist

   let self.current = 1
   let g:VM_xmmsActivePlaylist = self
endfunction

endif

if ( exists( "*VM_XmmsCreatePlaylistObject" ) == 0 )

" Fonction : VM_XmmsCreatePlaylistObject
"
" But : Create a playlist object from it's name
"
" Parametres :
"     name - the playlist's name
"     current - The char to know if the playlist is the current ( '*' ) or not ( ' ' )
" Retour :
"     The playlist object created
"-------------------------------------------------------------------------------
function VM_XmmsCreatePlaylistObject( name, current )
   let retValue = {}

   let retValue.current = 0
   let retValue[ VM_XmmsBuildAttributeNamePlaylist( "name" ) ] = a:name
   let retValue[ VM_XmmsBuildFunctionNamePlaylist( "delete" ) ] = function( "VM_XmmsPlaylistDelete" )
   let retValue[ VM_XmmsBuildFunctionNamePlaylist( "update" ) ] = function( "VM_XmmsPlaylistUpdate" )
   let retValue[ VM_XmmsBuildFunctionNamePlaylist( "updateValues" ) ] = function( "VM_XmmsPlaylistAttributes" )
   let retValue[ VM_XmmsBuildFunctionNamePlaylist( "updateSwitch" ) ] = function( "VM_XmmsSwitchPlaylistUpdate" )

   if ( a:current == "*" )
      call retValue[ VM_XmmsBuildFunctionNamePlaylist( "updateSwitch" ) ]()
   endif " End IF the playlist is the new current playlist

   return retValue[ VM_XmmsBuildFunctionNamePlaylist( "updateValues" ) ]()
endfunction

endif

if ( exists( "*VM_XmmsBuildPlaylist" ) == 0 )

" Fonction : VM_XmmsBuildPlaylist
"
" But : Build the playlist definition available in the current client.
"
" Retour :
"    The complete playlist definition
"-------------------------------------------------------------------------------
function VM_XmmsBuildPlaylist()
   let playlistNames = VM_XmmsExecute( "playlist list" )
   let retValue = {}

   for currentName in playlistNames
      let realName = strpart( currentName, 2 )

      let retValue[ realName ] = VM_XmmsCreatePlaylistObject( realName, strpart( currentName, 0, 1 ) )
   endfor

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsBuildPlaylistOwner" ) == 0 )

" Fonction : VM_XmmsBuildPlaylistOwner
"
" But : Build the playlist object owner
"
" Retour :
"    The playlist owner object
"-------------------------------------------------------------------------------
function VM_XmmsBuildPlaylistOwner()
   let g:VM_xmmsPlaylists = {}

   let g:VM_xmmsPlaylists.playlists = VM_XmmsBuildPlaylist()
   let g:VM_xmmsPlaylists.fctCreate = function( "VM_XmmsPlaylistCreation" )
   let g:VM_xmmsPlaylists.fctDelete = function( "VM_XmmsPlaylistOwnerDelete" )
   let g:VM_xmmsPlaylists.fctUpdate = function( "VM_XmmsPlaylistOwnerUpdate" )
   let g:VM_xmmsPlaylists.fctChoose = function( "VM_XmmsChoosePlaylist" )
   let g:VM_xmmsPlaylists.statusUpdate = function( "VM_XmmsPlaylistOwnerStatusUpdate" )
   let g:VM_xmmsPlaylists.fctSwitch = function( "VM_XmmsSiwtchPlaylist" )

   return g:VM_xmmsPlaylists.statusUpdate()
endfunction

endif

if ( exists( "*VM_XmmsChoosePlaylist" ) == 0 )

" Fonction : VM_XmmsChoosePlaylist
"
" But : Select a playlist in the list of the known playlists
"
" Retour :
"    The selected playlist name
"-------------------------------------------------------------------------------
function VM_XmmsChoosePlaylist() dict
   let playlistNames = keys( self.playlists )
   let numPlaylist = inputlist( [ "Playlist to get :" ] + map( copy( playlistNames ), '( v:key + 1 ) . " > " . v:val' ) )
   let retValue = ""

   if ( ( numPlaylist > 0 )&&( numPlaylist <= len( playlistNames ) ) )
      let retValue = playlistNames[ numPlaylist - 1 ]
   endif " End IF one playlist had been selected

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsPlaylistUpdateList" ) == 0 )

" Fonction : VM_XmmsPlaylistUpdateList
"
" But : Update the current playlist to the list type
"
" Retour :
"     The command to pass to XMMS2 to update the playlist
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistUpdateList() dict
   let following = g:VM_xmmsPlaylists.fctChoose()

   return "-j \"" . following . "\""
endfunction

endif

if ( exists( "*VM_XmmsPlaylistUpdateQueue" ) == 0 )

" Fonction : VM_XmmsPlaylistUpdateQueue
"
" But : Update the current playlist to the list type
"
" Retour :
"     The command to pass to XMMS2 to update the playlist
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistUpdateQueue() dict
   let following = g:VM_xmmsPlaylists.fctChoose()
   let historyConfig = input( "\nHistory size : " )

   if ( historyConfig > "" )
      let historyConfig = " -s " . historyConfig
   endif " End IF the history had to be set

   return "-j \"" . following . "\"" . historyConfig
endfunction

endif

if ( exists( "*VM_XmmsPlaylistUpdateShuffle" ) == 0 )

" Fonction : VM_XmmsPlaylistUpdateShuffle
"
" But : Update the current playlist to the list type
"
" Retour :
"     The command to pass to XMMS2 to update the playlist
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistUpdateShuffle() dict
   let historyConfig = input( "History size : " )
   let queueSize = input( "\nQueue size : " )
   let collectionName = input( "\nCollection name : " )

   if ( historyConfig > "" )
      let historyConfig = " -s " . historyConfig
   endif " End IF the history had to be set

   if ( queueSize > "" )
      let queueSize = " -u " . queueSize
   endif " End IF the queue had to be set

   return "-i \"" . collectionName . "\"" . historyConfig . queueSize
endfunction

endif

if ( exists( "*VM_XmmsPlaylistCreation" ) == 0 )

" Fonction : VM_XmmsPlaylistCreation
"
" But : Create a new playlist
"
" Parametres :
"     name - The playlist name to create
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistCreation( name ) dict
   if ( exists( "g:VM_xmmsPlaylists.playlists." . a:name ) == 0 )
      call VM_XmmsExecute( "playlist create " . a:name )

      let retValue = VM_XmmsCreatePlaylistObject( a:name )
      let g:VM_xmmsPlaylists.playlists[ a:name ] = retValue
   else
      let retValue = "The playlist " . a:name . " already exists."
   endif

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsPlaylistDelete" ) == 0 )

" Fonction : VM_XmmsPlaylistDelete
"
" But : Delete the playlist
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistDelete() dict
   if ( ( exists( "g:VM_xmmsActivePlaylist" ) != 0 )&&( g:VM_xmmsActivePlaylist == self ) )
      unlet g:VM_xmmsActivePlaylist
   endif " End IF we are deleting the active playlist

   call VM_XmmsExecute( "playlist remove " . self[ VM_XmmsBuildAttributeNamePlaylist( "name" ) ] )
endfunction

endif

if ( exists( "*VM_XmmsPlaylistUpdate" ) == 0 )

" Fonction : VM_XmmsPlaylistUpdate
"
" But : Update the playlist definition
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistUpdate() dict
   let typeChoice = inputlist( [ "Select the type list (empty to keep the current value)" ] + map( copy( g:VM_xmmsPlaylistType ), '( v:key + 1 ) . " > " . v:val' ) )

   if ( typeChoice == 0 )
      let newType = self[ VM_XmmsBuildAttributeNamePlaylist( "type" ) ]
   " End IF we won't change the playlist type
   elseif ( typeChoice <= len( g:VM_xmmsPlaylistType ) )
      let newType = g:VM_xmmsPlaylistType[ typeChoice - 1 ]
   else " End IF we are getting the playlist type from the user choice
      echo "Cancelling the update...\n"

      return
   endif " End IF we are cancelling the update

   execute "let playlistUpdate = self." . newType . "()"
   let validation = input( "\nValidate input (Y/N) : " )

   if ( validation == "Y" )
      call VM_XmmsExecute( "playlist config " . playlistUpdate . " " . self[ VM_XmmsBuildAttributeNamePlaylist( "name" ) ] )
      call self[ VM_XmmsBuildFunctionNamePlaylist( "updateValues" ) ]()
   endif " End IF the update can be done
endfunction

endif

if ( exists( "*VM_XmmsPlaylistOwnerDelete" ) == 0 )

" Fonction : VM_XmmsPlaylistOwnerDelete
"
" But : Delete the named playlist
"
" Parametres :
"     name - The playlist to delete
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistOwnerDelete( name ) dict
   if ( exists( "self.playlists[ a:name ]" ) != 0 )
      let toDelete = remove( self.playlists, a:name )

      call toDelete[ VM_XmmsBuildFunctionNamePlaylist( "delete" ) ]()

      if ( exists( "g:VM_xmmsActivePlaylist" ) == 0 )
         unlet self.playlists
         let self.playlists = VM_XmmsBuildPlaylist()

         call self.statusUpdate()
      endif " End IF the current playlist had been deleted
   else " End IF the playlist to delete exists
      let toDelete = "there is no play list " . a:name . " to be deleted." 
   endif " End IF there is no playlist deletable

   return toDelete
endfunction

endif

if ( exists( "*VM_XmmsPlaylistOwnerUpdate" ) == 0 )

" Fonction : VM_XmmsPlaylistOwnerUpdate
"
" But : Update the specified playlist from the playlist's owner
"
" Parametres :
"     name - The playlist to update
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistOwnerUpdate( name ) dict
   if ( exists( "self.playlists[ a:name ]" ) != 0 )
      let toUpdate = self[ a:name ]

      call toUpdate[ VM_XmmsBuildFunctionNamePlaylist( "update" ) ]()
   else " End IF the playlist to update exists
      let toUpdate = "there is no play list " . a:name . " to be updated." 
   endif " End IF there is no playlist updatable

   return toUpdate
endfunction

endif

if ( exists( "*VM_XmmsSiwtchPlaylist" ) == 0 )

" Fonction : VM_XmmsSiwtchPlaylist
"
" But : Switch to the specified playlist
"
" Parametres :
"     name - The playlist name to switch to
"-------------------------------------------------------------------------------
function VM_XmmsSiwtchPlaylist( name ) dict
   if ( exists( "self.playlists." . a:name ) != 0 )
      let toPlayList = self.playlists[ a:name ]

      if ( ( exists( "g:VM_xmmsActivePlaylist" ) != 0 )&&( g:VM_xmmsActivePlaylist == toPlaylist ) )
         let toPlaylist = "Amready on playlist " . a:name . ", won't do anything."
      else " End IF the playlist is already the current one
         call VM_XmmsExecute( "playlist switch " . a:name )
         call toPlaylist[ VM_XmmsBuildFunctionNamePlaylist( "updateSwitch" ) ]()

         call self.statusUpdate()
      endif " End IF we can move to the specified playlist
   else " End IF the playlist to delete exists
      let toPlaylist = "there is no play list " . a:name . " to switch to." 
   endif " End IF there is no playlist deletable

   return toPlaylist
endfunction

endif

if ( exists( "*VM_XmmsPlaylistOwnerStatusUpdate" ) == 0 )

" Fonction : VM_XmmsPlaylistOwnerStatusUpdate
"
" But : Update the current playing status
"
" Retour :
"     The status object
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistOwnerStatusUpdate() dict
   let retValue = {}
   let currentValue = VM_XmmsExecute( "current" )

   let attributes = split( currentValue, g:VM_xmmsClientSeparator )
   let defIndex = 0

   for currentAttribute in attributes
      if ( defLindex >= len( g:VM_xmmsCurrentAttributes ) )
         break;
      endif " End IF all the attributes links had been gotten

      let currentAttributeDef = g:VM_xmmsCurrentAttributes[ defLink ]
      let defLink += 1
      let attributeName = currentAttributeDef[ "main" ]

      if ( len( currentAttributeDef ) > 1 )
         if ( exists( "retValue[ attributeName ]" ) == 0 )
            let retValue[ attributeName ] = {}
         endif " End IF the subobject had to be created

         let baseObject = retValue[ attributeName ]
         let attributeName = currentAttributeDef[ attributeName ]
      else " End IF we are using a subobject
         let baseObject = retValue
      endif " End IF we are setting the returned object

      let baseObject[ attributeName ] = currentAttribute
   endfor " End FOR all the attributes read

   let self.currentStatus = retValue
endfunction

endif

if ( exists( "*VM_XmmsPlaylistGetTracks" ) == 0 )

" Fonction : VM_XmmsPlaylistGetTracks
"
" But : Get the tracks presents in the playlist.
"
" Retour :
"    The playlist content
"-------------------------------------------------------------------------------
function VM_XmmsPlaylistGetTracks()
   let retValue = []
   let trackList = VM_XmmsExecute( "list" )

   for currentTrack in trackList
      let track = { "current": 0 }

      if ( strpart( currentTrack, 0, len( g:VM_xmmsCurrentTrackMarker ) ) == g:VM_xmmsCurrentTrackMarker )
         let track.current = 1
      endif " End IF the track is the current one

      let trackAttributes = split( strpart( currentTrack, len( g:VM_xmmsCurrentTrackMarker ) ), g:VM_xmmsClientSeparator )
      let indexAttribute = 0

      for currentAttribute in trackAttributes
         if ( indexAttribute >= len( g:VM_xmmsTrackAttributes ) )
            break;
         endif " End IF we have no more attributes to store, the left ones are ignored

         let track[ g:VM_xmmsTrackAttributes[ indexAttribute ] ] = currentAttribute
         let indexAttribute += 1
      endfor " End FOR all the attributes of the current track

      let retValue[] = track
   endfor " End FOR all tracks of the playlist

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsPlay" ) == 0 )

" Fonction : VM_XmmsPlay
"
" But : Start the current track play
"-------------------------------------------------------------------------------
function VM_XmmsPlay()
   call VM_XmmsExecute( "play" )
endfunction

endif

if ( exists( "*VM_XmmsStop" ) == 0 )

" Fonction : VM_XmmsStop
"
" But : Stop the current track play
"-------------------------------------------------------------------------------
function VM_XmmsStop()
   call VM_XmmsExecute( "stop" )
endfunction

endif

if ( exists( "*VM_XmmsPause" ) == 0 )

" Fonction : VM_XmmsPause
"
" But : Pause the current track play
"-------------------------------------------------------------------------------
function VM_XmmsPause()
   call VM_XmmsExecute( "pause" )
endfunction

endif

if ( exists( "*VM_XmmsNext" ) == 0 )

" Fonction : VM_XmmsNext
"
" But : Move to the next track
"-------------------------------------------------------------------------------
function VM_XmmsNext()
   call VM_XmmsExecute( "next" )
endfunction

endif

if ( exists( "*VM_XmmsPrev" ) == 0 )

" Fonction : VM_XmmsPrev
"
" But : Move to the previous track
"-------------------------------------------------------------------------------
function VM_XmmsPrev()
   call VM_XmmsExecute( "prev" )
endfunction

endif

if ( exists( "*VM_XmmsJump" ) == 0 )

" Fonction : VM_XmmsJump
"
" But : Jump to the specified track number in the current playlist
"
" Parametres :
"     number - Track number in the playlist
"-------------------------------------------------------------------------------
function VM_XmmsJump( number )
   call VM_XmmsExecute( "jump " . a:number )
endfunction

endif

if ( exists( "*VM_XmmsVolume" ) == 0 )

" Fonction : VM_XmmsVolume
"
" But : Set or read the current volume
"
" Parametres :
"     volume - volume to set, "" to let the volume unchanged
" Retour :
"     The current volume value
"-------------------------------------------------------------------------------
function VM_XmmsVolume( volume )
   let volumeRead = VM_XmmsExecute( "server volume " . a:volume )

   if ( strpart( volumeRead[ 0 ], 0, len( g:VM_xmmsVolumeError ) ) == g:VM_xmmsVolumeError )
      let retValue = "N/A"
   " End IF the volume cannot be read
   elseif ( len( volumeRead ) == 2 )
      let retValue = substitute( volumeRead[ 0 ], ".* = ", "", "" )
   else " End IF we are reading an alsa volume
      let retValue = volumeRead[ 0 ]
   endif " End IF the volume can be read

   return retValue
endfunction

endif

if ( exists( "*VM_XmmsMoveTracks" ) == 0 )

" Fonction : VM_XmmsMoveTracks
"
" But : Move the specified group of items to the specified position
"
" Parametres :
"     trackList - The current tracklist definition
"     position - The position to move ( 0 : begining, -1 : After current )
"     firstTack - The first track number to move
"     lastTrack - The last track number to move
" Retour :
"     The updated track list
"-------------------------------------------------------------------------------
function VM_XmmsMoveTracks( trackList, position, firstTrack, lastTrack )
endfunction

endif

if ( exists( "*VM_XmmsRemoveTracks" ) == 0 )

" Fonction : VM_XmmsRemoveTracks
"
" But : Remove the tracks from the specified track list
"
" Buffer : 
"
" Parametres :
"     trackList - The current tracklist definition
"     firstTack - The first track number to move
"     lastTrack - The last track number to move
" Retour :
"     the deleted track list
"-------------------------------------------------------------------------------
function VM_XmmsRemoveTracks( trackList, firstTrack, lastTrack )
   if ( a:firstTrack < a:lastTrack )
      echo "Unable to delete tracks with a first position " . a:firstTrack . " beyond last position " . a:lastTrack . "\n"

      return trackList
   endif " End IF the deletion was impossible

   let sizeDeletion = a:lastTrack - a:firstTrack
   let executeOrder = "remove " . ( a:firstTrack + 1 )

   while ( sizeDeletion >= 0 )
      call VM_XmmsExecute( executeOrder )

      let sizeDeletion -= 1
   endwhile " End WHILE all the tracks had not been deleted

   return remove( trackList, firstTrack, lastTrack )
endfunction

endif

if ( exists( "*VM_XmmsAddTrackList" ) == 0 )

" Fonction : VM_XmmsAddTrackList
"
" But : Add the given tracks to the current track list
"
" Parametres :
"     position - The position to move ( 0 : begining, -1 : After current, "" at the end )
"     trackListAdd - The track list to add
" Retour :
"     The updated track list
"-------------------------------------------------------------------------------
function VM_XmmsAddTrackList( position, trackListAdd )
   let addedPosition = ""

   if ( a:position > "" )
      if ( a:position < 0 )
         let addedPosition = "-n "
      else " End IF we want to add after the current read track
         let addedPosition = "-a " . a:position . " "
      endif " End IF want to add at the specified position
   endif " End IF the position to use for adding the tracks

   let trackIndex = len( a:trackListAdd )

   while ( trackIndex > 0 )
      let trackIndex -= 1

      call VM_XmmsExecute( "add " . addedPosition . "id:" . a:trackListAdd[ trackIndex ].id )
   endwhile " End WHILE all the tracks had not been added

   return VM_XmmsPlaylistGetTracks()
endfunction

endif

if ( exists( "*VM_XmmsAddTrackSearched" ) == 0 )

" Fonction : VM_XmmsAddTrackSearched
"
" But : Add the searched tracks to the current track list
"
" Parametres :
"     searchCriteria - The search criteria definition
"     position - The position to move ( 0 : begining, -1 : After current, "" at the end )
" Retour :
"     The updated track list
"-------------------------------------------------------------------------------
function VM_XmmsAddTrackSearched( searchCriteria, position )
   let addedPosition = ""

   if ( a:position > "" )
      if ( a:position < 0 )
         let addedPosition = "-n "
      else " End IF we want to add after the current read track
         let addedPosition = "-a " . a:position . " "
      endif " End IF want to add at the specified position
   endif " End IF the position to use for adding the tracks

   call VM_XmmsExecute( "add " . addedPosition . a:searchCriteria )

   return VM_XmmsPlaylistGetTracks()
endfunction

endif

if ( exists( "*VM_XmmsSort" ) == 0 )

" Fonction : VM_XmmsSort
"
" But : Sort the current playlist
"
" Retour :
"     The sorted track list
"-------------------------------------------------------------------------------
function VM_XmmsSort()
   call VM_XmmsExecute( "playlist sort" )

   return VM_XmmsPlaylistGetTracks()
endfunction

endif

if ( exists( "*VM_XmmsShuffle" ) == 0 )

" Fonction : VM_XmmsShuffle
"
" But : Shuffle the current playlist
"
" Retour :
"     the shuffled playlist
"-------------------------------------------------------------------------------
function VM_XmmsShuffle()
   call VM_XmmsExecute( "playlist shuffle" )

   return VM_XmmsPlaylistGetTracks()
endfunction

endif

"-------------------------------------------------------------------------------
" DEBUT DU CODE
"-------------------------------------------------------------------------------

if ( exists( "g:VM_xmmsClientList" ) == 0 )
   let g:VM_xmmsClientList = VM_XmmsBuildDefaultClientList()
endif

if ( exists( "g:VM_xmmsPlaylistType" ) == 0 )
   let g:VM_xmmsPlaylistType = [ "list", "queue", "pshuffle" ]
endif

if ( exists( "g:VM_xmmsClientExe" ) == 0 )
   let g:VM_xmmsClientExe = "xmms2"
endif

if ( exists( "g:VM_xmmsClientSeparator" ) == 0 )
   let g:VM_xmmsClientSeparator = "@:@"
endif

if ( exists( "g:VM_xmmsPlaylistAttributePrefixe" ) == 0 )
   let g:VM_xmmsPlaylistAttributePrefixe = "attr.@."
endif

if ( exists( "g:VM_xmmsPlaylistFunctionPrefixe" ) == 0 )
   let g:VM_xmmsPlaylistFunctionPrefixe = "fct.@."
endif

if ( exists( "g:VM_xmmsCurrentAttributes" ) == 0 )
   let g:VM_xmmsCurrentAttributes = [ { "main": "status" }, { "main": "playing" }, { "main": "track", "track": "artist" }, { "main": "track", "track": "album" }, { "main": "track", "track": "title" }, { "main": "track", "track": "genre" }, { "main": "track", "track": "duration" } ]
endif

if ( exists( "g:VM_xmmsTrackAttributes" ) == 0 )
   let g:VM_xmmsTrackAttributes = [ "id", "artist", "album", "title", "genre", "number", "length" ]
endif

if ( exists( "g:VM_xmmsCurrentTrackMarker" ) == 0 )
   let g:VM_xmmsCurrentTrackMarker = "<>"
endif

"---< Fin de fichier >----------------------------------------------------------

