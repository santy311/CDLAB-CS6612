%{
      #include <stdio.h>
      #include <stdlib.h>
%}

%token VAR

%%

stmt  : expr
      ;
expr  : VAR
      ;
%%
int main()
{
      printf("Enter to check variable\n");
      yyparse();
      printf("VAlid variable");
}

int yyerror()
{
      printf("Invalid variable");
      exit(0);
}
