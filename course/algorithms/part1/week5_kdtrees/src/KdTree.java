import java.util.Iterator;

public class KdTree {

    private final static boolean VERTICAL = true;
    private final static RectHV CONTAINER = new RectHV(0, 0, 1, 1);

    private Node root;
    private int size;

    private static class Node {
        private Point2D p;
        private Node right, left;

        public Node(Point2D p) {
            this.p = p;
        }
    }

    public KdTree() {
        size = 0;
    }

    public boolean isEmpty() {
        return root == null;
    }

    public int size() {
        return size;
    }

    public void insert(Point2D p) {
        root = insert(root, p, VERTICAL);
    }

    private Node insert(Node node, Point2D p, boolean vertical) {
        if (node == null) {
            size++;
            return new Node(p);
        }

        /* exclude duplicates */
        if (node.p.x() == p.x() && node.p.y() == p.y()) {
            return node;
        }

        if (vertical) {
            if (node.p.x() > p.x()) {
                node.left = insert(node.left, p, !vertical);
            } else {
                node.right = insert(node.right, p, !vertical);
            }
        } else {
            if (node.p.y() > p.y()) {
                node.left = insert(node.left, p, !vertical);
            } else {
                node.right = insert(node.right, p, !vertical);
            }
        }

        return node;
    }

    private RectHV getLeftRect(Point2D p, RectHV rect, boolean vertical) {

        if (vertical) {
            return new RectHV(rect.xmin(), rect.ymin(), p.x(), rect.ymax());
        } else {
            return new RectHV(rect.xmin(), rect.ymin(), rect.xmax(), p.y());
        }
    }
    private RectHV getRightRect(Point2D p, RectHV rect, boolean vertical) {
        if (vertical) {
            return new RectHV(p.x(), rect.ymin(), rect.xmax(), rect.ymax());
        } else {
            return new RectHV(rect.xmin(), p.y(), rect.xmax(), rect.ymax());
        }
    }

    public boolean contains(Point2D p) {
        return get(root, p, VERTICAL) != null;
    }

    private Node get(Node node, Point2D p, boolean vertical) {
        if (node == null) {
            return null;
        }

        Double x = node.p.x();
        Double y = node.p.y();

        if (x.compareTo(p.x()) == 0 && y.compareTo(p.y()) == 0)
            return node;

        if (vertical) {
            if (x.compareTo(p.x()) <= 0) {
                return get(node.right, p, !vertical);
            } else {
                return get(node.left, p, !vertical);
            }
        } else {
            if (y.compareTo(p.y()) <= 0) {
                return get(node.right, p, !vertical);
            } else {
                return get(node.left, p, !vertical);
            }
        }
    }

    public void draw() {
        draw(root, CONTAINER, VERTICAL);
    }

    private void draw(Node node, RectHV rect, boolean vertical) {
        if (node == null) {
            return;
        }

        drawNode(node, rect, vertical);

        draw(node.left, getLeftRect(node.p, rect, vertical), !vertical);
        draw(node.right, getRightRect(node.p, rect, vertical), !vertical);
    }

    private void drawPoint(Point2D p) {
        StdDraw.setPenColor(StdDraw.BLACK);
        StdDraw.setPenRadius(.01);
        p.draw();
    }

    private void drawNode(Node node, RectHV rect, boolean vertical) {
        drawPoint(node.p);

        StdDraw.setPenRadius();
        Point2D p1, p2;
        if (vertical) {
            StdDraw.setPenColor(StdDraw.RED);
            p1 = new Point2D(node.p.x(), rect.ymin());
            p2 = new Point2D(node.p.x(), rect.ymax());
        } else {
            StdDraw.setPenColor(StdDraw.BLUE);
            p1 = new Point2D(rect.xmin(), node.p.y());
            p2 = new Point2D(rect.xmax(), node.p.y());
        }
        p1.drawTo(p2);
    }

    public Iterable<Point2D> range(RectHV query) {
        Queue<Point2D> queue = new Queue<Point2D>();
        range(root, query, CONTAINER, VERTICAL, queue);
        return queue;
    }

    private void range(Node node, RectHV query, RectHV rect, boolean vertical, Queue<Point2D> queue) {
        if (node == null) {
            return;
        }
        if (query.intersects(rect)) {
            if (query.contains(node.p)) {
                queue.enqueue(node.p);
            }
            range(node.left, query, getLeftRect(node.p, rect, vertical), !vertical, queue);
            range(node.right, query, getRightRect(node.p, rect, vertical), !vertical, queue);
        }
    }

    public Point2D nearest(Point2D p) {
        if (root == null) {
            return null;
        }
        return nearest(root, root.p, CONTAINER, p, VERTICAL);
    }

    private Point2D nearest(Node node, Point2D nearest, RectHV rect, Point2D queryPoint, boolean vertical) {
        if (node == null) {
            return nearest;
        }

        double distanceToPoint = nearest.distanceSquaredTo(queryPoint);
        double distanceToRect = rect.distanceSquaredTo(queryPoint);

        if (distanceToRect < distanceToPoint) {
            if (node.p.distanceSquaredTo(queryPoint) < distanceToPoint) {
                nearest = node.p;
            }

            RectHV left, right;
            double x = node.p.x();
            double y = node.p.y();
            double xmin = rect.xmin();
            double ymin = rect.ymin();
            double xmax = rect.xmax();
            double ymax = rect.ymax();

            if (vertical) {
                left = new RectHV(xmin, ymin, x, ymax);
                right = new RectHV(x, ymin, xmax, ymax);
                if (queryPoint.x() < x) {
                    nearest = nearest(node.left, nearest, left, queryPoint, !vertical);
                    nearest = nearest(node.right, nearest, right, queryPoint, !vertical);
                } else {
                    nearest = nearest(node.right, nearest, right, queryPoint, !vertical);
                    nearest = nearest(node.left, nearest, left, queryPoint, !vertical);
                }
            } else {
                left = new RectHV(xmin, ymin, xmax, y);
                right = new RectHV(xmin, y, xmax, ymax);
                if (queryPoint.y() < y) {
                    nearest = nearest(node.left, nearest, left, queryPoint, !vertical);
                    nearest = nearest(node.right, nearest, right, queryPoint, !vertical);
                } else {
                    nearest = nearest(node.right, nearest, right, queryPoint, !vertical);
                    nearest = nearest(node.left, nearest, left, queryPoint, !vertical);
                }
            }
        }

        return nearest;
    }

    /* Tests starting here */
    public static void main(String str[]) {
        checkInsertContainsSize();
        checkInsertTwice();
        checkInsertRandom();
        checkReversed();

        checkBoundary();
        checkBoundary2();
        checkBoundary3();

        checkNearest();
        checkNearest2();
        checkNearest3();
        checkNearest4();

        checkRange();
    }

    private static void checkRange() {

        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        final int N = 100000;
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            Point2D p = new Point2D(x, y);

            t.insert(p);
            brute.insert(p);
        }

        RectHV query1 = new RectHV(0, 0, 1, 1);
        assert equal(t.range(query1), brute.range(query1));

        RectHV query2 = new RectHV(0.5, 0.5, 0.51, 0.51);
        assert equal(t.range(query2), brute.range(query2));

        RectHV query3 = new RectHV(0.2, 0.4, 0.2, 0.6);
        assert equal(t.range(query3), brute.range(query3));

        RectHV query4 = new RectHV(0.1, 0.4, 0.9, 0.4);
        assert equal(t.range(query4), brute.range(query4));
    }

    private static boolean equal(Iterable<Point2D> iter1, Iterable<Point2D> iter2) {
        Iterator<Point2D> i = iter1.iterator();

        SET<Point2D> set = new SET<Point2D>();
        while (i.hasNext()) {
            set.add(i.next());
        }

        i = iter2.iterator();
        SET<Point2D> set2 = new SET<Point2D>();
        while (i.hasNext()) {
            set2.add(i.next());
        }

        return set.equals(set2);
    }

    private static void checkBoundary3() {
        Point2D p1 = new Point2D(0.5, 0.12);
        Point2D p2 = new Point2D(0.5, 0.13);
        Point2D p3 = new Point2D(0.5, 0.14);

        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        brute.insert(p1);
        brute.insert(p2);
        brute.insert(p3);

        assert brute.contains(p1);
        assert brute.contains(p2);
        assert brute.contains(p3);

        t.insert(p1);
        t.insert(p2);
        t.insert(p3);

        assert t.contains(p1);
        assert t.contains(p2);
        assert t.contains(p3);

    }

    private static void checkBoundary2() {

        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        final int N = 100000;
        Point2D[] p1 = new Point2D[N];
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            p1[i] = new Point2D(x, y);
            t.insert(p1[i]);
            brute.insert(p1[i]);
        }

        Point2D[] p2 = new Point2D[N];
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);

            p2[i] = new Point2D(x, 0.55555);
            t.insert(p2[i]);
            brute.insert(p2[i]);

        }

        Point2D[] p3 = new Point2D[N];
        for (int i = 0; i < N; i++) {
            double y = StdRandom.uniform(0.0, 1.0);

            p3[i] = new Point2D(0.144442234, y);
            t.insert(p3[i]);
            brute.insert(p3[i]);
        }

        for (int i = 0; i < N; i++) {
            assert brute.contains(p1[i]);
            assert brute.contains(p2[i]);
            assert brute.contains(p3[i]);
            assert t.contains(p1[i]);
            assert t.contains(p2[i]);
            assert t.contains(p3[i]);
        }
    }
    private static void checkBoundary() {

        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        final int N = 100000;
        Point2D p1 = new Point2D(0.0, 0.0);
        Point2D p2 = new Point2D(0.0, 1.0);
        Point2D p3 = new Point2D(1.0, 1.0);
        Point2D p4 = new Point2D(1.0, 0.0);
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            Point2D p = new Point2D(x, y);

            t.insert(p);
            t.insert(p1);
            t.insert(p2);
            t.insert(p3);
            t.insert(p4);

            brute.insert(p);
            brute.insert(p1);
            brute.insert(p2);
            brute.insert(p3);
            brute.insert(p4);

            assert t.size() == brute.size();
        }
        assert t.contains(p1);
        assert t.contains(p2);
        assert t.contains(p3);
        assert t.contains(p4);

        assert brute.contains(p1);
        assert brute.contains(p2);
        assert brute.contains(p3);
        assert brute.contains(p4);
    }

    private static void checkReversed() {
        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        final int N = 100000;
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 0.9);
            double y = StdRandom.uniform(0.0, 0.9);

            Point2D p = new Point2D(x, y);
            Point2D p2 = new Point2D(x + 0.0001, y + 0.0000000001);
            Point2D p3 = new Point2D(y, x);

            t.insert(p);
            t.insert(p2);
            t.insert(p3);

            assert t.contains(p);
            assert t.contains(p2);
            assert t.contains(p3);

            brute.insert(p);
            brute.insert(p2);
            brute.insert(p3);

            assert brute.contains(p);
            assert brute.contains(p2);
            assert brute.contains(p3);
        }

        assert t.size() == brute.size();
    }

    private static void checkInsertContainsSize() {
        final int N = 100000;
        Point2D[] p = new Point2D[N];
        for (int i = 0; i < p.length; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            p[i] = new Point2D(x, y);
        }

        KdTree t = new KdTree();
        assert t.isEmpty();

        for (int i = 0; i < p.length; i++) {
            t.insert(p[i]);
            assert t.size() == i + 1;
        }

        assert t.size() == N;

        // insert again
        for (Point2D aP : p) {
            t.insert(aP);
        }
        assert t.size() == N;

        for (Point2D aP : p) {
            assert t.contains(aP);
        }

        for (int i = p.length - 1; i >= 0; i--) {
            assert t.contains(p[i]);
        }

        assert !t.isEmpty();
    }

    private static void checkInsertRandom() {
        KdTree kdtree = new KdTree();
        PointSET brute = new PointSET();

        final int N = 1000000;
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            Point2D p = new Point2D(x, y);

            kdtree.insert(p);
            brute.insert(p);
        }

        assert kdtree.size() == brute.size();

        Point2D p = new Point2D(0.11111, 0.99991);
        assert kdtree.nearest(p).equals(brute.nearest(p));
    }

    private static void checkInsertTwice() {
        KdTree t = new KdTree();

        Point2D p = new Point2D(0.5, 0.5);
        t.insert(p);
        t.insert(p);

        assert t.size() == 1;
    }

    private static void checkNearest() {
        KdTree t = new KdTree();
        t.insert(new Point2D(0.7, 0.2));
        t.insert(new Point2D(0.5, 0.4));
        t.insert(new Point2D(0.2, 0.3));
        t.insert(new Point2D(0.4, 0.7));
        t.insert(new Point2D(0.9, 0.6));

        Point2D p = t.nearest(new Point2D(0.5, 0.5));

        assert Double.compare(p.x(), 0.5) == 0;
        assert Double.compare(p.y(), 0.4) == 0;
    }

    private static void checkNearest2() {
        KdTree t = new KdTree();
        t.insert(new Point2D(0.5, 0.5));
        t.insert(new Point2D(0.6, 0.9));
        t.insert(new Point2D(0.2, 0.5));
        t.insert(new Point2D(0.3, 0.3));
        t.insert(new Point2D(0.3, 0.7));

        Point2D p = t.nearest(new Point2D(0.1, 0.6));

        assert Double.compare(p.x(), 0.2) == 0;
        assert Double.compare(p.y(), 0.5) == 0;
    }

    private static void checkNearest3() {
        KdTree t = new KdTree();

        final int N = 100000;
        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            t.insert(new Point2D(x, y));
        }

        Point2D p = new Point2D(0.51111, 0.344444);
        t.insert(p);

        final double e = 0.000001;
        Point2D n2 = new Point2D(p.x() + e, p.y() + e);
        Point2D n3 = new Point2D(p.x(), p.y() + e);
        Point2D n4 = new Point2D(p.x() + e, p.y());

        assert t.nearest(n2).equals(p);
        assert t.nearest(n3).equals(p);
        assert t.nearest(n4).equals(p);
    }

    private static void checkNearest4() {
        KdTree t = new KdTree();
        PointSET brute = new PointSET();

        final int N = 100000;
        final double xb = 0.44444444;
        final double yb = 0.1414141414;

        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = StdRandom.uniform(0.0, 1.0);

            Point2D p = new Point2D(x, y);
            t.insert(p);
            brute.insert(p);
        }

        for (int i = 0; i < N; i++) {
            double x = xb;
            double y = StdRandom.uniform(0.0, 1.0);

            Point2D p = new Point2D(x, y);
            t.insert(p);
            brute.insert(p);
        }

        for (int i = 0; i < N; i++) {
            double x = StdRandom.uniform(0.0, 1.0);
            double y = yb;

            Point2D p = new Point2D(x, y);
            t.insert(p);
            brute.insert(p);
        }

        Point2D query = new Point2D(xb, 0.5);
        assert t.nearest(query).equals(brute.nearest(query));

        query = new Point2D(0.5, yb);
        assert t.nearest(query).equals(brute.nearest(query));

        query = new Point2D(xb, yb);
        assert t.nearest(query).equals(brute.nearest(query));
    }
}
