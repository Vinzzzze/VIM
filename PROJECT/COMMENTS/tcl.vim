oo# Fonction : :let numLine = line( "." )
:let functionLine = getline( numLine ) . currentFunctionName
:call setline( numLine, functionLine )
o#:let numLine = line( "." )
:let numLine = PrintLimitedLengthLine( "# But : ", "#       ", numLine, currentLibelleName, 72 )
:execute numLine
o#
# Paramètres :
#
# Retour :
#
#-------------------------------------------------------------------------------
:let numLine = line( "." )
:let functionLine = "proc " . currentFunctionName . "{}\\"
:call setline( numLine, functionLine )
o{
}
