import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * Double-ended queue or dequeue.
 * @param <Item>
 *            type of queue items
 */
public class Deque<Item> implements Iterable<Item> {

    /** Pointer to the queue head. */
    private Node first;
    /** Pointer to the queue tail. */
    private Node last;

    /** Size of queue. */
    private int size;

    private class Node {
        private Item item;
        private Node next;
        private Node previous;
    }

    /**
     * Initialize empty queue.
     */
    public Deque() {
        size = 0;
        first = null;
        last = null;
    }

    /**
     * Is queue empty ?
     * @return true if queue is empty, false otherwise.
     */
    public boolean isEmpty() {
        return first == null;
    }

    /**
     * Size of queue.
     * @return size
     */
    public int size() {
        return size;
    }

    /**
     * Adds item to the beginning of the queue.
     * @param item
     *            to add
     */
    public void addFirst(final Item item) {
        if (item == null) {
            throw new NullPointerException();
        }
        Node oldfirst = first;
        first = new Node();
        first.item = item;
        first.next = oldfirst;
        if (size == 0) {
            last = first;
        } else {
            oldfirst.previous = first;
        }
        size++;
    }

    /**
     * Adds item to the end of the queue.
     * @param item
     *            to add
     */
    public void addLast(final Item item) {
        if (item == null) {
            throw new NullPointerException();
        }
        Node oldlast = last;
        last = new Node();
        last.item = item;
        if (size == 0) {
            first = last;
        } else {
            oldlast.next = last;
        }
        last.previous = oldlast;

        size++;
    }

    /**
     * Removes head of the queue.
     * @return item that was removed.
     * @throws java.util.NoSuchElementException
     *             if queue is empty.
     */
    public Item removeFirst() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        Item item = first.item;
        first = first.next;
        if (first != null) {
            first.previous = null;
        }
        if (size == 1) {
            last = null;
        }
        size--;
        return item;
    }

    /**
     * Removes tail of the queue.
     * @return item that was removed.
     * @throws java.util.NoSuchElementException
     *             if queue is empty.
     */
    public Item removeLast() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        Item item = last.item;
        last = last.previous;
        if (last != null) {
            last.next = null;
        }
        if (size == 1) {
            first = null;
        }
        size--;
        return item;
    }

    @Override
    public Iterator<Item> iterator() {
        return new DequeIterator();
    }

    private class DequeIterator implements Iterator<Item> {
        private Node current = first;

        @Override
        public boolean hasNext() {
            return current != null;
        }

        @Override
        public Item next() {
            if (!hasNext()) {
                throw new NoSuchElementException();
            }
            Item item = current.item;
            current = current.next;
            return item;
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }
    }

    /**
     * Entry point.
     * @param str
     *            command line arguments
     */
    public static void main(final String[] str) {
        Deque<Integer> queue = new Deque<>();
        final int size = 1000;
        for (int i = 0; i < size; i++) {
            queue.addFirst(i);
        }
        System.out.println(size + " = " + queue.size());
        Iterator<?> iterator = queue.iterator();
        int count = 0;
        while (iterator.hasNext()) {
            iterator.next();
            count++;
        }
        System.out.println(queue.size() + " = " + count);
        for (int i = 0; i < size; i++) {
            queue.removeLast();
        }
        System.out.println("0 = " + queue.size());
    }
}
