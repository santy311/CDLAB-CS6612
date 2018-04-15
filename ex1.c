#include <stdio.h>
#include <string.h>

int main()
{
  FILE *fp;
  fp=fopen("test.c","r");
  char line[256],*type,*id;

  printf("SYMBOL TABLE\n\nIDENTIFIER\tTYPE\n________________________________________\n");
  while(fgets(line,sizeof(line),fp))
  {
      type=strtok(line," ;\n");
      if(!strcmp(type,"int") || !strcmp(type,"char") || !strcmp(type,"float") || !strcmp(type,"double") )
      {
        while((id=strtok(NULL," ,\n;"))!=NULL)
        {
          if(!strstr(id,"()"))
          printf("%s\t\t%s\n",id,type);
        }
      }
      type=NULL;id=NULL;
  }
}
