import java.util.Arrays;

public class Brute {
    private static final void outSequence(Point[] seq) {
        for (int i = 0; i < seq.length - 1; i++) {
            System.out.print(seq[i] + " -> ");
        }
        System.out.println(seq[seq.length - 1]);
    }

    private static final void drawLine(Point[] seq) {
        seq[0].drawTo(seq[seq.length - 1]);
    }

    public static void main(String[] str) {

        StdDraw.setXscale(0, 32768);
        StdDraw.setYscale(0, 32768);

        String filename = str[0];
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

        for (int i = 0; i < points.length; i++) {
            Point p1 = points[i];
            for (int j = i + 1; j < points.length; j++) {
                Point p2 = points[j];
                for (int k = j + 1; k < points.length; k++) {
                    Point p3 = points[k];
                    for (int n = k + 1; n < points.length; n++) {
                        Point p4 = points[n];

                        double slopeOrig = p2.slopeTo(p1);
                        if (slopeOrig == p3.slopeTo(p1) && slopeOrig == p4.slopeTo(p1)) {
                            Point[] col = new Point[4];
                            col[0] = p1;
                            col[1] = p2;
                            col[2] = p3;
                            col[3] = p4;
                            Arrays.sort(col);
                            outSequence(col);
                            drawLine(col);
                        }
                    }
                }
            }
        }

        //StdDraw.show(0);
    }
}
