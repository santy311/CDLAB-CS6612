%{
      #include <stdio.h>
      #include <string.h>
      struct Quad
      {
          char op[5],arg1[10],arg2[10],res[10];
      }quad[100];

      struct stack
      {
          int item[100];
          int top;
      }stk;
      int Index=0,Index1=0
      extern int ln;
%}

%union    { char var[10];}
%token    <var> NUM VAR RELOP
%token    MAIN IF ELSE TYPE
%type     <var> EXPR ASSIGNMENT CONDITION IFST ELSEST
%left '+' '-'
%left '*' '/'

%%
PROGRAM   : MAIN BLOCK
          ;
BLOCK     : '{'CODE'}'
          ;
CODE      :BLOCK
          |STATEMENT CODE
          |STATEMENT
STATEMENT :DESCT ';'
          |ASSIGNMENT ';'
          | CONDST
          ;
DESCT     : TYPE VARLIST
          ;
VARLIST   : VAR ',' VARLIST
          | VAR
          ;
ASSIGNMENT: VAR '=' EXPR  {
                            strcpy(quad[index].op,"=");
                            strcpy(quad[index].arg1,$3);
                            strcpy(quad[index].arg2,"");
                            strcpy(quad[index].res,$1);
                            strcpy($$,quad[index++].result);
                          };
EXPR      : EXPR '+' EXPR {addQuad("+",$1,$2,$$);}
          | EXPR '-' EXPR {addQuad("-",$1,$2,$$);}
          | EXPR '*' EXPR {addQuad("*",$1,$2,$$);}
          | EXPR '/' EXPR {addQuad("/",$1,$2,$$);}
          | NUM
          | VAR
          ;
CONDST    :IFST         {
                            Ind=pop();
                            sprintf(QUAD[Ind].result,"%d",Index);
                            Ind=pop();
                            sprintf(QUAD[Ind].result,"%d",Index);
                        }
          |IFST ELSEST
          ;
IFST      :IF '('CONDITION')'   {
                                    strcpy(QUAD[Index].op,"==");
                                    strcpy(QUAD[Index].arg1,$3);
                                    strcpy(QUAD[Index].arg2,"FALSE");
                                    strcpy(QUAD[Index].result,"-1");
                                    push(Index);
                                    Index++;
                                }
          ;
ELSEST    :   ELSE              {
                                    tInd=pop();
                                    Ind=pop();
                                    push(tInd);
                                    sprintf(QUAD[Ind].result,"%d",Index);
                                }
          BLOCK                 {
          Ind=pop();
          sprintf(QUAD[Ind].result,"%d",Index);
          };
          CONDITION: VAR RELOP VAR {AddQuadruple($2,$1,$3,$$);
          StNo=Index-1;
          }
          | VAR
          | NUM
          ;
