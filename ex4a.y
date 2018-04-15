%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token NUM ID
%left '+' '-'
%left '*' '/'

%%

stmt  : S '='  expr
      | expr
      ;
expr  : S  '+'  S
      | S  '-'  S
      | S  '*'  S
      | S  '/'  S
S     : NUM
      | ID
      ;
%%

int main()
{
    printf("Enter Input Expression\n\n");
    yyparse();
    printf("Valid expreession\n\n");
    return 0;
}

int yyerror()
{
    printf("Invalid expression\n\n");
    exit(0);
}
