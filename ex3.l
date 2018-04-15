%option noyywrap
%{
#include<stdio.h>
#include<string.h>
char pre[50][50],keyw[50][50],fun[50][50],iden[50][50],oper[50][50];
int pr=0,k=0,fu=0,ide=0,ope=0;
%}
prepo "#include <"[a-zA-Z]*".h>"
key "int"|"float"|"char"|"double"|"while()"|"for"|"if"|"else"|"void"
func [a-zA-Z]+"(".*")"
id [a-zA-Z][a-zA-Z0-9]*
op "+"|"-"|"/"|"*"|"="|"%"

%%
{prepo} {strcpy(pre[pr],yytext);pr++;}
{key} {strcpy(keyw[k],yytext);k++;}
{func} {strcpy(fun[fu],yytext);fu++;}
{id} {strcpy(iden[ide],yytext);ide++;}
{op} {strcpy(oper[ope],yytext);ope++;}
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
{}    ;
%%
void main()
{
int i=0;
yyin=fopen("test.c","r");
yylex();
printf("------------------------------------------------------\n");
printf("\nPrepocessor\n");
for(i=0;i<=pr;i++)
printf("%s\n",pre[i]);
printf("------------------------------------------------------\n");
printf("\nKeywords\n");
for(i=0;i<=k;i++)
printf("%s\n",keyw[i]);
printf("------------------------------------------------------\n");
printf("\nFunction\n");
for(i=0;i<=fu;i++)
printf("%s\n",fun[i]);
printf("------------------------------------------------------\n");
printf("\nIdentifier\n");

for(i=0;i<=ide;i++)
printf("%s\n",iden[i]);
printf("------------------------------------------------------\n");
printf("\nOperator\n");
for(i=0;i<=ope;i++)
printf("%s\n",oper[i]);
}
