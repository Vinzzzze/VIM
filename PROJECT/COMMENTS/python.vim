o

def :let numLine = line( "." )
:call setline( numLine, getline( numLine ) . currentFunctionName . "()" )
o    """

"""
return 
:let lineContents = getline( numLine + 1 )
:let lineContents = strpart( lineContents, 0, strlen( lineContents ) - 3 )
:let numLine = PrintLimitedLengthLine( lineContents, lineContents, numLine + 2, currentLibelleName, 71 )
:execute numLine
o
@param : 

@return :let numLine = line( "." ) + 2
:call setline( numLine, getline( numLine ) . currentTypeReturned )

