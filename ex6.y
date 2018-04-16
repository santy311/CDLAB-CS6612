%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	struct symtab
	{
		char *name;
		char *type;
		union
		{
			char cval;
			int ival;
			double dval;
		}value;
		struct symtab *next;
	};
	#define YYSTYPE char *
	extern FILE *yyin;
	char *toktype;
		extern char *yylval;
	struct symtab *hashtab;
	struct symtab* initialize_symtab();
	void addsymb(char *,char *, char *);
	extern int lineno;
%}
%token TYPE ID NUM CH
%left '+' '-'
%left '*' '/'
%%
stmt1		:	stmt stmt1
				|	stmt
				;
stmt		:	TYPE idlist ';'
				|	asgnexpr
				;
idlist	:	idlist ',' iden
				|	iden
				;
iden		:	ID '=' NUM		{
					if(search($1)!=1)
						addsymb($1,toktype,$3);
					else
						printf("\nLine no:%d Multiple Declaration of Symbol:%s!!!",lineno,$1);
					}
				|	ID			{
					if(search($1)!=1)
						addsymb($1,toktype,"-999");
					else
						printf("\nLine no:%d: Multiple Declaration of Symbol:%s!!!",lineno,$1);
					}
				|	ID '=' CH		{
					if(search($1)!=1)
						addsymb($1,toktype,$3);
					else
						printf("\nLine no:%d: Multiple Declaration of Symbol:%s!!!",lineno,$1);
					}
				;
asgnexpr:	ID '=' expr ';'		{
					if(search($1)!=1)
						printf("\nLine no%d:'%s' Symbol Undefined!!",lineno,$1);
					else if(strcmp($3,getType($1))!=0)
						printf("\nLine no%d: Type mismatch!!",lineno);
					}
;
expr	:	expr '+' expr		{
						if(strcmp($1,$3)==0)
							$$=strdup($1);
						else
							$$=strdup("Err");
					}
	|	expr '-' expr		{
						if(strcmp($1,$3)==0)
							$$=strdup($1);
						else
							$$=strdup("Err");

					}
	|	expr '*' expr		{
						if(strcmp($1,$3)==0)
							$$=strdup($1);
						else
							$$=strdup("Err");
					}
	|	expr '/' expr		{
						if(strcmp($1,$3)==0)
							$$=strdup($1);
						else
							$$=strdup("Err");
					}
	|	'('expr')'		{$$=strdup($2);}
	|	CH			{$$=strdup("char");}
	|	NUM			{if(strstr($1,".")!=NULL)$$=strdup("float"); else $$=strdup("int");}
	|	ID			{
						if(search($1)!=1)
							printf("\nLine no:%d: '%s' Symbol Undefined!!",lineno,$1);
						else
							$$=getType($1);
					}
;
%%
void main()
{
	struct symtab *temp;
	int i;
	char ch;
	hashtab=initialize_symtab();
	yyin=fopen("input.c","r");
	yyparse();
	printf("\nList symbol table[y/n]:");
	ch=getchar();
	if(ch=='y')
	{
		printf("\n\n\n----------------Symbol Table------------------");
		printf("\n Symbol Name \t Symbol Type \t Symbol Value");
		printf("\n-----------------------------------------------");
       		for(i=0;i<3;i++)
		{
			temp=(hashtab+i)->next;
			while(temp!=NULL)
			{
				printf("\n%s\t\t%s\t\t",temp->name,temp->type);
				if(strcmp(temp->type,"int")==0)
					printf("%d\n",temp->value.ival);
				else if (strcmp(temp->type,"float")==0)
					printf("%lf\n",temp->value.dval);
				else if (strcmp(temp->type,"char")==0)
					printf("%c\n",temp->value.cval);
				temp=temp->next;
			}
		}
	}
}
void addsymb(char *name,char *type,char *value)
{
	struct symtab *temp;
	temp=(struct symtab *) malloc(sizeof(struct symtab));
	temp->name=strdup(name);
	temp->type=strdup(type);
	if(strcmp(type,"int")==0)
	{
		temp->value.ival=atoi(value);
		temp->next=hashtab->next;
		hashtab->next=temp;
	}
	else if(strcmp(type,"float")==0||strcmp(type,"double")==0)
	{
		temp->value.dval=atof(value);
		temp->next=(hashtab+1)->next;
		(hashtab+1)->next=temp;
	}
	else if(strcmp(type,"char")==0)
	{
		if(strcmp(value,"-999")!=0)
			temp->value.cval=*(value+1);
		else
			temp->value.cval='$';
		temp->next=(hashtab+2)->next;
		(hashtab+2)->next=temp;
	}
}

int yyerror()
{
	printf("Error!!!\n");
	return 0;
}
struct symtab* initialize_symtab()
{
	struct symtab *node;
	node=(struct symtab *)malloc(100*sizeof(struct symtab));
	return node;
}
int search(char *name)
{
	struct symtab *t1;
	int i=0;
	t1=(struct symtab *) malloc(sizeof(struct symtab));
	for(i=0;i<3;i++)
	{
		t1=(hashtab+i)->next;
		while(t1!=NULL)
		{
			if(strcmp(t1->name,name)==0)
				return 1;
			t1=t1->next;
		}
	}
	return 0;
}
char* getType(char *name)
{
	struct symtab *temp;
	int i=0;
	temp=(struct symtab *)malloc(sizeof(struct symtab));
	for(i=0;i<3;i++)
	{
		temp=(hashtab+i)->next;
		while(temp!=NULL)
		{
			if(strcmp(temp->name,name)==0)
				return	(temp->type);
			temp=temp->next;
		}
	}
}
