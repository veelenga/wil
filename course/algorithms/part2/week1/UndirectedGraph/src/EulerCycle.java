import java.util.HashMap;
import java.util.Map;

public class EulerCycle {

    private Graph graph;
    private boolean markedV[];
    private Map<Edge, Integer> markedE;
    private Queue<Integer> path;

    public EulerCycle(Graph g) {
        this.graph = g;

        markedV = new boolean[g.V()];
        markedE = new HashMap<Edge, Integer>(g.E());
        path = new Queue<Integer>();
    }

    private class Edge {
        Integer v1;
        Integer v2;

        public Edge(int v1, int v2) {
            this.v1 = v1;
            this.v2 = v2;
        }

        @Override
        public boolean equals(Object o) {
            if (o instanceof Edge) {
                Edge e = (Edge) o;
                return (v1 == e.v1 && v2 == e.v2) || (v1 == e.v2 && v2 == e.v1);
            } else {
                return false;
            }
        }

        @Override
        public int hashCode() {
            return v1.hashCode() + v2.hashCode();
        }
    }

    public boolean hasEulerTour() {
        boolean hasEulerTour = true;
        for (int i = 0; i < graph.V(); i++) {
            int degree = 0;
            for (int v : graph.adj(i)) {
                degree++;
            }
            if (degree % 2 != 0) {
                hasEulerTour = false;
                break;
            }
        }
        return hasEulerTour;
    }

    private int getMarkedEdgeCount(int v1, int v2){
        int markedEdges = 0;
        Integer t = markedE.get(new Edge(v1, v2));
        if (t != null){
            markedEdges = t;
        }
        return markedEdges;
    }

    private int getTotalEdgeCount(int v1, int v2){
        int total = 0;
        for (int w: graph.adj(v1)){
            if (w == v2){
                total++;
            }
        }
        return total;
    }

    private void increaseMarkedEdgeCount(int v1, int v2){
        Edge e = new Edge(v1, v2);
        Integer t = markedE.get(e);
        if (t == null){
            markedE.put(e, 1);
        }else{
            markedE.put(e, t + 1);
        }
    }

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

    public Iterable<Integer> getPath() {
        if (hasEulerTour()) {
            dfs(0);
        }
        return path;
    }

    public static void main(String str[]) {

        EulerCycle ec;

        ec = new EulerCycle(g2());
        System.out.println(ec.hasEulerTour());

        System.out.print("Euler tour: ");
        for (int v : ec.getPath()) {
            System.out.print(v + " ");
        }

        ec = new EulerCycle(g1());
        System.out.println(ec.hasEulerTour());

        System.out.print("Euler tour: ");
        for (int v : ec.getPath()) {
            System.out.print(v + " ");
        }

        ec = new EulerCycle(g3());
        System.out.println(ec.hasEulerTour());

        System.out.print("Euler tour: ");
        for (int v : ec.getPath()) {
            System.out.print(v + " ");
        }
    }

    private static Graph g1() {
        Graph g = new Graph(7);
        g.addEdge(0, 1);
        g.addEdge(1, 2);
        g.addEdge(2, 3);
        g.addEdge(3, 4);
        g.addEdge(4, 5);
        g.addEdge(5, 6);
        g.addEdge(6, 3);
        g.addEdge(3, 0);

        return g;
    }

    public static Graph g2() {

        Graph g = new Graph(3);
        g.addEdge(0, 1);
        g.addEdge(1, 0);

        g.addEdge(0, 2);
        g.addEdge(2, 0);

        return g;
    }

    public static Graph g3() {

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
}
