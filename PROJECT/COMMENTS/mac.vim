:let currentComment = &comments
:set comments=
o
i/*
i|| Macro : :let numLine = line( "." )
:let functionLine = getline( numLine ) . currentFunctionName
:call setline( numLine, functionLine )
o||:let numLine = line( "." )
:let numLine = PrintLimitedLengthLine( "|| But : ", "||       ", numLine, currentLibelleName, 71 )
:execute numLine
o||
|| Paramètres :
||    struct : Structure utilisée
||    point : . pour les structure, -> pour les pointeurs sur les structures
||    prefixe : Préfixe utilisé dans la structure courante
||    returnType : Type de retour attendu
||------------------------------------------------------------------------------
*/
:let numLine = line( "." )
:let functionLine = "#define " . currentFunctionName . "( struct, point, prefixe, returnType ) \\"
:call setline( numLine, functionLine )
:execute "set comments=" . currentComment
