import java.util.Comparator;

public class Point implements Comparable<Point> {

    public final Comparator<Point> SLOPE_ORDER = new SlopeComparator();

    private final int x;
    private final int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public void draw() {
        StdDraw.point(x, y);
    }

    public void drawTo(Point that) {
        StdDraw.line(this.x, this.y, that.x, that.y);
    }

    public double slopeTo(Point that) {
        Double dx = Double.valueOf(that.x - this.x);
        Double dy = Double.valueOf(that.y - this.y);

        if (dx == 0 && dy == 0) {
            return Double.NEGATIVE_INFINITY;
        }
        if (dx == 0) {
            return Double.POSITIVE_INFINITY;
        }
        if (dy == 0) {
            return +0.0;
        }

        return dy / dx;
    }

    @Override
    public int compareTo(Point that) {
        if (this.y < that.y) {
            return -1;
        }
        if (this.y == that.y) {
            if (this.x == that.x) {
                return 0;
            }
            if (this.x < that.x) {
                return -1;
            }
        }
        return 1;
    }

    private class SlopeComparator implements Comparator<Point> {
        @Override
        public int compare(Point p1, Point p2) {
            Double slope1 = slopeTo(p1);
            Double slope2 = slopeTo(p2);

            return slope1.compareTo(slope2);
        }
    }

    @Override
    public String toString() {
        return "(" + x + ", " + y + ")";
    }

    public static void main(String[] args) {
        Point p1 = new Point(1, 1);
        Point p2 = new Point(3, 1);
        System.out.println(p1.slopeTo(p2)); // should be pos zero

        p1 = new Point(1, 1);
        p2 = new Point(1, 2);
        System.out.println(p1.slopeTo(p2)); // should be pos infinity

        System.out.println(p1.slopeTo(p1)); // should be neg infinity
    }
}