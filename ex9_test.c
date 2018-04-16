#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

typedef struct node
{
    char data;
    struct node *left,*right;
}btree;

btree *stack[20];
int top=-1;

int main()
{
    char expr[20];
    printf("Enter input expression\n");
    scanf("%s",expr);
    //DECLARATION
    btree *create(char expr[80]);
    void dag(btree *);
    //CREATING DAG
    btree *root;
    root=create(expr);
    //DISPLAY DAG
    dag(root);

}

btree *create(char exp[80])
{
      int pos=0;
      char ch=exp[pos];
      void push(btree *);
      btree *pop();
      btree *temp;
      while(ch!='\0')
      {
          temp=(btree *)malloc(sizeof(btree));
          temp->left=temp->right=NULL;
          temp->data=ch;

          if(isalpha(ch))
          {
                  push(temp);

          }
          else if(ch=='+' || ch=='-' || ch=='*' ||ch=='/' )
          {
                  temp->right=pop();
                  temp->left=pop();
                  push(temp);
          }
          else
            printf("INVALID Expression!!\n");
          pos++;
          ch=exp[pos];
      }
      temp=pop();
      return temp;
}

void push(btree *temp)
{
  if(top+1 >=20)
    printf("Error:Stack is full\n");
  else
  stack[++top]=temp;
}

btree* pop()
{
  btree *node=stack[top--];
  return node;
}

void dag(btree *root)
{
      btree *temp;
      temp=root;

      if(temp!=NULL)
      {
        dag(temp->left);
        printf("%c",temp->data);
        dag(temp->right);
      }
}
