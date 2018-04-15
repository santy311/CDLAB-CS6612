%option noyywrap
%{
      #include "y.tab.h"
%}

%%
[0-9]+(\.[0-9]+)?    {yylval=atoi(yytext);return NUM;}
[\n]                   return 0;
[ \t]                 ;
.                     return yytext[0];
%%
