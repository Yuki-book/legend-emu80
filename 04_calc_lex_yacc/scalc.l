%{
#include <stdlib.h>
%}
NUM    [0-9]+
%%
"+"    return (OPADD);
"-"    return (OPSUB);
"*"    return (OPMUL);
"/"    return (OPDIV);
"%"    return (OPMOD);
"("    return (OPLPA);
")"    return (OPRPA);
{NUM} { sscanf (yytext, "%d", &yylval);
        return (TKNUM); }
[ \t]   ;
\n     return (TKCR);
.      return (yytext[0]);
%%
