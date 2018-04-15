%option noyywrap

%{
      #include "y.tab.h"
      int ln=0;
%}

DIGIT     [0-9]+|[0-9]+(\.[0-9]+)*
ALPHA     [A-Za-z_][A-Za-z0-9_]*

%%
main\(\) printf("main block");
if       return IF;
else     return ELSE;
int |char|
float|double  return TYPE;
{ALPHA}   {strcpy(yylval.var,yytext);return VAR;}
{DIGIT}   {strcpy(yylval.var,yytext);return NUM;}
\< |
\> |
\>= |
\<= |
==  {strcpy(yylval.var,yytext);return RELOP;}
[ \t]     ;
\n        ln++;
.         return yytext[0];
%%
