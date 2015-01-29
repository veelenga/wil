import java.util.LinkedList;
import java.util.List;

public class LongestPath {
    private Graph graph;
    private boolean marked[];

    public LongestPath(Graph g) {
        this.graph = g;
        init();
    }

    private void init(){
        marked = new boolean[graph.V()];
    }

    private LinkedList<Integer> dfs(int start) {
        LinkedList<Integer> path = new LinkedList<Integer>();

        marked[start] = true;
        path.add(start);

        List<Integer> longest = new LinkedList<Integer>();
        for (int v : graph.adj(start)) {
            if (!marked[v]) {
                marked[v] = true;
                List<Integer> l = dfs(v);
                if (longest.size() < l.size()){
                    longest = l;
                }
            }
        }
        path.addAll(longest);
        return path;
    }

    public Iterable<Integer> getLongestPath() {
        LinkedList<Integer> path = dfs(0);
        init();
        return dfs(path.getLast());
    }

    public static void main(String[] str) {
        rank(85, new int[]{13, 22, 27, 39, 55, 57, 66, 76 ,77, 78, 85 ,89, 94, 97, 98 });
        /*
        LongestPath lp = new LongestPath(g1());
        for (int i : lp.getLongestPath()) {
            System.out.print(i + " ");
        }

        System.out.println();
        lp = new LongestPath(g2());
        for (int i : lp.getLongestPath()) {
            System.out.print(i + " ");
        }
        */
    }
    public static int rank(int key, int[] a) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            // Key is in a[lo..hi] or not present.
            int mid = lo + (hi - lo) / 2;
            System.out.println(a[mid]);
            if      (key < a[mid]) hi = mid - 1;
            else if (key > a[mid]) lo = mid + 1;
            else return mid;
        }
        return -1;
    }

    public static Graph g1() {

        Graph g = new Graph(16);

        g.addEdge(0, 1);
        g.addEdge(0, 2);
        g.addEdge(0, 3);

        g.addEdge(1, 13);
        g.addEdge(13, 14);
        g.addEdge(14, 15);
        //g.addEdge(15, 16);

        g.addEdge(2, 4);
        g.addEdge(4, 5);
        g.addEdge(5, 6);
        g.addEdge(5, 7);
        g.addEdge(7, 8);
        g.addEdge(8, 9);

        g.addEdge(3, 10);
        g.addEdge(10, 11);
        g.addEdge(11, 12);

        return g;
    }

    public static Graph g2() {

        Graph g = new Graph(13);

        g.addEdge(0, 1);
        g.addEdge(0, 2);
        g.addEdge(0, 3);

        g.addEdge(2, 4);
        g.addEdge(4, 5);
        g.addEdge(5, 6);
        g.addEdge(5, 7);
        g.addEdge(7, 8);
        g.addEdge(8, 9);

        g.addEdge(3, 10);
        g.addEdge(10, 11);
        g.addEdge(11, 12);

        return g;
    }
}
