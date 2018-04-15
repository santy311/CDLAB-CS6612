%option noyywrap
%{
      #include <stdio.h>
      #include <string.h>

      char pr[10][50],id[10][50],kw[10][50],op[10][50],fn[10][50];
      int prcnt=0,idcnt=0,kwcnt=0,opcnt=0,fncnt=0;
%}

prepoc  "#include <"[A-Za-z]+".h>"
func    [A-Za-z]+"(".*")"
keyw    "int"|"float"|"char"|"void"|"if"|"else"|"while"
idt      [A-Za-z][A-Za-z0-9]*
oper    "+"|"-"|"*"|"/"|"="|"%"

%%

{prepoc}                  {strcpy(pr[prcnt++],yytext);}
{func}                    {strcpy(fn[fncnt++],yytext);}
{keyw}                    {strcpy(kw[kwcnt++],yytext);}
{idt}                     {strcpy(id[idcnt++],yytext);}
{oper}                    {strcpy(op[opcnt++],yytext);}
.                         ;
%%

int main()
{
      yyin=fopen("test.c","r");
      yylex();

      int i=0;
      printf("Preprocessors\n----------------------------\n");
      for(i=0;i<prcnt;i++)
        printf("%s\n",pr[i]);

      printf("\nFunctions\n----------------------------\n");
      for(i=0;i<fncnt;i++)
        printf("%s\n",fn[i]);

      printf("\nIDENTIFIER\n----------------------------\n");
      for(i=0;i<idcnt;i++)
        printf("%s\n",id[i]);

      printf("\nKeywords\n----------------------------\n");
      for(i=0;i<kwcnt;i++)
        printf("%s\n",kw[i]);

      printf("\nOperator\n----------------------------\n");
      for(i=0;i<opcnt;i++)
        printf("%s\n",op[i]);

        return 0;
}
