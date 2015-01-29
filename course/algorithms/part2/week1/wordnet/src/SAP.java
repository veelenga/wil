public class SAP {
    private Digraph g;

    public SAP(Digraph G) {
        g = new Digraph(G);
    }

    public int length(int v, int w) {
        checkBound(v);
        checkBound(w);

        BreadthFirstDirectedPaths d1 = new BreadthFirstDirectedPaths(g, v);
        BreadthFirstDirectedPaths d2 = new BreadthFirstDirectedPaths(g, w);

        int minDistance = -1;
        for (int i = 0; i < g.V(); i++) {
            if (d1.hasPathTo(i) && d2.hasPathTo(i)) {
                int dist = d1.distTo(i) + d2.distTo(i);
                if (minDistance < 0 || dist < minDistance) {
                    minDistance = dist;
                }
            }
        }
        return minDistance;
    }

    public int ancestor(int v, int w) {
        checkBound(v);
        checkBound(w);

        BreadthFirstDirectedPaths d1 = new BreadthFirstDirectedPaths(g, v);
        BreadthFirstDirectedPaths d2 = new BreadthFirstDirectedPaths(g, w);

        int minDistance = Integer.MAX_VALUE;
        int ancestor = -1;
        for (int i = 0; i < g.V(); i++) {
            if (d1.hasPathTo(i) && d2.hasPathTo(i)) {
                int dist = d1.distTo(i) + d2.distTo(i);
                if (dist < minDistance) {
                    minDistance = dist;
                    ancestor = i;
                }
            }
        }
        return ancestor;
    }

    private final void checkBound(int v) {
        if (v < 0 || v > g.V() - 1) {
            throw new ArrayIndexOutOfBoundsException();
        }
    }

    private void checkBound(Iterable<Integer> v) {
        for (Integer aV : v) {
            checkBound(aV);
        }
    }

    public int length(Iterable<Integer> v, Iterable<Integer> w) {
        checkBound(v);
        checkBound(w);

        BreadthFirstDirectedPaths d1 = new BreadthFirstDirectedPaths(g, v);
        BreadthFirstDirectedPaths d2 = new BreadthFirstDirectedPaths(g, w);

        int minDistance = -1;
        for (int i = 0; i < g.V(); i++) {
            if (d1.hasPathTo(i) && d2.hasPathTo(i)) {
                int dist = d1.distTo(i) + d2.distTo(i);
                if (minDistance < 0 || dist < minDistance) {
                    minDistance = dist;
                }
            }
        }

        return minDistance;
    }

    public int ancestor(Iterable<Integer> v, Iterable<Integer> w) {
        checkBound(v);
        checkBound(w);

        BreadthFirstDirectedPaths d1 = new BreadthFirstDirectedPaths(g, v);
        BreadthFirstDirectedPaths d2 = new BreadthFirstDirectedPaths(g, w);

        int minDistance = Integer.MAX_VALUE;
        int ancestor = -1;
        for (int i = 0; i < g.V(); i++) {
            if (d1.hasPathTo(i) && d2.hasPathTo(i)) {
                int dist = d1.distTo(i) + d2.distTo(i);
                if (dist < minDistance) {
                    minDistance = dist;
                    ancestor = i;
                }
            }
        }
        return ancestor;
    }

    public static void main(String[] args) {
        String filename = "input/digraph1.txt";

        In in = new In(filename);
        Digraph G = new Digraph(in);
        SAP sap = new SAP(G);

        int length = sap.length(3, 11);
        int ancestor = sap.ancestor(3, 11);
        StdOut.printf("length = %d, ancestor = %d\n", length, ancestor);

        length = sap.length(9, 12);
        ancestor = sap.ancestor(9, 12);
        StdOut.printf("length = %d, ancestor = %d\n", length, ancestor);

        length = sap.length(7, 2);
        ancestor = sap.ancestor(7, 2);
        StdOut.printf("length = %d, ancestor = %d\n", length, ancestor);

        length = sap.length(1, 6);
        ancestor = sap.ancestor(1, 6);
        StdOut.printf("length = %d, ancestor = %d\n", length, ancestor);

        Queue<Integer> v = new Queue<Integer>();
        v.enqueue(11);
        v.enqueue(12);

        Queue<Integer> w = new Queue<Integer>();
        w.enqueue(7);
        w.enqueue(8);

        length = sap.length(v, w);
        ancestor = sap.ancestor(v, w);
        StdOut.printf("length = %d, ancestor = %d\n", length, ancestor);
    }
}
