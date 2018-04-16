#include <stdio.h>
#include <string.h>

struct expr
{
    char op[10],arg1,arg2,res;
}s[100];

int i=0,n;
void parse(char str[])
{
    s[i].arg1=str[2];
    s[i].arg2=str[4];
    s[i].res=str[0];
    switch (str[3]) {
      case '+':strcpy(s[i].op,"ADD");break;
      case '-':strcpy(s[i].op,"SUB");break;
      case '*':strcpy(s[i].op,"MUL");break;
      case '/':strcpy(s[i].op,"DIV");break;
    }
}
int main()
{
  char str[100][100];

  printf("Enter the expressions [type exit top stop]");
  do {
        scanf("%s",str[i]);
        parse(str[i]);
        i++;
  } while((strcmp(str[i-1],"exit"))!=0);
  n=i;
  printf("8086 CODE\n");
  for(i=0;i<n-1;i++)
  {
      printf("MOV R%d,%c\n",i,s[i].arg1);
      printf("%s R%d,%c\n",s[i].op,i,s[i].arg2);
      printf("MOV R%d,%c\n",i,s[i].res);
  }
  return 0;
}
