import java.awt.Color;

public class SeamCarver {

    private final double BORDER_ENERGY = 195075.0;

    private int[][] colors;
    private double[][] distTo;
    private short[][] edgeTo;
    private int width;
    private int height;

    public SeamCarver(Picture picture) {
        width = picture.width();
        height = picture.height();

        colors = new int[width][height];
        edgeTo = new short[width][height];
        distTo = new double[width][height];

        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                colors[i][j] = picture.get(i, j).getRGB();
            }
        }
    }

    public Picture picture() {
        Picture pic = new Picture(width, height);
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                pic.set(i, j, new Color(colors[i][j]));
            }
        }
        return pic;
    }

    public int width() {
        return width;
    }

    public int height() {
        return height;
    }

    public double energy(int x, int y) {
        if ((y >= 0 && y < height && (x == 0 || x == width - 1))
                || (x >= 0 && x < width && (y == 0 || y == height - 1))) {
            // this is an energy of pixel at the border of the picture
            return BORDER_ENERGY;
        }
        int cx1 = colors[x - 1][y];
        int cx2 = colors[x + 1][y];
        int cy1 = colors[x][y - 1];
        int cy2 = colors[x][y + 1];

        return gradient(cx1, cx2) + gradient(cy1, cy2);
    }

    public int[] findVerticalSeam() {
        initSearch();

        for (short j = 0; j < height - 1; j++) {
            for (short i = 1; i < width - 1; i++) {
                relax(i, j, i - 1, j + 1, i);
                relax(i, j, i, j + 1, i);
                relax(i, j, i + 1, j + 1, i);
            }
        }

        double min = Double.MAX_VALUE;
        int end = 0;
        for (int i = 1; i < width - 1; i++) {
            if (distTo[i][height - 1] < min) {
                min = distTo[i][height - 1];
                end = i;
            }
        }

        int[] path = new int[height];
        for (int j = height - 1; j >= 0; j--) {
            path[j] = end;
            end = edgeTo[end][j];
        }

        return path;
    }
    public int[] findHorizontalSeam() {
        initSearch();

        for (short i = 0; i < width - 1; i++) {
            for (short j = 1; j < height - 1; j++) {
                relax(i, j, i + 1, j - 1, j);
                relax(i, j, i + 1, j, j);
                relax(i, j, i + 1, j + 1, j);
            }
        }

        double min = Double.MAX_VALUE;
        int end = 0;
        for (int j = 1; j < height - 1; j++) {
            if (distTo[width - 1][j] < min) {
                min = distTo[width - 1][j];
                end = j;
            }
        }

        int[] path = new int[width];
        for (int i = width - 1; i >= 0; i--) {
            path[i] = end;
            end = edgeTo[i][end];
        }

        return path;
    }
    public void removeHorizontalSeam(int[] a) {
        checkPicture();
        checkSeam(a, false);
        removeHSeam(a);
        height--;
    }

    public void removeVerticalSeam(int[] a) {
        checkPicture();
        checkSeam(a, true);
        removeVSeam(a);
        width--;
    }

    private void relax(int pi, int pj, int i, int j, short edge) {
        double dis = distTo[pi][pj] + energy(i, j);
        if (dis < distTo[i][j]) {
            distTo[i][j] = dis;
            edgeTo[i][j] = edge;
        }
    }

    private void initSearch() {
        for (int i = 0; i < width; i++) {
            distTo[i][0] = BORDER_ENERGY;
            edgeTo[i][0] = 0;
        }
        for (int j = 0; j < height; j++) {
            distTo[0][j] = BORDER_ENERGY;
            edgeTo[0][j] = 0;
        }
        for (int j = 1; j < height; j++) {
            for (int i = 1; i < width; i++) {
                distTo[i][j] = Double.MAX_VALUE;
                edgeTo[i][j] = -1;
            }
        }
    }

    private int getRed(int rgb) {
        return (rgb >> 16) & 0xFF;
    }

    private int getGreen(int rgb) {
        return (rgb >> 8) & 0xFF;
    }

    private int getBlue(int rgb) {
        return (rgb >> 0) & 0xFF;
    }

    private int gradient(int rgb1, int rgb2) {
        int r = getRed(rgb2) - getRed(rgb1);
        int g = getGreen(rgb2) - getGreen(rgb1);
        int b = getBlue(rgb2) - getBlue(rgb1);

        return r * r + g * g + b * b;
    }

    private void checkPicture() {
        if (width <= 1 || height <= 1) {
            throw new IllegalArgumentException("Incorrect picture size");
        }
    }

    private void checkSeam(int[] seam, boolean isVertical) {
        int border = width;
        int seamMaxValue = height - 1;
        if (isVertical) {
            border = height;
            seamMaxValue = width - 1;
        }
        if (seam.length != border) {
            throw new IllegalArgumentException("Incorrect seam length");
        }

        int prev = seam[0];
        for (int i : seam) {
            if (i < 0 || i > seamMaxValue) {
                throw new IllegalArgumentException("Seam's value is out of range: " + i);
            }
            if (Math.abs(i - prev) > 1) {
                throw new IllegalArgumentException("Seam is incorrect: neighbour values shoud not differ more than 1");
            }
            prev = i;
        }
    }

    private void removeVSeam(int[] seam) {
        int[][] tempColors = colors;
        colors = new int[width - 1][height];

        int index = 0;
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width - 1; j++) {
                index = j;
                if (j >= seam[i]) {
                    index = j + 1;
                }
                colors[j][i] = tempColors[index][i];
            }
        }
    }

    private void removeHSeam(int[] seam) {
        int[][] tempColors = colors;
        colors = new int[width][height - 1];

        for (int i = 0; i < width; i++) {
            System.arraycopy(tempColors[i], 0, colors[i], 0, seam[i]);
            System.arraycopy(tempColors[i], seam[i] + 1, colors[i], seam[i], height - seam[i] - 1);
        }
    }

    /**
     * Tests are going here.
     */
    public static void main(String[] str) {
        final String testArtifactsPath = "seamCarving/";

        SeamCarver s1 = new SeamCarver(new Picture(testArtifactsPath + "3x7.png"));
        SeamCarver s2 = new SeamCarver(new Picture(testArtifactsPath + "4x6.png"));
        SeamCarver s3 = new SeamCarver(new Picture(testArtifactsPath + "5x6.png"));
        SeamCarver s4 = new SeamCarver(new Picture(testArtifactsPath + "7x3.png"));
        SeamCarver s5 = new SeamCarver(new Picture(testArtifactsPath + "10x12.png"));
        SeamCarver s6 = new SeamCarver(new Picture(testArtifactsPath + "12x10.png"));
        SeamCarver s7 = new SeamCarver(new Picture(testArtifactsPath + "HJocean.png"));
        SeamCarver s8 = new SeamCarver(new Picture(testArtifactsPath + "HJoceanTransposed.png"));

        checkVerticalSeam(s1, 779648);
        checkVerticalSeam(s2, 515069);
        checkVerticalSeam(s3, 553706);
        checkVerticalSeam(s4, 438090);
        checkVerticalSeam(s5, 652800);
        checkVerticalSeam(s6, 615883);
        checkVerticalSeam(s7, 416943);
        checkVerticalSeam(s8, 393911);

        checkHorizontalSeam(s1, 445925);
        checkHorizontalSeam(s2, 450155);
        checkHorizontalSeam(s3, 523752);
        checkHorizontalSeam(s4, 722403);
        checkHorizontalSeam(s5, 644531);
        checkHorizontalSeam(s6, 758290);
        checkHorizontalSeam(s7, 392937);
        checkHorizontalSeam(s8, 418586);

        s1.removeVerticalSeam(s1.findVerticalSeam());
        s1.findVerticalSeam();
    }

    private static int getTotalEnergyVerticalSeam(SeamCarver seamCarver) {
        int[] verticalSeam = seamCarver.findVerticalSeam();
        int total = 0;
        for (int j = 0; j < seamCarver.height(); j++) {
            for (int i = 0; i < seamCarver.width(); i++) {
                if (verticalSeam[j] == i) {
                    total += seamCarver.energy(i, j);
                }
            }
        }
        return total;
    }

    private static int getTotalEnergyHorizontalSeam(SeamCarver seamCarver) {
        int[] horizontalSeam = seamCarver.findHorizontalSeam();
        int total = 0;
        for (int j = 0; j < seamCarver.height(); j++) {
            for (int i = 0; i < seamCarver.width(); i++) {
                if (horizontalSeam[i] == j) {
                    total += seamCarver.energy(i, j);
                }
            }
        }
        return total;
    }

    private static void checkVerticalSeam(SeamCarver s, int expectedSize) {
        assert getTotalEnergyVerticalSeam(s) == expectedSize;
    }

    private static void checkHorizontalSeam(SeamCarver s, int expectedSize) {
        assert getTotalEnergyHorizontalSeam(s) == expectedSize;
    }
}