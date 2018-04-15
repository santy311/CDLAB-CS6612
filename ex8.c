#include <stdio.h>
#include <stdlib.h>

struct node
{
  int data;
  struct node *next;
};

int main()
{
  int ch;
  struct node *head,*h,*temp;

  head= (struct node *)malloc(sizeof(struct node));
  head->next=NULL;

  while(1)
  {
    printf("1.push 2.pop 3.display\n");
    scanf("%d",&ch);

    switch (ch) {
      case 1: temp=(struct node*)malloc(sizeof(struct node));
              scanf("%d",&temp->data );
              h=head;
              temp->next=h->next;
              h->next=temp;
              break;
      case 2: h=head->next;
              head->next=h->next;
              free(h);
              break;
      case 3: h=head;
              printf("HEAD-->");
              while(h->next!=NULL)
              {
                h=h->next;
                printf("%d-->",h->data);
              }
              printf("NULL\n");
    }
  }
  return 0;
}
