public class Percolation {
    private int size;
    private int topVSite;
    private int bottomVSite;

    private WeightedQuickUnionUF quickUnionUF;
    private WeightedQuickUnionUF quickUnionUFBackwash;
    private boolean[] grid;

    public Percolation(int N) {
        this.size = N;
        this.topVSite = 0;
        this.bottomVSite = size * size + 1;

        quickUnionUF = new WeightedQuickUnionUF((N * N) + 2);
        quickUnionUFBackwash = new WeightedQuickUnionUF((N * N) + 1);
        grid = new boolean[N * N];
    }

    private int xyTo1D(int x, int y) {
        return (x - 1) * size + y;
    }

    private void validate(int i, int j) {
        if (i <= 0 || i > size) throw new IndexOutOfBoundsException("row index i out of bounds");
        if (j <= 0 || j > size) throw new IndexOutOfBoundsException("row index j out of bounds");
    }

    public void open(int i, int j) {
        validate(i, j);
        int openSiteNumber = xyTo1D(i, j);
        if (!grid[openSiteNumber - 1]) {
            grid[openSiteNumber - 1] = true;

            int neighbours[][] = {{i, j - 1}, {i, j + 1}, {i - 1, j}, {i + 1, j}};
            for (int[] neighbour : neighbours) {
                int x = neighbour[0];
                int y = neighbour[1];

                if (y > 0 && y <=size){
                    if (x > 0 && x <= size && isOpen(x, y)){
                        quickUnionUF.union(openSiteNumber, xyTo1D(x, y));
                        quickUnionUFBackwash.union(openSiteNumber, xyTo1D(x, y));
                    }else if (x == 0){
                        quickUnionUF.union(openSiteNumber, topVSite);
                        quickUnionUFBackwash.union(openSiteNumber, topVSite);
                    }else if (x == size + 1){
                        quickUnionUF.union(openSiteNumber, bottomVSite);
                    }
                }
            }
        }
    }

    public boolean isOpen(int i, int j) {
        validate(i, j);
        return grid[xyTo1D(i, j) - 1];
    }

    public boolean isFull(int i, int j) {
        validate(i, j);
        return quickUnionUFBackwash.connected(xyTo1D(i, j), topVSite);
    }

    public boolean percolates() {
        return quickUnionUF.connected(topVSite, bottomVSite);
    }
}
