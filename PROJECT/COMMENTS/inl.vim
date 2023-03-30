:let currentComment = &comments
:set comments=
oo/*
|| Fonction : :let numLine = line( "." )
:let functionLine = getline( numLine ) . currentFunctionName
:call setline( numLine, functionLine )
o||:let numLine = line( "." )
:let numLine = PrintLimitedLengthLine( "|| But : ", "||       ", numLine, currentLibelleName, 71 )
:execute numLine
o||
|| Paramètres :
||
|| Retour :
||
*/
:let numLine = line( "." )
:let functionLine = "inline " . currentTypeReturned . " " . elementName . "::" . currentFunctionName . "()"
:call setline( numLine, functionLine )
o{
}:execute "set comments=" . currentComment
