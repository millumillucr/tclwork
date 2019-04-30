#include <stdio.h>
const int MAX=20, INFINITY=999;

void find(int x, int y, int path[MAX][MAX])
{
	printf("%d=>",x);
		if(y!=path[x][y])
			find(path[x][y],y,path);
}

int main()
{
	int i,j,k,x,y;
	int d[MAX][MAX],path[MAX][MAX],n;
	printf("Enter the num of nodes (1-20):\n");
	scanf("%d",&n);
	
	printf("Enter the distance matrix (999 if no link): \n");
	for(i=0;i<n;i++)
	{
		for(j=0;j<n;j++)
		{
			scanf("%d",&d[i][j]);
				if(d[i][j]==INFINITY)
					path[i][j]=-1;
				else
					path[i][j]=j;
		}
	}
	for(k=0;k<n;k++)
	{
		for(i=0;i<n;i++)
		{
			for(j=0;j<n;j++)
			{
				if(d[i][j]>d[i][k]+d[k][j])
				{
					path[i][j]=k;
					d[i][j]=d[i][k]+d[k][j];
				}
			}
		}
	}
	for(i=0;i<n;i++)
	{
		printf("\nRouting table for node %d\n",i);
		printf("Dest Next Hop Distance \n");
		for(j=0;j<n;j++)
		{
			printf("%d\t%d\t%d\n",j,path[i][j],d[i][j]);
		}
	}
	while(1)
	{
		printf("Enter 0 to exit\n");
		scanf("%d",&x);
		if(!x)
			break;
		printf("Enter 2 nodes");
		scanf("%d%d",&x,&y);
		find(x,y,path);
		printf("%d",y);
		printf("The distance b/w 2 nodes is %d",d[x][y]);
	}
}

