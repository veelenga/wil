import java.util.*;

public class PointSET {
    private SET<Point2D> points;

    public PointSET(){
        points = new SET<Point2D>();
    }

    public boolean isEmpty() {
        return points.isEmpty();
    }

    public int size() {
        return points.size();
    }

    public void insert(Point2D p) {
        points.add(p);
    }

    public boolean contains(Point2D p) {
        return points.contains(p);
    }

    public void draw() {
        Iterator<Point2D> iterator = points.iterator();
        while(iterator.hasNext()){
            iterator.next().draw();
        }
    }

    public Iterable<Point2D> range(RectHV rect) {

        Queue<Point2D> queue = new Queue<Point2D>();
        Iterator<Point2D> iterator = points.iterator();
        while (iterator.hasNext()){
            Point2D p = iterator.next();
            if (rect.contains(p)){
                queue.enqueue(p);
            }
        }
        return queue;
    }

    public Point2D nearest(Point2D p) {
        double min = Double.MAX_VALUE;
        Point2D result = null;

        Iterator<Point2D> iterator = points.iterator();
        while(iterator.hasNext()){
            Point2D next = iterator.next();
            double distance = p.distanceSquaredTo(next);
            if (distance < min){
                result = next;
                min = distance;
            }
        }
        return result;
    }
}
