#include "mex.h"
#include <vector>
#include <queue>

#define pp pair<int,double>
#define INF 999999999

using namespace std;

class compare
{
public:
    int operator() (const pair<int, double>& p1, const pair<int, double>& p2)
    {
        return p1.second > p2.second;
    }
};

void costPath(double *node, double *preNode, size_t m, size_t n, int seedX, int seedY)
{
    int pixel = m*n;
    
    *(preNode + (seedY-1)*m + seedX - 1) = -1;
    *(preNode + pixel + (seedY-1)*m + seedX -1) = -1;
    
    int* visited = new int[(m+2)*(n+2)];
    double* cost = new double[(m+2)*(n+2)];
    for (int i=0; i<(m+2)*(n+2); i++)
    {
        visited[i] = 0 ;
        cost[i] = INF;
    }
    // mark boundary as visited
    for (int i=0; i<m+2; i++)
    {
        visited[i*(n+2)+n+1] = 1;
        visited[i*(n+2)] = 1;
    }
    for (int i=0; i<n+2; i++)
    {
        visited[i] = 1;
        visited[(m+1)*(n+2)+i] = 1;
    }
    priority_queue<pp, vector<pp>, compare> PQ;
    int key_matlab = (seedY-1) * m + seedX - 1;        // use for get/store Matlab data
    int key = seedX * (n+2) + seedY;                   // use in current map
    PQ.push(pp(key, 0));
    
    while(PQ.size())
    {
        pp get = PQ.top();
        PQ.pop();
        key = get.first;
        if (visited[key]==1)
        {
            continue;
        }
        
        double totalCost = get.second;
        int i = key / (n+2);
        int j = key % (n+2);
        visited[key]=1;
        // mark current node as visited
        
        key_matlab = (j-1) * m + i - 1;
        
        
        key = (i-1)*(n+2)+j+1;
        double tempCost = totalCost + *(node + key_matlab);
        if(visited[key] != 1 && cost[key] > tempCost)      // 1
        {
            cost[key] = tempCost;
            *(preNode + j*m + (i-2)) = i;
            *(preNode + pixel + j*m + (i-2)) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = (i-1)*(n+2)+j;
        tempCost = totalCost + *(node + key_matlab + pixel);
        if(visited[key] != 1 && cost[key] > tempCost)      // 2
        {
            cost[key] = tempCost;
            *(preNode + (j-1)*m + i-2) = i;
            *(preNode + pixel + (j-1)*m + i-2) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = (i-1)*(n+2)+j-1;
        tempCost = totalCost + *(node + key_matlab + pixel*2);
        if(visited[key] != 1 && cost[key] > tempCost)      // 3
        {
            cost[key] = tempCost;
            *(preNode + (j-2)*m + i-2) = i;
            *(preNode + pixel + (j-2)*m + i-2) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = i*(n+2)+j-1;
        tempCost = totalCost + *(node + key_matlab + pixel*3);
        if(visited[key] != 1 && cost[key] > tempCost)      // 4
        {
            cost[key] = tempCost;
            *(preNode + (j-2)*m + i-1) = i;
            *(preNode + pixel + (j-2)*m + i-1) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = (i+1)*(n+2)+j-1;
        tempCost = totalCost + *(node + key_matlab + pixel*4);
        if(visited[key] != 1 && cost[key] > tempCost)      // 5
        {
            cost[key] = tempCost;
            *(preNode + (j-2)*m + i) = i;
            *(preNode + pixel + (j-2)*m + i) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = (i+1)*(n+2)+j;
        tempCost = totalCost + *(node + key_matlab + pixel*5);
        if(visited[key] != 1 && cost[key] > tempCost)      // 6
        {
            cost[key] = tempCost;
            *(preNode + (j-1)*m + i) = i;
            *(preNode + pixel + (j-1)*m + i) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = (i+1)*(n+2)+j+1;
        tempCost = totalCost + *(node + key_matlab + pixel*6);
        if(visited[key] != 1 && cost[key] > tempCost)      // 7
        {
            cost[key] = tempCost;
            *(preNode + j*m + i) = i;
            *(preNode + pixel + j*m + i) = j;
            PQ.push(pp(key, tempCost));
        }
        
        key = i*(n+2)+j+1;
        tempCost = totalCost + *(node + key_matlab + pixel*7);
        if(visited[key] != 1 && cost[key] > tempCost)      // 8
        {
            cost[key] = tempCost;
            *(preNode + j*m + (i-1)) = i;
            *(preNode + pixel + j*m + (i-1)) = j;
            PQ.push(pp(key, tempCost));
        }
        
    }
    
    
    delete[] visited;
    delete[] cost;
}


void mexFunction( int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    
    double *node;
    size_t m,n, seedX, seedY;
    
    node = mxGetPr(prhs[0]);
    
    m = mxGetScalar(prhs[1]);
    n = mxGetScalar(prhs[2]);
    seedX = mxGetScalar(prhs[3]);
    seedY = mxGetScalar(prhs[4]);
    
    /*  set the output pointer to the output matrix */
    int dims[3]={m,n,2};
    plhs[0] = mxCreateNumericArray(3, dims, mxDOUBLE_CLASS, mxREAL);
    /*  create a C pointer to a copy of the output matrix */
    double *preNode = mxGetPr(plhs[0]);
    costPath(node, preNode, m, n, seedX, seedY);
    
}