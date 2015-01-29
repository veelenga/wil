public class PercolationStats {
    private int T;
    private double mean;
    private double stddev;

    public PercolationStats(int N, int T) {
        if (N <= 0) throw new IllegalArgumentException("N is less than 0");
        if (T <= 0) throw new IllegalArgumentException("T is less than 0");

        this.T = T;

        double[] thresholds = new double[T];
        for (int i = 0; i < T; i++) {
            Percolation percolation = new Percolation(N);
            int numberSiteOpened = 0;
            while (!percolation.percolates()) {
                int x = StdRandom.uniform(1, N + 1);
                int y = StdRandom.uniform(1, N + 1);
                if (!percolation.isOpen(x, y)) {
                    percolation.open(x, y);
                    numberSiteOpened++;
                }
            }
            thresholds[i] = (double) numberSiteOpened / (N * N);
        }

        double sum = 0;
        for (double threshold : thresholds) {
            sum += threshold;
        }
        mean = sum / T;

        sum = 0;
        for (double threshold : thresholds) {
            sum += (threshold - mean) * (threshold - mean);
        }
        stddev = Math.sqrt(sum / (T - 1));
    }

    public double mean() {
        return mean;
    }

    public double stddev() {
        return stddev;
    }

    public double confidenceLo() {
        return mean - (1.96 * stddev / Math.sqrt(T));
    }

    public double confidenceHi() {
        return mean + (1.96 * stddev / Math.sqrt(T));
    }


    public static void main(String[] args) {
        if (args.length != 2){
            System.exit(-1);
        }
        int N = Integer.parseInt(args[0]);
        int T = Integer.parseInt(args[1]);

        PercolationStats stats = new PercolationStats(N, T);
        StdOut.printf("%s %20s %s%n", "mean", "=", Double.toString(stats.mean()));
        StdOut.printf("%s %18s %s%n", "stddev", "=", Double.toString(stats.stddev()));
        StdOut.printf("%s %s, %s%n", "95% confidence interval =",
                Double.toString(stats.confidenceLo()),
                Double.toString(stats.confidenceHi()));
    }
}
