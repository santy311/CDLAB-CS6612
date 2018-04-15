%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token  NUM
%left '+' '-'
%left '*' '/'
%left '.'

%%

stmt  :   expr      {printf("THE ANSWER IS= %d\n",$1);}
      ;
expr  :  NUM  '+' NUM     {$$=$1+$3;}
      |  NUM  '-' NUM     {$$=$1-$3;}
      |  NUM  '*' NUM     {$$=$1*$3;}
      |  NUM  '/' NUM     {$$=$1/$3;}
      |   '('NUM')'       {$$=$2;}
      ;
%%
int main()
{
    yyparse();
    return 0;
}

int yyerror()
{
    printf("Invalid expression\n");
    exit(0);
}
