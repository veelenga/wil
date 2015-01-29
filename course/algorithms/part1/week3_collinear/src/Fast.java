import java.util.Arrays;
import java.util.Collections;
import java.util.LinkedList;

public class Fast {

    private static final void outSequence(LinkedList<Point> sequence) {
        Point[] arr = sequence.toArray(new Point[sequence.size()]);
        for (int i = 0; i < arr.length - 1; i++) {
            System.out.print(arr[i] + " -> ");
        }
        System.out.println(arr[arr.length - 1]);
    }

    private static final void drawLine(LinkedList<Point> col) {
        col.getFirst().drawTo(col.getLast());
    }

    public static void main(String[] args) {
        StdDraw.setXscale(0, 32768);
        StdDraw.setYscale(0, 32768);

        String filename = args[0];
        In in = new In(filename);
        int N = in.readInt();
        Point[] points = new Point[N];
        for (int i = 0; i < N; i++) {
            int x = in.readInt();
            int y = in.readInt();
            Point p = new Point(x, y);
            p.draw();

            points[i] = p;
        }

        Point a[] = Arrays.copyOf(points, points.length);
        for (int i = 0; i < points.length; i++) {
            Point orig = points[i];
            Arrays.sort(a, orig.SLOPE_ORDER);

            int index = 1;
            while (index < a.length - 2) {
                double slope = orig.slopeTo(a[index]);
                if (slope == orig.slopeTo(a[index + 1]) && slope == orig.slopeTo(a[index + 2])) {

                    LinkedList<Point> col = new LinkedList<Point>();
                    col.add(orig);
                    col.add(a[index]);
                    col.add(a[index + 1]);
                    col.add(a[index + 2]);

                    index = index + 3;
                    while (index < a.length && slope == orig.slopeTo(a[index])) {
                        col.add(a[index++]);
                    }

                    Collections.sort(col);
                    if (col.getFirst().compareTo(orig) == 0) {
                        outSequence(col);
                        drawLine(col);
                    }
                } else {
                    index++;
                }
            }
        }
        //StdDraw.show(0);
    }
}
