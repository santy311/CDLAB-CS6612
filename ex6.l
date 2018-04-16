%option noyywrap
%{
	#include "y.tab.h"

	extern char *toktype;
	char *t;
	int lineno=1;
%}
key 										"int"|"char"|"float"|"double"|"long"
letter									[_a-zA-Z]
digit 									[0-9]
%%
\'.\'																{yylval=strdup(yytext);return CH;}
{key} 															{toktype=strdup(yytext);yylval=strdup(yytext);return TYPE;}
{letter}({letter}|{digit})* 				{yylval=strdup(yytext);return ID;}
{digit}+(\.{digit}+)? 							{yylval=strdup(yytext);return NUM;}
[ \t]+ 															;
\n																	lineno++;
. 																	return *yytext;
%%
