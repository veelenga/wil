public class Solver {

    private SearchNode node;
    private Stack<Board> solution;
    private int moves;
    private boolean isSolvable;

    private class SearchNode implements Comparable<SearchNode> {
        short moves;
        short priority;
        Board board;
        SearchNode previous;

        public SearchNode(Board current, SearchNode previous) {
            this.board = current;
            this.previous = previous;
            if (previous == null) {
                moves = 0;
            } else {
                moves = (short) (previous.moves + 1);
            }
            this.priority = (short) (current.manhattan() + moves);
        }

        @Override
        public int compareTo(SearchNode o) {
            return this.priority - o.priority;
        }

        @Override
        public String toString() {
            StringBuilder s = new StringBuilder();
            s.append("priority  = ").append(priority).append("\n");
            s.append("moves     = ").append(moves).append("\n");
            s.append("manhattan = ").append(board.manhattan()).append("\n");
            s.append(board);

            return s.toString();
        }
    }

    public Solver(Board board) {
        MinPQ<SearchNode> pq = new MinPQ<SearchNode>();
        pq.insert(new SearchNode(board, null));

        MinPQ<SearchNode> pqTwin = new MinPQ<SearchNode>();
        SearchNode twinNode = new SearchNode(board.twin(), null);
        pqTwin.insert(twinNode);

        while (true) {

            node = pq.delMin();
            twinNode = pqTwin.delMin();

            if (node.board.isGoal()) {
                break;
            }
            if (twinNode.board.isGoal()) {
                node = null;
                break;
            }
            insertNeighbors(pq, node);
            insertNeighbors(pqTwin, twinNode);
        }

        if (node == null) {
            moves = -1;
            isSolvable = false;
        } else {
            moves = node.moves;
            solution = new Stack<Board>();
            while (node != null) {
                solution.push(node.board);
                node = node.previous;
            }
            isSolvable = true;
        }
    }

    private void insertNeighbors(MinPQ<SearchNode> queue, SearchNode node) {
        for (Board b : node.board.neighbors()) {
            if (node.previous != null) {
                if (!b.equals(node.previous.board)) {
                    queue.insert(new SearchNode(b, node));
                }
            } else {
                queue.insert(new SearchNode(b, node));
            }
        }
    }

    public int moves() {
        return moves;
    }

    public boolean isSolvable() {
        return isSolvable;
    }

    public Iterable<Board> solution() {
        return solution;
    }

    public static void main(String[] args) {
        // create initial board from file
        String filename = args[0];
        In in = new In(filename);
        int N = in.readInt();
        int[][] blocks = new int[N][N];
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                blocks[i][j] = in.readInt();
        Board initial = new Board(blocks);

        // solve the puzzle
        Solver solver = new Solver(initial);

        // print solution to standard output
        if (!solver.isSolvable())
            StdOut.println("No solution possible");
        else {
            StdOut.println("Minimum number of moves = " + solver.moves());
            for (Board board : solver.solution())
                StdOut.println(board);
        }
    }
}
