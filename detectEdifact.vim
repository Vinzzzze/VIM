if did_filetype()
   finish
endif
if substitute( getline(1), "", "", "" ) != getline(1)
   set filetype = edifactAM
endif
