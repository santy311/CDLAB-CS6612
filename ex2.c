#include <stdio.h>
#include <string.h>

int main()
{
  char line[250],*type,*id;
  FILE *fp=fopen("test.c","r");

  while(fgets(line,sizeof(line),fp))
  {
    type=strtok(line," ");
    if(strstr(type,"#include"))
    {
      type=strtok(NULL," ");
      printf("%s--->Preprocessor\n\n",type);
    }
    if(!strcmp(type,"int") || !strcmp(type,"float") || !strcmp(type,"double") || !strcmp(type,"char"))
    {
      while((id=strtok(NULL," ,;\n"))!=NULL)
      {
        if(strstr(id,"()"))
        {
          printf("%s\nFUNCTION\nType: %s\n\n",id,type);
        }
        else
        {
          printf("%s\nIDENTIFIER\nType: %s\n\n",id,type);
        }
      }
    }
    type=NULL;id=NULL;
  }
  return 0;
}
