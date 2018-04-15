%option noyywrap
%{
        #include "y.tab.h"
        #include <stdio.h>
%}


%%
[0-9]+        {return NUM;}
[A-Za-z]+     {return ID;}
\n             return 0;
[\t ]          ;
.              return yytext[0];
%%
