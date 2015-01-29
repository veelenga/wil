import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * A randomized queue is similar to a stack or queue, except that the item
 * removed is chosen uniformly at random from items in the data structure.
 * @param <Item>
 *            type of item in queue
 */
public class RandomizedQueue<Item> implements Iterable<Item> {
    /** Queue is based on this array. */
    private Item[] a;
    /** Size of the queue. */
    private int size;

    /** Initializes empty queue with capacity 2. */
    @SuppressWarnings("unchecked")
    public RandomizedQueue() {
        a = (Item[]) new Object[2];
    }

    /**
     * Is queue empty ?
     * @return true if queue is empty, false otherwise.
     */
    public boolean isEmpty() {
        return size == 0;
    }

    /**
     * Returns size of the queue.
     * @return size
     */
    public int size() {
        return size;
    }

    /**
     * Resizes array using capacity.
     * @param capacity
     *            value to resize array
     */
    private void resize(final int capacity) {
        @SuppressWarnings("unchecked")
        Item[] temp = (Item[]) new Object[capacity];
        for (int i = 0; i < size; i++) {
            temp[i] = a[i];
        }
        a = temp;
    }

    /**
     * Exchanges a[i] a[j] values in queue array.
     * @param i
     *            will represent a[i]
     * @param j
     *            will represent a[j]
     */
    private void swap(final int i, final int j) {
        Item temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }

    /**
     * Generates random index in queue.
     * @return random int more or equal than 0, less than queue size.
     */
    private int randomIndex() {
        return StdRandom.uniform(size);
    }

    /**
     * Adds item to queue.
     * @param item
     *            item to add.
     */
    public void enqueue(final Item item) {
        if (item == null) {
            throw new NullPointerException();
        }
        if (a.length == size) {
            resize(size * 2);
        }
        a[size++] = item;
    }

    /**
     * Removes random item from queue.
     * @return item removed item.
     */
    public Item dequeue() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        int r = randomIndex();
        Item item = a[r];
        a[r] = null;
        if (r != size - 1) { // do not swap the last element
            swap(r, size - 1);
        }
        size--;
        if (size > 0 && size < a.length / 4) {
            resize(a.length / 2);
        }
        return item;
    }

    /**
     * Returns random item from queue without delete.
     * @return item random item
     */
    public Item sample() {
        if (isEmpty()) {
            throw new NoSuchElementException();
        }
        return a[randomIndex()];
    }

    @Override
    public Iterator<Item> iterator() {
        return new RandomizedQueueIterator();
    }

    private class RandomizedQueueIterator implements Iterator<Item> {
        private int[] indexOrder;
        private int index;

        public RandomizedQueueIterator() {
            indexOrder = new int[size];
            index = 0;
            for (int i = 0; i < indexOrder.length; i++) {
                indexOrder[i] = i;
            }
            StdRandom.shuffle(indexOrder);
        }

        @Override
        public boolean hasNext() {
            return index < size;
        }

        @Override
        public Item next() {
            if (!hasNext()) {
                throw new NoSuchElementException();
            }
            return a[indexOrder[index++]];
        }

        @Override
        public void remove() {
            throw new UnsupportedOperationException();
        }

    }

    public static void main(final String[] str) {
        RandomizedQueue<Integer> queue = new RandomizedQueue<Integer>();
        for (int i = 0; i < 10; i++) {
            queue.enqueue(i);
        }
        Iterator<Integer> iterator = queue.iterator();
        Iterator<Integer> iterator2 = queue.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next() + " " + iterator2.next());
        }
        for (int i = 0; i < 10; i++) {
            queue.dequeue();
        }
        System.out.println(queue.size());
    }
}
