%option noyywrap
%{
    #include "y.tab.h"
%}

ID      [A-Za-z][A-Za-z0-9]*

%%
{ID}    {return VAR;}
\n      return 0;
[\t ]   ;
.       return yytext[0];
%%
