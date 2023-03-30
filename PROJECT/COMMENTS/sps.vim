oo	/*
|| :let numLine = line( "." )
:if ( currentTypeReturned == "" )
:let startLine = "Procédure"
:else
:let startLine = "Fonction"
:endif
:let functionLine = getline( numLine ) . startLine . " : " . currentFunctionName
:call setline( numLine, functionLine )
o||:let numLine = line( "." )
:let numLine = PrintLimitedLengthLine( "	|| But : ", "	||       ", numLine, currentLibelleName, 71 )
:execute numLine
o||
|| Paramètres :
||
|| Retour :
||
||---< Maintenance >------------------------------------------------------------
*/
FUNCTION :let numLine = line( "." )
:let fonctionLine = getline( numLine ) . currentFunctionName
:call setline( numLine, fonctionLine )
:if ( currentTypeReturned == "" )
:execute ( numLine - 4 ) . "," . ( numLine - 3 ) . " delete"
:let numLine = numLine - 2
:execute numLine . " substitute /FUNCTION/PROCEDURE/"
:endif
:execute numLine
o	(
)
RETURN ;:if ( currentTypeReturned == "" )
:-1 substitute /)/);/
:+1 delete
:endif
