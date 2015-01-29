public class NonRecursiveDFS {
    private Graph graph;
    private boolean marked[];

    public NonRecursiveDFS(Graph g) {
        this.graph = g;
        marked = new boolean[g.V()];
    }

    public void walk() {
        int start = 0;
        Stack<Integer> stack = new Stack<Integer>();
        stack.push(start);
        marked[start] = true;

        System.out.println(graph);
        System.out.println("Here is non-recursive tour through the graph: ");
        while (!stack.isEmpty()) {
            int v = stack.pop();
            System.out.print(v + " ");

            for (int w : graph.adj(v)) {
                if (!marked[w]) {
                    stack.push(w);
                    marked[w] = true;
                }
            }
        }
    }

    public static void main(String str[]) {
        NonRecursiveDFS n = new NonRecursiveDFS(g1());
        n.walk();

        n = new NonRecursiveDFS(g2());
        n.walk();
    }

    public static Graph g1() {

        Graph g = new Graph(6);
        g.addEdge(0, 1);
        g.addEdge(0, 3);
        g.addEdge(0, 3);
        g.addEdge(0, 5);

        g.addEdge(1, 2);
        g.addEdge(1, 2);
        g.addEdge(1, 3);

        g.addEdge(2, 3);
        g.addEdge(2, 4);

        g.addEdge(3, 4);
        g.addEdge(3, 5);

        g.addEdge(4, 5);
        g.addEdge(4, 5);

        return g;
    }

    public static Graph g2(){

        Graph g = new Graph(12);

        g.addEdge(0, 1);
        g.addEdge(0, 2);
        g.addEdge(0, 3);

        g.addEdge(2, 4);
        g.addEdge(4, 5);
        g.addEdge(5, 6);
        g.addEdge(5, 7);
        g.addEdge(7, 8);
        g.addEdge(8, 8);

        g.addEdge(3, 9);
        g.addEdge(9, 10);
        g.addEdge(10, 11);

        return g;
    }
}
