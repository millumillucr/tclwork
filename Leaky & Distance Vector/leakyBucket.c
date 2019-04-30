#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#define bucketSize 75

void bktInput(int a, int b)
{
	if(a>bucketSize)
		printf("\n\t\tBucket overflow");
	else
	{
		sleep(1);
		while(a>b){
			printf("\n\t\t %d Bytes outputted.",b);
			a-=b;
			sleep(1);
		}
		if(a>0)
			printf("\n\t\tLast %d bytes sent\t",a);
		printf("\n\t\t Bucket output successful");
	}
}

void main()
{
	int op, pktSize;
	time_t t;
	printf("Enter the output rate:");
	scanf("%d",&op);
	srand((unsigned)time(&t));
	for(int i=1;i<=5;i++)
	{
		sleep(1);
		pktSize=rand()%100;
		printf("\nPacket no %d\t packet size=%d",i,pktSize);
		bktInput(pktSize,op);
	}
}
