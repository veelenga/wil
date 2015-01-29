---------------------------------
Undirected Graphs:

Q1. Implement dfs in undirected graph without recursion
A: 

Easy to implement using stack

Q2. Design a linear-time algorithm to find the longest simple path in the tree
A: 

Run dfs from any vertex, then run dfs from the furthest point.

Redesign dfs recursive function to return longest path from staring point: 
	add to longest path the longest path of all adjacent vertices. 

Q3. Eulierian cycle. Linear time algorithm to detect Eulierian cycle
A: 

1. Mark edges and vetices
2. If adjacent vertex is marked but there is a free edge, mark that edge as used and run dfs from this point

    private void dfs(int v){

        markedV[v] = true;
        path.enqueue(v);

        for (int a: graph.adj(v)){
            if (markedV[a]){
                int freeEdges = getTotalEdgeCount(a, v) - getMarkedEdgeCount(a,v);
                if (freeEdges > 0){
                    increaseMarkedEdgeCount(a, v);
                    dfs(a);
                }
            }else{
                markedE.put(new Edge(v, a), 1);
                dfs(a);
            }
        }
    }

Q3. How to find hamilton path ?

A:
