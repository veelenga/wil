public class JobInterview_q2 {
    private int[] id;    // id[i] = parent of i
    private int[] sz;    // sz[i] = number of objects in subtree rooted at i
    private int[] le;

    public JobInterview_q2(int N) {
        id = new int[N];
        sz = new int[N];
        le = new int[N];
        for (int i = 0; i < N; i++) {
            id[i] = i;
            sz[i] = 1;
            le[i] = i;
        }
    }

    public int find(int p) {
        int root = findOriginal(p);
        return le[root];
    }

    private int findOriginal(int p) {
        while (p != id[p])
            p = id[p];
        return p;
    }

    public void union(int p, int q) {
        int rootP = findOriginal(p);
        int rootQ = findOriginal(q);
        if (rootP == rootQ) return;

        if (sz[rootP] < sz[rootQ]) {
            id[rootP] = rootQ;
            sz[rootQ] += sz[rootP];
            le[rootQ] = Math.max(le[rootP], le[rootQ]);
        } else {
            id[rootQ] = rootP;
            sz[rootP] += sz[rootQ];
            le[rootP] = Math.max(le[rootP], le[rootQ]);
        }
    }


    public static void main(String[] args) {
        JobInterview_q2 job = new JobInterview_q2(10);
        job.union(1, 2);
        job.union(1, 8);

        job.union(3, 4);
        job.union(3, 6);
        job.union(4, 5);

        job.union(1, 4);
        System.out.println(job.find(1));
        System.out.println(job.find(2));
        System.out.println(job.find(3));
        System.out.println(job.find(4));
        System.out.println(job.find(5));
        System.out.println(job.find(6));
        System.out.println(job.find(8));
    }
}
