%option noyywrap
%{
    #include <stdio.h>
    #include <string.h>

    void addblock(char *);
    void append_code(char *);
    int bno=1,lnct=1,prev=0;
    char str[500]="",linelist[100]="",t[5];

    struct graph{
      char code[500];
    }blarr[500];
%}
space				[ \t]
rop					">"|"<"|"=="|"<="|">="|"<>"
aop 				"+"|"-"|"*"|"/"|"%"
asignop			"="
digit 			[0-9]
num					{digit}+
letter			[a-zA-Z]
iden 				{letter}({letter}|{digit})*
exp					({iden}|{num}){space}*({aop}{space}*({iden}|{num}))?
aexp				{iden}{space}*{asignop}{space}*{exp}
rexp				{iden}{space}*{rop}{space}*({iden}|{num})
%%
{aexp}													{	append_code(yytext);prev=0;}
"if "{rexp}(" goto L"{num}+":") { addblock(yytext);}
L{digit}+:.+   {
                          if(strcmp(str,"")!=0)
                          {
                                printf("Block number: %d\tLines: %s\n",bno,linelist);
                                strcpy(blarr[bno].code,str);
                          }
                          if(prev==0)
                            bno++;
                          strcpy(str,yytext);
                          sprintf(t,"%d,",lnct);
                          strcpy(linelist,t);
                }
"goto L"{digit}+  { addblock(yytext);}
\n            lnct++;
{space}*      ;
.             ;
%%


void main()
{

    int i,j,count;
    int matrix[100][100];
    char *substr,*s;
    yyin=fopen("test2.c","r");
    yylex();
    for(i=1;i<bno;i++)
  	{
  		if((substr=strstr(blarr[i].code,"goto"))==NULL)
  			matrix[i][i+1]=1;
  		else if(((substr=strstr(blarr[i].code,"goto"))!=NULL) && ((s=strstr(blarr[i].code,"if"))!=NULL))
  			matrix[i][i+1]=1;
  		if((substr=strstr(blarr[i].code,"goto"))!=NULL)
  		{
  			s=strdup(substr+5);
  			strcat(s,":");
  			for(j=1;j<bno;j++)
  				if(strstr(blarr[j].code,s)!=NULL)
  					matrix[i][j]=1;
  		}
  	}
  	printf("\nThe Control Flow Graph for the given code is:\n");
  	printf("Block");
  	for(i=1;i<bno;i++)
  		printf("\t%d",i);
  	for(i=1;i<bno;i++)
  	{
  		printf("\n%d",i);
  		for(j=1;j<bno;j++)
  			printf("\t%d",matrix[i][j]);
  	}
  	printf("\nThe Exit block(s):");
  	for(i=2;i<bno;i++)
  	{
  		count=0;
  		for(j=1;j<bno;j++)
  			count=count+matrix[i][j];
  		if(count==0)
  			printf("B%d",i);
  	}
  	printf("\n");
}

void addblock(char *s)
{
      append_code(s);
      printf("Block number: %d\tLines: %s\n",bno,linelist);
      strcpy(blarr[bno].code,str);
      strcpy(linelist,"");
      strcpy(str,"");
      bno++;
      prev=1;
}

void append_code(char *s)
{
      strcat(str,s);
      sprintf(t,"%d,",lnct);
      strcat(linelist,t);
}
