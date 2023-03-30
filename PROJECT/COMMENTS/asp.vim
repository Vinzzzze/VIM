oo' Function : :let numLine = line( "." )
:let functionLine = getline( numLine ) . currentFunctionName
:call setline( numLine, functionLine )
o':let numLine = line( "." )
:let numLine = PrintLimitedLengthLine( "' Purpose : ", "'           ", numLine, currentLibelleName, 72 )
:execute numLine
o'
' Parameters :
'
' Retour :
'
'-------------------------------------------------------------------------------
:let numLine = line( "." )
:let functionLine = "function " . currentFunctionName . "()"
:call setline( numLine, functionLine )
oend function
