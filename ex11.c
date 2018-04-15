#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

struct op
{
  char l,r[10];
}op[10];

int main()
{
  struct op temp;
  int n,i,j,k,res;
  char p[10];
  printf("enter number of sub expressions\n");
  scanf("%d",&n);

  for(i=0;i<n;i++)
  {
    printf("left side: ");
    scanf(" %c",&op[i].l);
    printf("right side: ");
    scanf("%s",op[i].r);
  }

  printf("INTERMEDIATE CODE\n");
  for(i=0;i<n;i++)
  {
    printf("%c = %s\n",op[i].l,op[i].r);
  }

  //common subexpression elimination-just elimination
  for(i=0;i<n-1;i++)
  {
    for(j=i+1;j<n;j++)
    {
      if(!strcmp(op[i].r,op[j].r))
      {
          temp=op[n-1];
          op[n-1]=op[j];
          op[j]=temp;
          n--;
      }
    }
  }

  //constant rolling
  for(i=0;i<n;i++)
  {
    if(isdigit(op[i].r[0])&&isdigit(op[i].r[2]))
    {
          j=op[i].r[0]-'0';
          k=op[i].r[2]-'0';
          if(op[i].r[1]=='+')
            res=j+k;
          if(op[i].r[1]=='-')
            res=j-k;
          if(op[i].r[1]=='/')
            res=j/k;
          if(op[i].r[1]=='*')
            res=j*k;

          sprintf( op[i].r, "%d", res );


    }
  }
  printf("OPTIMIZED CODE\n");
  for(i=0;i<n;i++)
  {
    printf("%c = %s\n",op[i].l,op[i].r);
  }
}
