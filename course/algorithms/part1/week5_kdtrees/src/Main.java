/**
 * **********************************************************************
 * Compilation:  javac NearestNeighborVisualizer.java
 * Execution:    java NearestNeighborVisualizer input.txt
 * Dependencies: PointSET.java KdTree.java Point2D.java In.java StdDraw.java
 * <p/>
 * Read points from a file (specified as a command-line argument) and
 * draw to standard draw. Highlight the closest point to the mouse.
 * <p/>
 * The nearest neighbor according to the brute-force algorithm is drawn
 * in red; the nearest neighbor using the kd-tree algorithm is drawn in blue.
 * <p/>
 * ***********************************************************************
 */

public class Main {

    public static void main(String[] args) {
        String filename = "kdtree/circle10.txt";
        In in = new In(filename);

        // initialize the two data structures with point from standard input
        PointSET brute = new PointSET();
        KdTree kdtree = new KdTree();
        while (!in.isEmpty()) {
            double x = in.readDouble();
            double y = in.readDouble();
            Point2D p = new Point2D(x, y);
            kdtree.insert(p);
            brute.insert(p);
        }


        Point2D query = new Point2D(0.51, 0.49);

        System.out.println(brute.size());
        System.out.println(kdtree.size());

        System.out.println(brute.nearest(query));
        System.out.println(kdtree.nearest(query));
    }
}