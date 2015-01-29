public class Board {

    private int BLANK_VALUE = 0;

    private int N;
    private char[][] tiles;

    private int blank_i;
    private int blank_j;

    private int manhattan;
    private int hamming;
    private boolean isGoal;

    public Board(int[][] b) {
        char[][] temp = new char[b.length][b.length];
        for (int i = 0; i < b.length; i++) {
            for (int j = 0; j < b.length; j++) {
                temp[i][j] = (char) b[i][j];
            }
        }
        init(temp);
    }

    private Board(char[][] b) {
        init(b);
    }

    private void init(char[][] b) {
        N = b.length;
        tiles = b;
        isGoal = true;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (tiles[i][j] == BLANK_VALUE) {
                    blank_i = i;
                    blank_j = j;
                } else {
                    // cache priorities
                    manhattan += manhattan(tiles[i][j], i, j);
                    if (tiles[i][j] != goal(i, j)) {
                        hamming++;
                    }
                }
                if (tiles[i][j] != goal(i, j)) {
                    isGoal = false;
                }
            }
        }
    }


    public int dimension() {
        return N;
    }

    private int goal(int i, int j) {
        if (i == N - 1 && j == N - 1) {
            return BLANK_VALUE;
        }

        return i * N + j + 1;
    }

    private int manhattan(int tile, int ci, int cj) {
        int i, j;
        if (tile == BLANK_VALUE) {
            i = N - 1;
            j = N - 1;
        } else {
            i = (tile - 1) / N;
            j = tile - i * N - 1;
        }
        return Math.abs(i - ci) + Math.abs(j - cj);
    }

    private char[][] cloneTiles() {
        char[][] clone = new char[N][N];
        for (int i = 0; i < N; i++) {
            System.arraycopy(tiles[i], 0, clone[i], 0, N);
        }
        return clone;
    }

    public int hamming() {
        return hamming;
    }

    public int manhattan() {
        return manhattan;
    }

    public boolean isGoal() {
        return isGoal;
    }

    public Board twin() {
        char[][] clone = cloneTiles();

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N - 1; j++) {
                if (clone[i][j] != BLANK_VALUE && clone[i][j + 1] != BLANK_VALUE) {
                    char temp = clone[i][j];
                    clone[i][j] = clone[i][j + 1];
                    clone[i][j + 1] = temp;
                    return new Board(clone);
                }
            }
        }
        return null;
    }

    @Override
    public boolean equals(Object x) {
        if (x == null) {
            return false;
        }
        if (x.getClass() != this.getClass()) {
            return false;
        }

        Board that = (Board) x;
        if (that.dimension() != N) {
            return false;
        }

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (this.tiles[i][j] != that.tiles[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }

    public Iterable<Board> neighbors() {
        Queue<Board> q = new Queue<Board>();

        short[][] d = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}};
        for (int i = 0; i < 4; i++) {
            int dx = blank_i + d[i][0];
            int dy = blank_j + d[i][1];
            if (dx >= 0 && dx < N && dy >= 0 && dy < N) {
                char[][] clone = cloneTiles();
                char temp = clone[blank_i][blank_j];
                clone[blank_i][blank_j] = clone[dx][dy];
                clone[dx][dy] = temp;
                q.enqueue(new Board(clone));
            }
        }
        return q;
    }

    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();
        s.append(N).append("\n");
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                s.append(String.format("%2d ", (int) tiles[i][j]));
            }
            s.append("\n");
        }
        return s.toString();
    }

    public static void main(String[] str) {
        int[][] a = {{8, 1, 3}, {4, 0, 2}, {7, 6, 5}};
        Board b = new Board(a);
        System.out.println(b.manhattan());
        System.out.println(b.hamming());
        System.out.println(b.isGoal());
        System.out.println(b.twin());
        System.out.println(b);

        System.out.println("-------------");
        for (Board board : b.neighbors()) {
            System.out.println(board);
        }
    }
}
